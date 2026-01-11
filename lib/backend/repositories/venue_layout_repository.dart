import 'base_repository.dart';

class VenueLayoutRepository extends BaseRepository {
  static const String _table = 'venue_layouts';

  Future<Map<String, dynamic>?> getLayoutForVenue(String venueId) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('venue_id', venueId).maybeSingle();
    });
  }
}
