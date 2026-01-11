import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';

/// SupaFlow: Extended Supabase Service for complex interactions.
class SupaFlow {
  static final SupaFlow _instance = SupaFlow._internal();
  factory SupaFlow() => _instance;
  SupaFlow._internal();

  SupabaseClient get client => Supabase.instance.client;

  /// Execute a stored procedure (RPC).
  Future<dynamic> rpc(String functionName,
      {Map<String, dynamic>? params}) async {
    try {
      return await client.rpc(functionName, params: params);
    } catch (e) {
      print('RPC Error ($functionName): $e');
      rethrow;
    }
  }

  /// Upload a file to Supabase Storage.
  Future<String?> uploadFile({
    required String bucket,
    required String path,
    required List<int> fileBytes,
    String? contentType,
  }) async {
    try {
      await client.storage.from(bucket).uploadBinary(
            path,
            Uint8List.fromList(fileBytes),
            fileOptions: FileOptions(contentType: contentType, upsert: true),
          );
      return client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      print('Upload Error: $e');
      return null;
    }
  }
}
