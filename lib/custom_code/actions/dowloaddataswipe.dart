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

Future<List<UsersRecord>> dowloaddataswipe(
    List<SupabaseDocRef>? iDuser) async {
  if (iDuser == null || iDuser.isEmpty) {
    return <UsersRecord>[];
  }

  final firstFiveRefs = iDuser.take(5).toList();

  final listOfFutures = firstFiveRefs.map((ref) async {
    try {
      // แก้ไข: ใช้ SupabaseDocRef.get() เพื่อดึงข้อมูลแบบครั้งเดียว
      final snapshot = await ref.get();
      // ตรวจสอบว่ามีเอกสารจริง และแปลงเป็น UsersRecord
      if (snapshot.exists) {
        return UsersRecord.fromSnapshot(snapshot);
      }
      return null;
    } catch (e) {
      print('Error fetching document $ref: $e');
      return null;
    }
  }).toList();

  final results = await Future.wait(listOfFutures);

  // กรองเฉพาะ record ที่ไม่เป็น null
  final userList = results.whereType<UsersRecord>().toList();

  return userList;
}
