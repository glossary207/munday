import 'package:supabase_flutter/supabase_flutter.dart';
import 'base_repository.dart';

class EventRepository extends BaseRepository {
  /// Table name: events
  static const String _table = 'events';

  /// Fetch all active events.
  Future<List<Map<String, dynamic>>> getActiveEvents() async {
    return safeCall(() async {
      return await client
          .from(_table)
          .select()
          .eq('status', 'active') // Assuming a status column exists
          .order('created_at', ascending: false);
    });
  }

  /// Get event details.
  Future<Map<String, dynamic>?> getEvent(String eventId) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('id', eventId).maybeSingle();
    });
  }

  /// Create a new event.
  Future<String> createEvent(Map<String, dynamic> eventData) async {
    return safeCall(() async {
      final response = await client.from(_table).insert(eventData).select().single();
      return response['id'] as String;
    });
  }
}
