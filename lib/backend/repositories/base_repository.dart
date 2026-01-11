import 'package:supabase_flutter/supabase_flutter.dart';

/// Base class for all data repositories.
/// Provides access to the Supabase client.
abstract class BaseRepository {
  SupabaseClient get client => Supabase.instance.client;

  /// Helper to handle Supabase errors gracefully
  Future<T> safeCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on PostgrestException catch (e) {
      // Log error or rethrow consistent app exception
      print('Supabase Error: ${e.message}');
      throw e;
    } catch (e) {
      print('Unexpected Error: $e');
      throw e;
    }
  }
}
