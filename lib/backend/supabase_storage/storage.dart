import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mime_type/mime_type.dart';

Future<String?> uploadData(String path, Uint8List data) async {
  try {
    // Determine bucket based on path
    String bucket = 'Venues'; // Default
    // Handle both 'users' and '/users' prefixes, and 'photoshow' paths
    if (path.startsWith('users') ||
        path.startsWith('/users') ||
        path.contains('photoshow')) {
      bucket = 'Users';
    }

    final fileOptions = FileOptions(contentType: mime(path), upsert: true);
    await Supabase.instance.client.storage.from(bucket).uploadBinary(
          path,
          data,
          fileOptions: fileOptions,
        );
    return Supabase.instance.client.storage.from(bucket).getPublicUrl(path);
  } catch (e) {
    print('Error uploading data: $e');
    return null;
  }
}
