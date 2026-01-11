import 'base_repository.dart';

class StoreRepository extends BaseRepository {
  static const String _table = 'store';

  Future<List<Map<String, dynamic>>> getStores() async {
    return safeCall(() async {
      return await client.from(_table).select();
    });
  }

  Future<Map<String, dynamic>?> getStore(String id) async {
    return safeCall(() async {
      return await client.from(_table).select().eq('id', id).maybeSingle();
    });
  }
}
