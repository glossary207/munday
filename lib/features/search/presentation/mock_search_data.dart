import '../../../../backend/backend.dart' show LatLng, SupabaseDocRef;

enum SearchItemType { event, artist, venue, category }

class SearchResultItem {
  final String id;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final SearchItemType type;
  final bool isSaved;
  final bool isFollowing;
  final LatLng? location;
  final SupabaseDocRef? venueRef;

  SearchResultItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    this.imageUrl,
    this.isSaved = false,
    this.isFollowing = false,
    this.location,
    this.venueRef,
  });
}

class MockSearchData {
  static final List<String> categories = [
    'Gigs',
    'Comedy',
    'DJ',
    'Party',
    'Workshop',
    'Festival',
  ];

  static final List<SearchResultItem> recentlyViewed = [
    SearchResultItem(
      id: '1',
      title: 'Acid',
      subtitle: 'DJ',
      type: SearchItemType.category,
    ),
    SearchResultItem(
      id: '2',
      title: 'DJ',
      subtitle: '',
      type: SearchItemType.category,
    ),
    SearchResultItem(
      id: '3',
      title: 'Alexandra Palace',
      subtitle: 'Venue, London',
      type: SearchItemType.venue,
      imageUrl: 'https://picsum.photos/id/1015/100/100', // Mock Image
    ),
    SearchResultItem(
      id: '4',
      title: 'Romare',
      subtitle: 'Artist',
      type: SearchItemType.artist,
      imageUrl: 'https://picsum.photos/id/1025/100/100', // Mock Image
    ),
    SearchResultItem(
      id: '5',
      title: 'Wet Leg',
      subtitle: 'Fri, 10 Jul\nAlexandra Palace Park',
      type: SearchItemType.event,
      imageUrl: 'https://picsum.photos/id/1040/100/100', // Mock Image
      isSaved: true,
    ),
  ];

  static final List<SearchResultItem> popular = [
    SearchResultItem(
      id: '6',
      title: 'Kaleidoscope Festival',
      subtitle: 'Sat, 11 Jul\nAlexandra Palace Park',
      type: SearchItemType.event,
      imageUrl: 'https://picsum.photos/id/1050/100/100',
    ),
    SearchResultItem(
      id: '7',
      title: 'FIFA World Cup 2026: England V...',
      subtitle: 'Sat, 11 Jul\nBetween The Bridges',
      type: SearchItemType.event,
      imageUrl: 'https://picsum.photos/id/1055/100/100',
    ),
    SearchResultItem(
      id: '8',
      title: 'KNEECAP',
      subtitle: 'Artist',
      type: SearchItemType.artist,
      imageUrl: 'https://picsum.photos/id/1060/100/100',
    ),
    SearchResultItem(
      id: '9',
      title: 'Studio 338',
      subtitle: 'Venue, London',
      type: SearchItemType.venue,
      imageUrl: 'https://picsum.photos/id/1070/100/100',
    ),
  ];
}
