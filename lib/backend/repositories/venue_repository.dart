import 'base_repository.dart';

class VenueRepository extends BaseRepository {
  static const String _table = 'venues';

  Future<List<Map<String, dynamic>>> getVenues() async {
    return safeCall(() async {
      return await client.from(_table).select();
    });
  }

  Future<Map<String, dynamic>?> getVenue(String id) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('id', id).maybeSingle();
    });
  }
}
