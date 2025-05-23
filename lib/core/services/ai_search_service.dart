import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';

class AISearchService {
  static AISearchService? _instance;
  final FirebaseFirestore _firestore;
  final ApiService _apiService;
  Timer? _debounceTimer;
  final Duration _debounceTime = const Duration(milliseconds: 500);
  bool _isInitialized = false;
  final Map<String, List<Map<String, dynamic>>> _memoryCache = {};
  final int _maxMemoryCacheSize = 50;
  final Duration _memoryCacheDuration = const Duration(minutes: 5);
  final Map<String, DateTime> _memoryCacheTimestamps = {};
  final Set<String> _searchSuggestions = {};
  String? _lastQuery;
  bool _isSearching = false;

  // Private constructor for singleton pattern
  AISearchService._({
    required FirebaseFirestore firestore,
    required ApiService apiService,
  })  : _firestore = firestore,
        _apiService = apiService;

  // Factory constructor for singleton pattern
  factory AISearchService({
    FirebaseFirestore? firestore,
    ApiService? apiService,
  }) {
    _instance ??= AISearchService._(
      firestore: firestore ?? FirebaseFirestore.instance,
      apiService: apiService ?? ApiService(),
    );
    return _instance!;
  }

  // Initialize the service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await _preloadPopularSearches();
      await _loadSearchSuggestions();
      _isInitialized = true;
    } catch (e) {
      print('Error initializing AISearchService: $e');
    }
  }

  Future<void> _preloadPopularSearches() async {
    try {
      // Preload only essential data
      final popularSearches = ['phone', 'laptop', 'headphones'];
      for (final query in popularSearches) {
        _getCachedResults(query).then((results) {
          if (results.isNotEmpty) {
            _addToMemoryCache(query, results);
          }
        });
      }
    } catch (e) {
      print('Error preloading searches: $e');
    }
  }

  Future<void> _loadSearchSuggestions() async {
    try {
      // Load common product names and categories for suggestions
      final response = await _apiService.get(
        endpoint: BackendEndpoints.aiProductSearch,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          _searchSuggestions.addAll(data.map((item) => item.toString().toLowerCase()));
        } else if (data is Map) {
          final suggestions = data['suggestions'] ?? data['products'] ?? [];
          if (suggestions is List) {
            _searchSuggestions.addAll(suggestions.map((item) => item.toString().toLowerCase()));
          }
        }
      }
    } catch (e) {
      print('Error loading search suggestions: $e');
    }
  }

  List<String> getSuggestions(String query) {
    if (query.isEmpty) return [];
    
    final normalizedQuery = query.toLowerCase().trim();
    return _searchSuggestions
        .where((suggestion) => suggestion.startsWith(normalizedQuery))
        .take(5)
        .toList();
  }
  Future<List<String>> fetchLiveSuggestions(String query) async {
  if (query.isEmpty) return [];

  try {
    final response = await _apiService.post(
      endpoint: BackendEndpoints.aiProductSearch,
      body: {
        'query': query,
        'searchType': 'prefix',
        'suggestOnly': true, // Optional: backend support
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is List) {
        return List<String>.from(data.map((e) => e.toString()));
      } else if (data is Map) {
        final suggestions = data['suggestions'] ?? data['products'] ?? [];
        if (suggestions is List) {
          return List<String>.from(suggestions.map((e) => e.toString()));
        }
      }
    }
    return [];
  } catch (e) {
    print('Suggestion error: $e');
    return [];
  }
}


  void _addToMemoryCache(String query, List<Map<String, dynamic>> results) {
    // Clean up old cache entries
    _cleanupMemoryCache();

    // Add new results to cache
    _memoryCache[query] = results;
    _memoryCacheTimestamps[query] = DateTime.now();
  }

  void _cleanupMemoryCache() {
    final now = DateTime.now();
    final expiredKeys = _memoryCacheTimestamps.entries
        .where((entry) => now.difference(entry.value) > _memoryCacheDuration)
        .map((entry) => entry.key)
        .toList();

    // Remove expired entries
    for (final key in expiredKeys) {
      _memoryCache.remove(key);
      _memoryCacheTimestamps.remove(key);
    }

    // If still too many entries, remove oldest
    if (_memoryCache.length > _maxMemoryCacheSize) {
      final entries = _memoryCacheTimestamps.entries.toList();
      entries.sort((a, b) => a.value.compareTo(b.value));
      final sortedKeys = entries.map((e) => e.key).toList();

      final keysToRemove = sortedKeys.take(_memoryCache.length - _maxMemoryCacheSize);
      for (final key in keysToRemove) {
        _memoryCache.remove(key);
        _memoryCacheTimestamps.remove(key);
      }
    }
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    if (!_isInitialized) {
      await initialize();
    }

    // Return empty list for empty queries
    if (query.trim().isEmpty) {
      _lastQuery = null;
      return [];
    }

    // Normalize query
    final normalizedQuery = query.toLowerCase().trim();
    if (normalizedQuery == _lastQuery && _isSearching) {
      return [];
    }
    _debounceTimer?.cancel();
    return Future.delayed(_debounceTime, () async {
      if (normalizedQuery != query.toLowerCase().trim()) {
        return [];
      }
      _lastQuery = normalizedQuery;
      _isSearching = true;
      try {
        final cacheKey = normalizedQuery.replaceAll(RegExp(r'[^a-z0-9]'), '_');
        if (_memoryCache.containsKey(cacheKey)) {
          final cachedResults = _memoryCache[cacheKey]!;
          final timestamp = _memoryCacheTimestamps[cacheKey]!;
          if (DateTime.now().difference(timestamp) <= _memoryCacheDuration) {
            _isSearching = false;
            return _scoreAndSortResults(cachedResults, query);
          }
        }
        if (!_searchSuggestions.contains(normalizedQuery)) {
          _searchSuggestions.add(normalizedQuery);
        }
        final response = await _apiService.post(
          endpoint: BackendEndpoints.aiProductSearch,
          body: {
            'query': normalizedQuery,
            'limit': 20,
            'includeMetadata': true,
            'searchType': 'prefix',
          },
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          List<dynamic> products = [];
          // Bulletproof parsing:
          if (data is List) {
            products = data;
          } else if (data is Map<String, dynamic>) {
            if (data.containsKey('products') && data['products'] is List) {
              products = data['products'];
            } else if (data.containsKey('data') && data['data'] is List) {
              products = data['data'];
            } else if (data.containsKey('items') && data['items'] is List) {
              products = data['items'];
            } else if (data.containsKey('result')) {
              final result = data['result'];
              if (result is List) {
                products = result;
              } else if (result is Map) {
                products = [result];
              }
            } else if (data.containsKey('searchResults')) {
              final results = data['searchResults'];
              if (results is List) {
                products = results;
              } else if (results is Map) {
                products = [results];
              }
            } else if (data.isNotEmpty) {
              // If it's a single product map, wrap it in a list
              products = [data];
            }
          }
          if (products.isEmpty) {
            _isSearching = false;
            return [];
          }
          final results = products.map((product) {
            if (product is! Map<String, dynamic>) {
              return {
                'id': '',
                'title': 'Invalid Product',
                'description': 'Invalid product data',
                'price': 0.0,
                'image': '',
                'rating': 0.0,
                'brand': '',
                'category': '',
                'inStock': false,
                'discount': 0.0,
                'originalPrice': 0.0,
              };
            }
            final title = product['name']?.toString() ?? 
                         product['title']?.toString() ?? 
                         'No Title';
            if (!_searchSuggestions.contains(title.toLowerCase())) {
              _searchSuggestions.add(title.toLowerCase());
            }
            return {
              'id': product['id']?.toString() ?? '',
              'title': title,
              'description': product['description']?.toString() ?? 'No Description',
              'price': _parseDouble(product['price']),
              'image': product['imageUrl']?.toString() ?? 
                      product['image']?.toString() ?? 
                      '',
              'rating': _parseDouble(product['rating']),
              'brand': product['brand']?.toString() ?? '',
              'category': product['category']?.toString() ?? '',
              'inStock': product['inStock'] as bool? ?? true,
              'discount': _parseDouble(product['discount']),
              'originalPrice': _parseDouble(product['originalPrice']),
            };
          }).toList();
          _addToMemoryCache(cacheKey, results);
          await _cacheResults(cacheKey, results);
          _isSearching = false;
          return _scoreAndSortResults(results, query);
        } else {
          print('API Error: ${response.statusCode} - ${response.body}');
          final cachedResults = await _getCachedResults(cacheKey);
          if (cachedResults.isNotEmpty) {
            _addToMemoryCache(cacheKey, cachedResults);
            _isSearching = false;
            return _scoreAndSortResults(cachedResults, query);
          }
          _isSearching = false;
          throw Exception('Failed to search products: ${response.body}');
        }
      } catch (e) {
        print('Error searching products: $e');
        final cachedResults = await _getCachedResults(normalizedQuery.replaceAll(RegExp(r'[^a-z0-9]'), '_'));
        if (cachedResults.isNotEmpty) {
          _addToMemoryCache(normalizedQuery.replaceAll(RegExp(r'[^a-z0-9]'), '_'), cachedResults);
          _isSearching = false;
          return _scoreAndSortResults(cachedResults, query);
        }
        _isSearching = false;
        return [];
      }
    });
  }

  double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return 0.0;
      }
    }
    return 0.0;
  }

  List<Map<String, dynamic>> _scoreAndSortResults(List<Map<String, dynamic>> results, String query) {
    final queryTerms = query.toLowerCase().split(' ');
    
    return results.map((result) {
      double score = 0.0;
      final title = (result['title'] ?? '').toString().toLowerCase();
      final description = (result['description'] ?? '').toString().toLowerCase();
      final brand = (result['brand'] ?? '').toString().toLowerCase();
      final category = (result['category'] ?? '').toString().toLowerCase();
      
      for (final term in queryTerms) {
        if (title.contains(term)) score += 3.0;
        if (description.contains(term)) score += 1.0;
        if (brand.contains(term)) score += 2.0;
        if (category.contains(term)) score += 1.5;
      }
      
      if (title.contains(query.toLowerCase())) score += 4.0;
      
      if (result['rating'] != null) {
        score += (result['rating'] as num) * 0.5;
      }

      if (result['inStock'] == true) {
        score += 1.0;
      }

      if (result['discount'] != null && result['discount'] > 0) {
        score += (result['discount'] as num) * 0.2;
      }
      
      return {
        ...result,
        '_score': score,
      };
    }).toList()
      ..sort((a, b) => (b['_score'] as double).compareTo(a['_score'] as double));
  }

  Future<List<Map<String, dynamic>>> _getCachedResults(String cacheKey) async {
    try {
      final docRef = _firestore.collection('search_cache').doc(cacheKey);
      final doc = await docRef.get();
      
      if (doc.exists) {
        final data = doc.data()!;
        final timestamp = (data['timestamp'] as Timestamp).toDate();
        
        if (DateTime.now().difference(timestamp).inHours < 24) {
          final List<dynamic> products = data['results'] ?? [];
          return products.map((product) => Map<String, dynamic>.from(product)).toList();
        } else {
          await docRef.delete();
        }
      }
      return [];
    } catch (e) {
      print('Error getting cached results: $e');
      return [];
    }
  }

  Future<void> _cacheResults(String cacheKey, List<dynamic> results) async {
    try {
      final docRef = _firestore.collection('search_cache').doc(cacheKey);
      await docRef.set({
        'query': cacheKey,
        'results': results,
        'timestamp': FieldValue.serverTimestamp(),
        'metadata': {
          'resultCount': results.length,
          'cachedAt': DateTime.now().toIso8601String(),
        },
      });
    } catch (e) {
      print('Error caching results: $e');
    }
  }

  Future<void> clearCache() async {
    try {
      _memoryCache.clear();
      _memoryCacheTimestamps.clear();
      
      final snapshot = await _firestore.collection('search_cache').get();
      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
    _memoryCache.clear();
    _memoryCacheTimestamps.clear();
  }
} 