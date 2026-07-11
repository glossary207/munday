import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mock_search_data.dart';
import 'search_list_item.dart';
import 'date_filter_modal.dart';
import 'location_filter_modal.dart';
import 'price_filter_modal.dart';
import 'search_state.dart';
import 'map_style.dart';
import 'marker_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/routing/serialization_util.dart';
import '../../venue_detail/presentation/in_venuse/in_venuse_page.dart';
import 'package:ff_commons/flutter_flow/flutter_flow_util.dart' hide LatLng;

class SearchMapPage extends StatelessWidget {
  const SearchMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SearchMapPageContent();
  }
}

class _SearchMapPageContent extends StatefulWidget {
  const _SearchMapPageContent();

  @override
  State<_SearchMapPageContent> createState() => _SearchMapPageContentState();
}

class _SearchMapPageContentState extends State<_SearchMapPageContent> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  GoogleMapController? _mapController;
  Timer? _debounce;
  bool _isTyping = false;
  int _lastResultCount = -1;
  Set<Marker> _markers = {};
  List<SearchResultItem> _lastResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(() {
      setState(() {
        _isTyping = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final searchState = context.watch<SearchState>();
    final results = searchState.searchResults;
    final query = searchState.searchQuery;

    if (_lastResults != results) {
      _lastResults = results;
      _updateMarkers(results);
    }

    if (_searchController.text != query) {
      final cursor = _searchController.selection;
      _searchController.text = query;
      _searchController.selection = cursor.copyWith(
        baseOffset: query.length,
        extentOffset: query.length,
      );
    }
  }

  Future<void> _updateMarkers(List<SearchResultItem> results) async {
    final Set<Marker> newMarkers = {};
    for (int index = 0; index < results.length; index++) {
      var item = results[index];
      if (item.location != null) {
        newMarkers.add(
          Marker(
            markerId: MarkerId(item.id.toString()),
            position: LatLng(item.location!.latitude, item.location!.longitude),
            infoWindow: InfoWindow(
              title: item.title,
              snippet: item.subtitle,
              onTap: () {
                if (item.venueRef != null &&
                    (item.type == SearchItemType.event ||
                        item.type == SearchItemType.venue)) {
                  context.pushNamed(
                    InVenusePage.routeName,
                    queryParameters: {
                      'idVenues': serializeParam(
                        item.venueRef,
                        ParamType.SupabaseDocRef,
                      ),
                    }.withoutNulls,
                  );
                }
              },
            ),
            icon: await getCircleMarker(
              index == 0 ? "3" : (index == 1 ? "2" : "10+"),
              isVenue: item.type == SearchItemType.venue,
            ),
            onTap: () {
              if (item.venueRef != null &&
                  (item.type == SearchItemType.event ||
                      item.type == SearchItemType.venue)) {
                context.pushNamed(
                  InVenusePage.routeName,
                  queryParameters: {
                    'idVenues': serializeParam(
                      item.venueRef,
                      ParamType.SupabaseDocRef,
                    ),
                  }.withoutNulls,
                );
              }
            },
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        _markers = newMarkers;
      });
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
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = context.watch<SearchState>();
    final results = searchState.searchResults;

    LatLng initialPosition = const LatLng(13.7563, 100.5018); // Bangkok default

    if (_mapController != null && results.length != _lastResultCount) {
      _lastResultCount = results.length;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: initialPosition, zoom: 11.0),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Map Layer
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 11.0,
            ),
            markers: _markers,
            onMapCreated: (controller) {
              _mapController = controller;
              _mapController?.setMapStyle(darkMapStyle);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
          ),

          // 2. Bottom Sheet Layer (Visible when not typing)
          if (!_isTyping)
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.15,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: 80),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Title (Only if we have results, otherwise might want something else, but let's keep it for now)
                      if (!searchState.isSearching)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${results.length} events',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      if (!searchState.isSearching) const SizedBox(height: 16),
                      // Category Chips
                      _buildCategoryRow(),
                      const SizedBox(height: 16),
                      // Results List
                      if (searchState.isSearching)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      else if (searchState.searchQuery.isEmpty &&
                          results.isEmpty)
                        ...results.map((item) => SearchListItem(item: item))
                      else if (results.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      else ...[
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            top: 16.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            'Thu 09 Jul',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...results.map((item) => SearchListItem(item: item)),
                      ],
                    ],
                  ),
                );
              },
            ),

          // 3. Typing Overlay Layer (Black screen covering map)
          if (_isTyping)
            Positioned.fill(
              top: 140, // Below search bar
              child: Container(
                color: Colors.black,
                child: searchState.isSearching
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : searchState.searchQuery.isEmpty
                    ? ListView(
                        padding: const EdgeInsets.only(bottom: 80),
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              'Recently Viewed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...MockSearchData.recentlyViewed.map(
                            (item) => SearchListItem(item: item),
                          ),
                        ],
                      )
                    : results.isEmpty
                    ? Center(
                        child: Text(
                          "No results found for '${searchState.searchQuery}'",
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
            ),

          // 4. Top Overlay (Search Bar & Filters)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  ),
                ),
                child: Column(
                  children: [
                    _buildSearchBar(context),
                    _buildFilterChips(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // 5. Floating List Button
          if (!_isTyping)
            Positioned(
              bottom: 100, // Above Nav Bar
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                        Icons.format_list_bulleted,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'LIST',
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
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for an event, artist or venue',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          filled: true,
          fillColor: Colors.grey[900]?.withValues(alpha: 0.9),
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
