import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String _historyKey = 'search_history';
  static const String _cacheKey = 'search_cache';
  static const int _maxHistoryItems = 10;
  static const Duration _cacheDuration = Duration(hours: 24);

  // Get search history
  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];
    return historyJson;
  }

  // Add search term to history
  Future<void> addToHistory(String searchTerm) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();
    
    // Remove if already exists
    history.remove(searchTerm);
    
    // Add to beginning of list
    history.insert(0, searchTerm);
    
    // Keep only last 10 items
    if (history.length > _maxHistoryItems) {
      history.removeLast();
    }
    
    await prefs.setStringList(_historyKey, history);
  }

  // Clear search history
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  // Cache search results
  Future<void> cacheResults(String query, List<Map<String, dynamic>> results) async {
    final prefs = await SharedPreferences.getInstance();
    final cache = await getCachedResults();
    
    cache[query] = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'results': results,
    };
    
    // Remove expired cache entries
    final now = DateTime.now().millisecondsSinceEpoch;
    cache.removeWhere((key, value) => 
      now - value['timestamp'] > _cacheDuration.inMilliseconds);
    
    await prefs.setString(_cacheKey, jsonEncode(cache));
  }

  // Get cached results
  Future<Map<String, dynamic>> getCachedResults() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = prefs.getString(_cacheKey);
    if (cacheJson == null) return {};
    
    try {
      return Map<String, dynamic>.from(jsonDecode(cacheJson));
    } catch (e) {
      return {};
    }
  }

  // Get cached results for a query
  Future<List<Map<String, dynamic>>?> getCachedResultsForQuery(String query) async {
    final cache = await getCachedResults();
    final cachedData = cache[query];
    
    if (cachedData == null) return null;
    
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - cachedData['timestamp'] > _cacheDuration.inMilliseconds) {
      // Cache expired
      cache.remove(query);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(cache));
      return null;
    }
    
    return List<Map<String, dynamic>>.from(cachedData['results']);
  }

  // Clear cache
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
} 