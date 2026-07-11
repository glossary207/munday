import 'package:flutter/material.dart';
import 'dart:async';
import 'mock_search_data.dart';
import 'search_list_item.dart';
import 'date_filter_modal.dart';
import 'location_filter_modal.dart';
import 'price_filter_modal.dart';
import 'search_map_page.dart';
import 'search_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = 'Search';
  static const String routePath = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchState(),
      child: const _SearchPageContent(),
    );
  }
}

class _SearchPageContent extends StatefulWidget {
  const _SearchPageContent();

  @override
  State<_SearchPageContent> createState() => _SearchPageContentState();
}

class _SearchPageContentState extends State<_SearchPageContent> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final query = context.watch<SearchState>().searchQuery;
    if (_searchController.text != query) {
      final cursor = _searchController.selection;
      _searchController.text = query;
      _searchController.selection = cursor.copyWith(
        baseOffset: query.length,
        extentOffset: query.length,
      );
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<SearchState>().updateSearchQuery(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = context.watch<SearchState>();
    final results = searchState.searchResults;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(context),
                _buildFilterChips(context),
                const SizedBox(height: 16),
                Expanded(
                  child: searchState.isSearching
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : searchState.searchQuery.isEmpty
                      ? ListView(
                          padding: const EdgeInsets.only(bottom: 80),
                          children: [
                            _buildCategoryRow(),
                            const SizedBox(height: 24),
                            _buildSectionTitle('Popular on Munday'),
                            ...results.map(
                              (item) => SearchListItem(item: item),
                            ),
                          ],
                        )
                      : results.isEmpty
                      ? Center(
                          child: Text(
                            "No results found",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            return SearchListItem(item: results[index]);
                          },
                        ),
                ),
              ],
            ),

            // Floating View Map Button
            Positioned(
              bottom: 65, // Just above the nav bar's search icon
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ChangeNotifierProvider.value(
                        value: context.read<SearchState>(),
                        child: const SearchMapPage(),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'VIEW MAP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for an event, artist or venue',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          filled: true,
          fillColor: Colors.grey[900],
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    context.read<SearchState>().updateSearchQuery('');
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    final searchState = context.watch<SearchState>();
    final dateLabel = searchState.selectedDate != null
        ? '${searchState.selectedDate!.day}/${searchState.selectedDate!.month}'
        : 'DATE';

    String priceLabel = 'PRICE';
    if (searchState.priceRange.start > 0 || searchState.priceRange.end < 100) {
      priceLabel =
          '\$${searchState.priceRange.start.toInt()} - \$${searchState.priceRange.end.toInt()}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _FilterChip(
            label: dateLabel,
            onTap: () => showDateFilterModal(context),
            isActive: searchState.selectedDate != null,
            icon: Icons.keyboard_arrow_down,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: priceLabel,
            onTap: () => showPriceFilterModal(context),
            isActive: priceLabel != 'PRICE',
            icon: Icons.keyboard_arrow_down,
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: searchState.selectedLocation.toUpperCase(),
            leadingIcon: Icons.location_on_outlined,
            onTap: () => showLocationFilterModal(context),
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: MockSearchData.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = MockSearchData.categories[index];
          final isSelected =
              context.watch<SearchState>().selectedCategory == category;
          return GestureDetector(
            onTap: () {
              if (isSelected) {
                context.read<SearchState>().updateSelectedCategory(null);
              } else {
                context.read<SearchState>().updateSelectedCategory(category);
              }
            },
            child: Container(
              width: 90,
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[800] : Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(color: Colors.white, width: 1.5)
                    : null,
              ),
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[300],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final IconData? icon;
  final IconData? leadingIcon;

  const _FilterChip({
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.icon,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.grey[800]
              : Colors.grey[900]?.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          border: isActive ? Border.all(color: Colors.white, width: 1) : null,
        ),
        child: Row(
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, color: Colors.white, size: 16),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(icon, color: Colors.grey[400], size: 16),
            ],
          ],
        ),
      ),
    );
  }
}
