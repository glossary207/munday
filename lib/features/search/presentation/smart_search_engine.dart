import 'package:flutter/material.dart';
import '../../../../backend/backend.dart' show LatLng;

class SmartSearchIntent {
  final String cleanQuery;
  final String? locationName;
  final LatLng? locationCoords;
  final DateTime? date;
  final String? category;
  final bool? isFree;

  SmartSearchIntent({
    required this.cleanQuery,
    this.locationName,
    this.locationCoords,
    this.date,
    this.category,
    this.isFree,
  });
}

class SmartSearchEngine {
  // Known data for extraction (In a real app, this might come from a small local database or config)
  static final Map<String, LatLng> _knownCities = {
    'bangkok': LatLng(13.7563, 100.5018),
    'bkk': LatLng(13.7563, 100.5018),
    'london': LatLng(51.5074, -0.1278),
    'new york': LatLng(40.7128, -74.0060),
    'ny': LatLng(40.7128, -74.0060),
    'tokyo': LatLng(35.6762, 139.6503),
  };

  static final List<String> _knownCategories = [
    'gig',
    'gigs',
    'comedy',
    'dj',
    'party',
    'workshop',
    'festival',
    'live',
    'club',
  ];

  static SmartSearchIntent parseQuery(String query) {
    if (query.trim().isEmpty) {
      return SmartSearchIntent(cleanQuery: '');
    }

    String lowerQuery = query.toLowerCase();
    String cleanQuery = query;

    bool? isFree;
    String? category;
    String? locationName;
    LatLng? locationCoords;
    DateTime? date;

    // 1. Extract Price (Free)
    if (lowerQuery.contains('free') || lowerQuery.contains('ฟรี')) {
      isFree = true;
      // We don't remove 'free' from cleanQuery because the event itself might be called "Free Party"
    }

    // 2. Extract Location
    for (final city in _knownCities.keys) {
      if (lowerQuery.contains(city) ||
          lowerQuery.contains('in $city') ||
          lowerQuery.contains('ที่$city') ||
          lowerQuery.contains('ที่ $city')) {
        locationName = city.toUpperCase();
        locationCoords = _knownCities[city];
        break;
      }
    }

    // 3. Extract Categories
    for (final cat in _knownCategories) {
      if (lowerQuery.contains(cat)) {
        category = cat; // E.g., 'party'
        break;
      }
    }

    // 4. Extract Dates (Simple NLP)
    final now = DateTime.now();
    if (lowerQuery.contains('today') || lowerQuery.contains('วันนี้')) {
      date = DateTime(now.year, now.month, now.day);
    } else if (lowerQuery.contains('tomorrow') ||
        lowerQuery.contains('พรุ่งนี้')) {
      date = DateTime(
        now.year,
        now.month,
        now.day,
      ).add(const Duration(days: 1));
    } else if (lowerQuery.contains('this friday') ||
        lowerQuery.contains('วันศุกร์นี้') ||
        lowerQuery.contains('ศุกร์นี้')) {
      int daysUntilFriday = DateTime.friday - now.weekday;
      if (daysUntilFriday <= 0) daysUntilFriday += 7;
      date = DateTime(
        now.year,
        now.month,
        now.day,
      ).add(Duration(days: daysUntilFriday));
    } else if (lowerQuery.contains('this saturday') ||
        lowerQuery.contains('เสาร์นี้')) {
      int daysUntilSaturday = DateTime.saturday - now.weekday;
      if (daysUntilSaturday <= 0) daysUntilSaturday += 7;
      date = DateTime(
        now.year,
        now.month,
        now.day,
      ).add(Duration(days: daysUntilSaturday));
    } else if (lowerQuery.contains('this sunday') ||
        lowerQuery.contains('อาทิตย์นี้')) {
      int daysUntilSunday = DateTime.sunday - now.weekday;
      if (daysUntilSunday <= 0) daysUntilSunday += 7;
      date = DateTime(
        now.year,
        now.month,
        now.day,
      ).add(Duration(days: daysUntilSunday));
    }

    return SmartSearchIntent(
      cleanQuery: cleanQuery,
      isFree: isFree,
      locationName: locationName,
      locationCoords: locationCoords,
      category: category,
      date: date,
    );
  }
}
