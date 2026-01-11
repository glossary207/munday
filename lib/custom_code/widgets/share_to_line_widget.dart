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
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:url_launcher/url_launcher.dart';

class ShareToLineWidget extends StatelessWidget {
  final String title; // ชื่อหรือหัวข้อหลัก
  final String description; // รายละเอียดเนื้อหา
  final String imageUrl; // URL รูปภาพ
  final String buttonLabel; // ข้อความบนปุ่ม
  final String buttonLink; // ลิงก์ที่ปุ่มจะนำไป
  final String fallbackUrl; // ลิงก์ fallback สำหรับกรณี LINE ใช้ไม่ได้
  final double width; // ความกว้างของปุ่ม
  final double height; // ความสูงของปุ่ม

  const ShareToLineWidget({
    Key? key,
    this.title = "DEJONG", // Default: ชื่อเนื้อหา
    this.description =
        "จองรายวัน\nวันเวลา: 26.08.2024\nเลขโต๊ะ: B38", // Default: รายละเอียดเนื้อหา
    this.imageUrl =
        "https://taknai.com/wp-content/uploads/2020/09/8717.jpg", // Default: URL รูปภาพ
    this.buttonLabel = "แสดง QR CODE", // Default: ป้ายข้อความบนปุ่ม
    this.buttonLink = "https://www.google.com", // Default: ลิงก์ที่ปุ่มจะไป
    this.fallbackUrl = "https://google.com", // Default: ลิงก์ fallback
    this.width = 200.0, // Default: ความกว้าง
    this.height = 50.0, // Default: ความสูง
  }) : super(key: key);

  Future<void> _shareToLine(BuildContext context) async {
    // สร้างข้อความที่แชร์ไป LINE
    final message = '''
$title
$description
ดูเพิ่มเติม: $buttonLink
''';

    // ใช้ LINE URL Scheme
    final lineUrl = Uri.encodeFull("line://msg/text/$message");

    if (await canLaunch(lineUrl)) {
      await launch(lineUrl);
    } else {
      debugPrint("LINE is not installed.");
      // ใช้ fallback URL
      if (await canLaunch(fallbackUrl)) {
        await launch(fallbackUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ไม่สามารถเปิดลิงก์ได้")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => _shareToLine(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // สีปุ่ม
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.share, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              "แชร์ไปยัง LINE",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
