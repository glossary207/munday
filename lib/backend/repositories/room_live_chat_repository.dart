import 'base_repository.dart';

class RoomLiveChatRepository extends BaseRepository {
  static const String _table = 'room_venues_live_chat';

  // Example of using real-time subscription returning a stream
  Stream<List<Map<String, dynamic>>> subscribeToChat(String roomId) {
    return client
        .from(_table)
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at')
        .map((data) => data);
  }

  Future<void> sendMessage(Map<String, dynamic> msgData) async {
    return safeCall(() async {
      await client.from(_table).insert(msgData);
    });
  }
}
