import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AISearchService {
  static AISearchService? _instance;
  final FirebaseFirestore _firestore;
  final ApiService _apiService;
  Timer? _debounceTimer;
  final Duration _debounceTime = const Duration(milliseconds: 300);
  bool _isInitialized = false;
  final Map<String, List<Map<String, dynamic>>> _memoryCache = {};
  final int _maxMemoryCacheSize = 100;
  final Duration _memoryCacheDuration = const Duration(minutes: 30);
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
      await Future.wait([
        _preloadPopularSearches(),
        _loadSearchSuggestions(),
      ]);
      _isInitialized = true;
    } catch (e) {
      print('Error initializing AI search service: $e');
    }
  }

  Future<void> _preloadPopularSearches() async {
    try {
      // Get popular searches from backend AI
      final response = await _apiService.get(
        endpoint: BackendEndpoints.aiProductSearch,
        queryParameters: {'type': 'popular'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          _searchSuggestions.addAll(data.map((item) => item.toString().toLowerCase()));
        } else if (data is Map) {
          final popularSearches = data['popular'] ?? data['suggestions'] ?? [];
          if (popularSearches is List) {
            _searchSuggestions.addAll(popularSearches.map((item) => item.toString().toLowerCase()));
          }
        }
      }
    } catch (e) {
      print('Error preloading searches: $e');
    }
  }

  Future<void> _loadSearchSuggestions() async {
    try {
      // Get AI-generated suggestions based on product catalog
      final response = await _apiService.get(
        endpoint: BackendEndpoints.aiProductSearch,
        queryParameters: {'type': 'suggestions'},
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
      print('🔍 Fetching suggestions for: $query');
      
      final response = await _apiService.post(
        endpoint: BackendEndpoints.aiProductSearch,
        body: {
          'query': query,
          'type': 'suggestions',
          'context': {
            'userHistory': (await _getUserSearchHistory()).take(5).toList(), // Limit history to 5 items
            'popularSearches': _searchSuggestions.take(5).toList(), // Limit suggestions to 5 items
          },
        },
      );

      print('📥 Received suggestions response: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          print('📦 Parsed suggestions data type: ${data.runtimeType}');
          
          List<String> suggestions = [];

          if (data is Map) {
            print('📦 Suggestions response keys: ${data.keys.toList()}');
            
            if (data.containsKey('products') && data['products'] is List) {
              final products = data['products'] as List;
              print('📦 Found ${products.length} products for suggestions');
              
              suggestions = products.where((product) {
                if (product is! Map) {
                  print('❌ Invalid product format in suggestions: $product');
                  return false;
                }
                
                final title = product['title']?.toString();
                if (title == null || title.isEmpty) {
                  print('❌ Product missing title in suggestions: $product');
                  return false;
                }
                
                return true;
              }).map((product) => product['title'].toString()).take(5).toList(); // Limit to 5 suggestions
              
              print('✅ Filtered to ${suggestions.length} valid suggestions');
            } else if (data.containsKey('suggestions') && data['suggestions'] is List) {
              suggestions = List<String>.from(data['suggestions']).take(5).toList(); // Limit to 5 suggestions
            }
          } else if (data is List) {
            suggestions = List<String>.from(data.map((e) => e.toString())).take(5).toList(); // Limit to 5 suggestions
          }

          return suggestions;
        } catch (e, stackTrace) {
          print('❌ Error parsing suggestions response: $e');
          print('❌ Stack trace: $stackTrace');
          print('❌ Raw suggestions response body: ${response.body}');
        }
      } else {
        print('❌ Suggestions failed with status: ${response.statusCode}');
        print('❌ Error response: ${response.body}');
      }
      
      return [];
    } catch (e, stackTrace) {
      print('❌ Error fetching suggestions: $e');
      print('❌ Stack trace: $stackTrace');
      return [];
    }
  }

  Future<List<String>> _getUserSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList('search_history') ?? [];
    } catch (e) {
      print('Error getting search history: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (query.trim().isEmpty) {
      _lastQuery = null;
      return [];
    }

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
        print('🔍 Searching for: $query');
        
        // Check memory cache first
        final cacheKey = normalizedQuery.replaceAll(RegExp(r'[^a-z0-9]'), '_');
        if (_memoryCache.containsKey(cacheKey)) {
          final cachedResults = _memoryCache[cacheKey]!;
          final timestamp = _memoryCacheTimestamps[cacheKey]!;
          if (DateTime.now().difference(timestamp) <= _memoryCacheDuration) {
            print('📦 Using cached results for: $query');
            _isSearching = false;
            return _scoreAndSortResults(cachedResults, query);
          }
        }

        // Get AI-powered search results
        print('🌐 Making API request for: $query');
        final response = await _apiService.post(
          endpoint: BackendEndpoints.aiProductSearch,
          body: {
            'query': query,
            'type': 'search',
            'context': {
              'userHistory': (await _getUserSearchHistory()).take(5).toList(), // Limit history to 5 items
              'popularSearches': _searchSuggestions.take(5).toList(), // Limit suggestions to 5 items
            },
          },
        );

        print('📥 Received response: ${response.statusCode}');
        
        if (response.statusCode == 200) {
          try {
            final data = jsonDecode(response.body);
            print('📦 Parsed response data type: ${data.runtimeType}');
            
            List<Map<String, dynamic>> results = [];

            if (data is Map) {
              print('📦 Response keys: ${data.keys.toList()}');
              
              if (data.containsKey('products') && data['products'] is List) {
                final products = data['products'] as List;
                print('📦 Found ${products.length} products in response');
                
                results = products.where((product) {
                  if (product is! Map) {
                    print('❌ Invalid product format: $product');
                    return false;
                  }
                  
                  final title = product['title']?.toString();
                  if (title == null || title.isEmpty) {
                    print('❌ Product missing title: $product');
                    return false;
                  }
                  
                  return true;
                }).map((product) {
                  // Only keep essential fields to reduce data size
                  return {
                    'id': product['_id'],
                    'title': product['title'],
                    'price': product['price'],
                    'images': product['images'] ?? [],
                    'rating': product['rating'] ?? 0,
                    'reviewCount': product['ratingsQuantity'] ?? 0,
                  };
                }).toList();
                
                print('✅ Filtered to ${results.length} valid products');
              } else if (data.containsKey('results') && data['results'] is List) {
                results = List<Map<String, dynamic>>.from(data['results']);
              }
            } else if (data is List) {
              results = List<Map<String, dynamic>>.from(data);
            }

            // Cache results
            _addToMemoryCache(cacheKey, results);
            await _cacheResults(cacheKey, results);

            _isSearching = false;
            return _scoreAndSortResults(results, query);
          } catch (e, stackTrace) {
            print('❌ Error parsing response: $e');
            print('❌ Stack trace: $stackTrace');
            print('❌ Raw response body: ${response.body}');
          }
        } else {
          print('❌ Search failed with status: ${response.statusCode}');
          print('❌ Error response: ${response.body}');
        }

        _isSearching = false;
        return [];
      } catch (e, stackTrace) {
        print('❌ Error searching products: $e');
        print('❌ Stack trace: $stackTrace');
        
        // Try to get cached results
        final cachedResults = await _getCachedResults(normalizedQuery.replaceAll(RegExp(r'[^a-z0-9]'), '_'));
        if (cachedResults.isNotEmpty) {
          print('📦 Using cached results after error');
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
    final normalizedQuery = query.toLowerCase();
    
    return results.map((result) {
      final title = result['title']?.toString().toLowerCase() ?? '';
      final description = result['description']?.toString().toLowerCase() ?? '';
      final brand = result['brand']?.toString().toLowerCase() ?? '';
      final category = result['category']?.toString().toLowerCase() ?? '';
      
      // Calculate relevance score
      double score = 0;
      
      // Exact matches get highest score
      if (title.contains(normalizedQuery)) score += 10;
      if (description.contains(normalizedQuery)) score += 5;
      if (brand.contains(normalizedQuery)) score += 8;
      if (category.contains(normalizedQuery)) score += 6;
      
      // Partial matches get lower scores
      final queryWords = normalizedQuery.split(' ');
      for (final word in queryWords) {
        if (title.contains(word)) score += 3;
        if (description.contains(word)) score += 1;
        if (brand.contains(word)) score += 2;
        if (category.contains(word)) score += 2;
      }
      
      // Add popularity factor
      final rating = (result['rating'] as num?)?.toDouble() ?? 0;
      final reviewCount = (result['reviewCount'] as num?)?.toInt() ?? 0;
      score += (rating * 0.5) + (reviewCount * 0.01);
      
      return {
        ...result,
        '_score': score,
      };
    }).toList()
      ..sort((a, b) => (b['_score'] as double).compareTo(a['_score'] as double));
  }

  void _addToMemoryCache(String query, List<Map<String, dynamic>> results) {
    _cleanupMemoryCache();
    _memoryCache[query] = results;
    _memoryCacheTimestamps[query] = DateTime.now();
  }

  void _cleanupMemoryCache() {
    final now = DateTime.now();
    final expiredKeys = _memoryCacheTimestamps.entries
        .where((entry) => now.difference(entry.value) > _memoryCacheDuration)
        .map((entry) => entry.key)
        .toList();

    for (final key in expiredKeys) {
      _memoryCache.remove(key);
      _memoryCacheTimestamps.remove(key);
    }

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

  Future<void> _cacheResults(String query, List<Map<String, dynamic>> results) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cache = prefs.getString('search_cache') ?? '{}';
      final Map<String, dynamic> cacheMap = jsonDecode(cache);
      
      cacheMap[query] = {
        'results': results,
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      await prefs.setString('search_cache', jsonEncode(cacheMap));
    } catch (e) {
      print('Error caching results: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _getCachedResults(String query) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cache = prefs.getString('search_cache') ?? '{}';
      final Map<String, dynamic> cacheMap = jsonDecode(cache);
      
      if (cacheMap.containsKey(query)) {
        final data = cacheMap[query];
        final timestamp = DateTime.parse(data['timestamp']);
        
        if (DateTime.now().difference(timestamp) <= _memoryCacheDuration) {
          return List<Map<String, dynamic>>.from(data['results']);
        }
      }
      return [];
    } catch (e) {
      print('Error getting cached results: $e');
      return [];
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
    _memoryCache.clear();
    _memoryCacheTimestamps.clear();
  }
}