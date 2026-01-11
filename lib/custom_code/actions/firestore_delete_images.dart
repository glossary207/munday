// Automatic FlutterFlow imports
import '/backend/backend.dart';
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;
import "package:f_f_story_view_live_zhm3f3/backend/schema/enums/enums.dart"
    as f_f_story_view_live_zhm3f3_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

Future firestoreDeleteImages(List<String> images) async {
  if (images.isEmpty) return;

  for (var imageUrl in images) {
    try {
      final uri = Uri.parse(imageUrl);
      // Supabase URL: .../storage/v1/object/public/bucket/path...
      // We need 'bucket' and 'path'.
      // This parser assumes standard Supabase URL structure.
      final segments = uri.pathSegments;
      final storageIndex = segments.indexOf('storage');
      if (storageIndex != -1 && segments.length > storageIndex + 4) {
        // .../storage/v1/object/public/BUCKET/PATH...
        // segments: [..., storage, v1, object, public, BUCKET, file.jpg]
        final publicIndex = segments.indexOf('public');
        if (publicIndex != -1 && segments.length > publicIndex + 1) {
          final bucket = segments[publicIndex + 1];
          final path = segments.sublist(publicIndex + 2).join('/');

          await Supabase.instance.client.storage.from(bucket).remove([path]);
        }
      }
    } catch (e) {
      print('Error deleting image $imageUrl: $e');
    }
  }
}
