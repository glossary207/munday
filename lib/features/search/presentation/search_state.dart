import 'package:flutter/material.dart';
import '../../../../backend/backend.dart';
import 'mock_search_data.dart';
import 'smart_search_engine.dart';
import 'dart:math' as math;

class SearchState extends ChangeNotifier {
  String _searchQuery = '';
  DateTime? _selectedDate;
  RangeValues _priceRange = const RangeValues(0, 100);
  String _selectedLocation = 'BANGKOK';
  String? _selectedCategory;

  bool _isSearching = false;
  List<SearchResultItem> _searchResults = [];

  String get searchQuery => _searchQuery;
  DateTime? get selectedDate => _selectedDate;
  RangeValues get priceRange => _priceRange;
  String get selectedLocation => _selectedLocation;
  String? get selectedCategory => _selectedCategory;

  bool get isSearching => _isSearching;
  List<SearchResultItem> get searchResults => _searchResults;

  SearchState() {
    _performSearch();
  }

  void updateSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;

      // Magic happens here: NLP Engine parses the query!
      final intent = SmartSearchEngine.parseQuery(query);
      if (intent.locationName != null) _selectedLocation = intent.locationName!;
      if (intent.date != null) _selectedDate = intent.date;
      if (intent.category != null) _selectedCategory = intent.category;
      if (intent.isFree == true) _priceRange = const RangeValues(0, 0); // Free

      notifyListeners();
      _performSearch();
    }
  }

  void updateSelectedDate(DateTime? date) {
    if (_selectedDate != date) {
      _selectedDate = date;
      notifyListeners();
      _performSearch();
    }
  }

  void updatePriceRange(RangeValues range) {
    if (_priceRange != range) {
      _priceRange = range;
      notifyListeners();
      _performSearch();
    }
  }

  void updateSelectedLocation(String location) {
    if (_selectedLocation != location) {
      _selectedLocation = location;
      notifyListeners();
      _performSearch();
    }
  }

  void updateSelectedCategory(String? category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
      _performSearch();
    }
  }

  void clearFilters() {
    _selectedDate = null;
    _priceRange = const RangeValues(0, 100);
    _selectedLocation = 'LONDON';
    _selectedCategory = null;
    notifyListeners();
    _performSearch();
  }

  // Haversine formula to calculate distance between two LatLngs in km
  double _calculateDistance(LatLng pos1, LatLng pos2) {
    const double R = 6371; // Radius of earth in km
    final lat1 = pos1.latitude * math.pi / 180;
    final lat2 = pos2.latitude * math.pi / 180;
    final dLat = (pos2.latitude - pos1.latitude) * math.pi / 180;
    final dLng = (pos2.longitude - pos1.longitude) * math.pi / 180;

    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return R * c;
  }

  Future<void> _performSearch() async {
    _isSearching = true;
    notifyListeners();

    try {
      final intent = SmartSearchEngine.parseQuery(_searchQuery);
      final searchString = intent.cleanQuery.trim().isEmpty
          ? _searchQuery
          : intent.cleanQuery;

      // 1. Fetch raw data (all if empty, or filter by searchString)
      final eventsFuture = queryCollectionOnce<EventsRecord>(
        EventsRecord.collection,
        EventsRecord.fromSnapshot,
        queryBuilder: searchString.isEmpty
            ? null
            : (q) => q.ilike('Name_store', '%$searchString%'),
        limit: 50,
      );

      final venuesFuture = queryCollectionOnce<VenuesRecord>(
        VenuesRecord.collection,
        VenuesRecord.fromSnapshot,
        queryBuilder: searchString.isEmpty
            ? null
            : (q) => q.ilike('Name_Venuse', '%$searchString%'),
        limit: 50,
      );

      final results = await Future.wait([eventsFuture, venuesFuture]);
      var events = results[0] as List<EventsRecord>;
      var venues = results[1] as List<VenuesRecord>;

      // 2. Local Filtering (AI Magic Applied)
      if (_selectedCategory != null) {
        final catLower = _selectedCategory!.toLowerCase();
        events = events
            .where(
              (e) =>
                  e.musicstyle.toLowerCase().contains(catLower) ||
                  e.styleVenues.any((s) => s.toLowerCase().contains(catLower)),
            )
            .toList();

        venues = venues
            .where(
              (v) =>
                  v.styleVenuse.any(
                    (s) => s.toLowerCase().contains(catLower),
                  ) ||
                  v.styleMusic.any((s) => s.toLowerCase().contains(catLower)),
            )
            .toList();
      }

      if (_selectedDate != null) {
        // Only keep events that happen on or after the selected date (ignoring time)
        final targetDate = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
        );
        events = events.where((e) {
          if (!e.hasDate()) return false;
          final eventDate = DateTime(e.date!.year, e.date!.month, e.date!.day);
          return eventDate.isAtSameMomentAs(targetDate) ||
              eventDate.isAfter(targetDate);
        }).toList();
        // Venues are always available, we don't filter them out by date here unless they have DateEvents
      }

      if (_priceRange.start == 0 && _priceRange.end == 0) {
        events = events.where((e) => e.free == true).toList();
      }

      // 3. Map/Location Formatting
      final List<SearchResultItem> combinedResults = [];

      // Fallback to selected location if the query didn't contain a specific city
      LatLng? targetLocationCoords = intent.locationCoords;
      if (targetLocationCoords == null) {
        final locationIntent = SmartSearchEngine.parseQuery(_selectedLocation);
        targetLocationCoords = locationIntent.locationCoords;
      }

      for (var event in events) {
        String subtitle = event.hasDate()
            ? '${event.date!.day}/${event.date!.month}/${event.date!.year}'
            : 'Event';
        if (targetLocationCoords != null && event.hasLocation()) {
          final dist = _calculateDistance(
            targetLocationCoords,
            event.location!,
          );
          subtitle += ' • ${dist.toStringAsFixed(1)} km away';
        }

        combinedResults.add(
          SearchResultItem(
            id: event.reference.id,
            title: event.nameStore,
            subtitle: subtitle,
            type: SearchItemType.event,
            imageUrl: event.poster,
            location: event.location,
            venueRef: event.iDVenues,
          ),
        );
      }

      for (var venue in venues) {
        String subtitle = 'Venue';
        if (targetLocationCoords != null && venue.hasPosition()) {
          final dist = _calculateDistance(
            targetLocationCoords,
            venue.position!,
          );
          subtitle += ' • ${dist.toStringAsFixed(1)} km away';
        }

        combinedResults.add(
          SearchResultItem(
            id: venue.reference.id,
            title: venue.nameVenuse,
            subtitle: subtitle,
            type: SearchItemType.venue,
            imageUrl: venue.bg,
            location: venue.position,
            venueRef: venue.reference,
          ),
        );
      }

      // 4. Sort by distance if location is provided
      if (targetLocationCoords != null) {
        combinedResults.sort((a, b) {
          // Very simple sort: extract km string or push to bottom
          final aDistStr = a.subtitle.contains('km away')
              ? a.subtitle.split(' • ').last.replaceAll(' km away', '')
              : '999';
          final bDistStr = b.subtitle.contains('km away')
              ? b.subtitle.split(' • ').last.replaceAll(' km away', '')
              : '999';
          final aDist = double.tryParse(aDistStr) ?? 999.0;
          final bDist = double.tryParse(bDistStr) ?? 999.0;
          return aDist.compareTo(bDist);
        });
      }

      _searchResults = combinedResults;
    } catch (e) {
      print('Search Error: $e');
      _searchResults = [];
    }

    _isSearching = false;
    notifyListeners();
  }
}
