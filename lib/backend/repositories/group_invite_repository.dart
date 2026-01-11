import 'base_repository.dart';

class GroupInviteRepository extends BaseRepository {
  static const String _table = 'group_invite';

  Future<Map<String, dynamic>?> getInvite(String code) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('code', code).maybeSingle();
    });
  }
}
