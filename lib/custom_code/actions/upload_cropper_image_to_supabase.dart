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

import 'dart:typed_data';
import 'package:munday/custom_code/actions/clear_cropp_image_share_cache.dart';
import 'package:munday/backend/supabase_storage/storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// บีบ/ย่อภาพหลังครอปให้เป็น JPG SDR ขนาดเล็ก (พอมองเห็น) แล้วอัปโหลด
Future<String?> uploadCropperImageToSupabase(String uid) async {
  final shareState = CropImageWidgetShareState();

  try {
    if (shareState.croppedImageData == null) return null;

    final orig = shareState.croppedImageData!;
    final Uint8List inputBytes = orig.bytes!;

    // ลดขนาด/บีบด้วย codec ของแพลตฟอร์ม (flatten HDR → SDR/sRGB)
    final List<int> outBytes = await FlutterImageCompress.compressWithList(
      inputBytes,
      minWidth: 800, // พอเห็นชัด ไฟล์เล็ก
      minHeight: 800,
      quality: 60, // 0–100 (60 พอสำหรับพรีวิว)
      format: CompressFormat.jpeg,
      keepExif: false, // ตัดเมตาดาต้า/โปรไฟล์ ลดปัญหา P3/HDR
    );

    final String safeName =
        ((orig.name?.split('.').first ?? 'cropped')) + '.jpg';
    final Uint8List data = Uint8List.fromList(outBytes);

    final String? downloadUrl = await uploadData('/users/$uid/$safeName', data);

    if (downloadUrl != null) {
      debugPrint('Firestore url $downloadUrl');
      return downloadUrl;
    }
    return null;
  } catch (e, st) {
    debugPrint('uploadCropperImageToFirebase error: $e');
    debugPrintStack(stackTrace: st);
    return null;
  } finally {
    shareState.clear(); // เคลียร์ state ทุกครั้ง
  }
}
