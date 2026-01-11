import 'base_repository.dart';

class RoomRepository extends BaseRepository {
  static const String _table = 'room';

  Future<List<Map<String, dynamic>>> getRooms(String venueId) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('venue_id', venueId);
    });
  }

  Future<Map<String, dynamic>?> getRoom(String id) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('id', id).maybeSingle();
    });
  }
}
