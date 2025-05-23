import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/core/widgets/search_text_field.dart';
import 'package:pickpay/core/themes/theme_switch_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/wishlist/wishlist_cubits/wishlist_cubit.dart';
import 'package:pickpay/features/wishlist/wishlist_view.dart';
import 'package:pickpay/services/api_service.dart';
import 'package:pickpay/core/services/search_history_service.dart';

enum SortOption {
  priceLowToHigh,
  priceHighToLow,
  ratingHighToLow,
  newestFirst,
  nameAZ,
  nameZA,
}

class CustomHomeAppbar extends StatefulWidget {
  const CustomHomeAppbar({super.key});

  @override
  State<CustomHomeAppbar> createState() => _CustomHomeAppbarState();
}

class _CustomHomeAppbarState extends State<CustomHomeAppbar> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  final SearchHistoryService _historyService = SearchHistoryService();
  List<Map<String, dynamic>> _searchResults = [];
  List<String> _searchHistory = [];
  bool _isLoading = false;
  bool _showHistory = false;
  RangeValues _priceRange = const RangeValues(0, 1000);
  double _minRating = 0;
  String? _selectedBrand;
  SortOption _sortOption = SortOption.newestFirst;
  bool _showFilters = false;
  bool _showSortOptions = false;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final history = await _historyService.getSearchHistory();
    setState(() => _searchHistory = history);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
        _showHistory = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _showHistory = false;
    });

    try {
      // Check cache first
      final cachedResults = await _historyService.getCachedResultsForQuery(query);
      if (cachedResults != null) {
        setState(() {
          _searchResults = cachedResults;
          _isLoading = false;
        });
        return;
      }

      // If not in cache, perform search
      final results = await _apiService.searchProductsAI(query);
      final mappedResults = results.map((item) => Map<String, dynamic>.from(item)).toList();
      
      // Cache the results
      await _historyService.cacheResults(query, mappedResults);
      
      // Add to search history
      await _historyService.addToHistory(query);
      await _loadSearchHistory();

      setState(() {
        _searchResults = mappedResults;
        _isLoading = false;
      });
    } catch (e) {
      print('Error searching products: $e');
      setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> _filterResults(List<Map<String, dynamic>> results) {
    var filteredResults = results.where((product) {
      final price = product['price'] as num? ?? 0;
      final rating = product['rating'] as num? ?? 0;
      final brand = product['brand'] as String? ?? '';

      final priceMatch = price >= _priceRange.start && price <= _priceRange.end;
      final ratingMatch = rating >= _minRating;
      final brandMatch = _selectedBrand == null || _selectedBrand == 'All Brands' || brand == _selectedBrand;

      return priceMatch && ratingMatch && brandMatch;
    }).toList();

    // Apply sorting
    switch (_sortOption) {
      case SortOption.priceLowToHigh:
        filteredResults.sort((a, b) => (a['price'] as num).compareTo(b['price'] as num));
        break;
      case SortOption.priceHighToLow:
        filteredResults.sort((a, b) => (b['price'] as num).compareTo(a['price'] as num));
        break;
      case SortOption.ratingHighToLow:
        filteredResults.sort((a, b) => (b['rating'] as num).compareTo(a['rating'] as num));
        break;
      case SortOption.newestFirst:
        filteredResults.sort((a, b) => (b['createdAt'] as String).compareTo(a['createdAt'] as String));
        break;
      case SortOption.nameAZ:
        filteredResults.sort((a, b) => (a['title'] as String).compareTo(b['title'] as String));
        break;
      case SortOption.nameZA:
        filteredResults.sort((a, b) => (b['title'] as String).compareTo(a['title'] as String));
        break;
    }

    return filteredResults;
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]
          : Colors.grey[200],
      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      checkmarkColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyles.regular16.copyWith(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDarkMode ? Colors.grey[800] : Colors.grey.shade200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              Assets.appLogo,
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 5),
            Text(
              'PickPay',
              style: TextStyles.bold23.copyWith(
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const Spacer(),
            BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                int wishlistCount = 0;
                if (state is WishlistLoaded) {
                  wishlistCount = state.items.length;
                }

                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              size: 24,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WishlistView(),
                                ),
                              );
                            },
                          ),
                          if (wishlistCount > 0)
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  wishlistCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(child: ThemeSwitchButton()),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SearchTextField(
                controller: _searchController,
                onSearch: _handleSearch,
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              if (_showHistory && _searchHistory.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Searches',
                              style: TextStyles.bold16,
                            ),
                            TextButton(
                              onPressed: () async {
                                await _historyService.clearHistory();
                                await _loadSearchHistory();
                              },
                              child: const Text('Clear History'),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _searchHistory.length,
                        itemBuilder: (context, index) {
                          final term = _searchHistory[index];
                          return ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(term),
                            onTap: () {
                              _searchController.text = term;
                              _handleSearch(term);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              if (_searchResults.isNotEmpty) ...[
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Filters & Sort', style: TextStyles.bold16),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _showFilters ? Icons.filter_list : Icons.filter_list_outlined,
                                  color: _showFilters ? Theme.of(context).colorScheme.primary : null,
                                ),
                                onPressed: () {
                                  setState(() => _showFilters = !_showFilters);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  _showSortOptions ? Icons.sort : Icons.sort_outlined,
                                  color: _showSortOptions ? Theme.of(context).colorScheme.primary : null,
                                ),
                                onPressed: () {
                                  setState(() => _showSortOptions = !_showSortOptions);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (_showFilters) ...[
                        const SizedBox(height: 8),
                        // Price Range Filter
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 1000,
                          divisions: 20,
                          labels: RangeLabels(
                            '\$${_priceRange.start.round()}',
                            '\$${_priceRange.end.round()}',
                          ),
                          onChanged: (values) {
                            setState(() => _priceRange = values);
                          },
                        ),
                        // Rating Filter
                        Row(
                          children: [
                            Text('Min Rating: ${_minRating.toStringAsFixed(1)}'),
                            Expanded(
                              child: Slider(
                                value: _minRating,
                                min: 0,
                                max: 5,
                                divisions: 10,
                                label: _minRating.toStringAsFixed(1),
                                onChanged: (value) {
                                  setState(() => _minRating = value);
                                },
                              ),
                            ),
                          ],
                        ),
                        // Brand Filter
                        DropdownButton<String>(
                          value: _selectedBrand,
                          hint: const Text('Select Brand'),
                          isExpanded: true,
                          items: [
                            const DropdownMenuItem(
                              value: 'All Brands',
                              child: Text('All Brands'),
                            ),
                            ..._searchResults
                                .map((product) => product['brand'] as String?)
                                .where((brand) => brand != null)
                                .toSet()
                                .map((brand) => DropdownMenuItem(
                                      value: brand,
                                      child: Text(brand!),
                                    )),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedBrand = value);
                          },
                        ),
                      ],
                      if (_showSortOptions) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildFilterChip(
                              'Price: Low to High',
                              _sortOption == SortOption.priceLowToHigh,
                              () => setState(() => _sortOption = SortOption.priceLowToHigh),
                            ),
                            _buildFilterChip(
                              'Price: High to Low',
                              _sortOption == SortOption.priceHighToLow,
                              () => setState(() => _sortOption = SortOption.priceHighToLow),
                            ),
                            _buildFilterChip(
                              'Rating: High to Low',
                              _sortOption == SortOption.ratingHighToLow,
                              () => setState(() => _sortOption = SortOption.ratingHighToLow),
                            ),
                            _buildFilterChip(
                              'Newest First',
                              _sortOption == SortOption.newestFirst,
                              () => setState(() => _sortOption = SortOption.newestFirst),
                            ),
                            _buildFilterChip(
                              'Name: A-Z',
                              _sortOption == SortOption.nameAZ,
                              () => setState(() => _sortOption = SortOption.nameAZ),
                            ),
                            _buildFilterChip(
                              'Name: Z-A',
                              _sortOption == SortOption.nameZA,
                              () => setState(() => _sortOption = SortOption.nameZA),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filterResults(_searchResults).length,
                    itemBuilder: (context, index) {
                      final product = _filterResults(_searchResults)[index];
                      return ListTile(
                        leading: product['imageUrl'] != null
                            ? Image.network(
                                product['imageUrl'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported),
                              )
                            : const Icon(Icons.image_not_supported),
                        title: Text(
                          product['title'] ?? '',
                          style: TextStyles.regular16,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['description'] ?? '',
                              style: TextStyles.regular16,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (product['rating'] != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    ' ${product['rating'].toStringAsFixed(1)}',
                                    style: TextStyles.regular16,
                                  ),
                                ],
                              ),
                          ],
                        ),
                        trailing: product['price'] != null
                            ? Text(
                                '\$${product['price'].toStringAsFixed(2)}',
                                style: TextStyles.regular16.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                        onTap: () {
                          _searchController.text = product['title'] ?? '';
                          _handleSearch(product['title'] ?? '');
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
