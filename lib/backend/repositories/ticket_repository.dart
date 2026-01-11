import 'base_repository.dart';

class TicketRepository extends BaseRepository {
  static const String _table = 'ticket';

  Future<List<Map<String, dynamic>>> getTicketsForUser(String userId) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('user_id', userId);
    });
  }

  Future<Map<String, dynamic>?> getTicket(String id) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('id', id).maybeSingle();
    });
  }
  
  Future<void> createTicket(Map<String, dynamic> data) async {
    return safeCall(() async {
        await client.from(_table).insert(data);
    });
  }
}
