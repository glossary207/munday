import 'base_repository.dart';

class UserInVenueRepository extends BaseRepository {
  static const String _table = 'user_in_venues';

  Future<List<Map<String, dynamic>>> getUsersInVenue(String venueId) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('venue_id', venueId);
    });
  }

  Future<void> addUserToVenue(String userId, String venueId) async {
    return safeCall(() async {
      await client.from(_table).insert({
        'user_id': userId,
        'venue_id': venueId,
        'joined_at': DateTime.now().toIso8601String(),
      });
    });
  }
}
