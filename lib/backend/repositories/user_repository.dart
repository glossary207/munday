import 'package:supabase_flutter/supabase_flutter.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  /// Table name: users
  static const String _table = 'users';

  /// Fetch a user profile by ID.
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    return safeCall(() async {
      final response = await client.from(_table).select().eq('id', userId).maybeSingle();
      return response;
    });
  }

  /// Create or Update a user.
  Future<void> saveUser(String userId, Map<String, dynamic> data) async {
    return safeCall(() async {
      // Upsert: Create if not exists, update if exists.
      data['id'] = userId; // Ensure ID is present
      data['updated_time'] = DateTime.now().toIso8601String();
      await client.from(_table).upsert(data);
    });
  }

  /// Search users by display name (Partial match).
  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    return safeCall(() async {
      return await client
          .from(_table)
          .select()
          .ilike('display_name', '%$query%') // Case-insensitive LIKE
          .limit(20);
    });
  }

  /// Delete a user (Soft delete usually, but here hard delete for example).
  Future<void> deleteUser(String userId) async {
    return safeCall(() async {
      await client.from(_table).delete().eq('id', userId);
    });
  }
}
