import 'base_repository.dart';

class PromotionRepository extends BaseRepository {
  static const String _table = 'promotion';

  Future<List<Map<String, dynamic>>> getActivePromotions() async {
    return safeCall(() async {
      final now = DateTime.now().toIso8601String();
      return await client
          .from(_table)
          .select()
          .lte('start_date', now)
          .gte('end_date', now);
    });
  }
}
