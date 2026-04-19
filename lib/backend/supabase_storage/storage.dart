import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mime_type/mime_type.dart';

Future<String?> uploadData(
  String path,
  Uint8List data, {
  String? bucket,
}) async {
  try {
    // Determine bucket based on path
    String resolvedBucket = bucket ?? 'Venues';
    // Handle both 'users' and '/users' prefixes, and 'photoshow' paths
    if (bucket == null &&
        (path.startsWith('users') ||
            path.startsWith('/users') ||
            path.contains('photoshow'))) {
      resolvedBucket = 'Users';
    }

    final fileOptions = FileOptions(contentType: mime(path), upsert: true);
    await Supabase.instance.client.storage.from(resolvedBucket).uploadBinary(
          path,
          data,
          fileOptions: fileOptions,
        );
    return Supabase.instance.client.storage
        .from(resolvedBucket)
        .getPublicUrl(path);
  } catch (e) {
    print('Error uploading data for path "$path": $e');
    return null;
  }
}
