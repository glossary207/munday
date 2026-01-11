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

class RatingBar extends StatefulWidget {
  const RatingBar({
    super.key,
    this.width,
    this.height,
    required this.showOrInput,
    this.rate,
    this.sizeicon = 24.0,
  });

  final double? width;
  final double? height;
  final bool showOrInput;
  final int? rate; // เปลี่ยนจาก double เป็น int
  final double sizeicon;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _currentRating = 0;

  @override
  void initState() {
    super.initState();
    if (!widget.showOrInput) {
      // ถ้าเป็นโหมด input ให้ใช้ค่าปัจจุบันจาก FFAppState().ratingreview
      _currentRating = FFAppState().ratingreview;
    }
  }

  Widget buildStar(int index) {
    IconData icon;
    Color color;
    double iconSize = widget.sizeicon;

    if (widget.showOrInput) {
      // โหมดแสดงผล (Read-Only)
      int rating = widget.rate ?? 0;
      if (rating >= index + 1) {
        icon = Icons.star;
        color = Colors.red;
      } else {
        icon = Icons.star_border;
        color = Colors.grey;
      }
      return Icon(
        icon,
        color: color,
        size: iconSize,
      );
    } else {
      // โหมด input (ให้คะแนน)
      icon = index < _currentRating ? Icons.star : Icons.star_border;
      color = index < _currentRating ? Colors.red : Colors.grey;

      return GestureDetector(
        onTap: () {
          setState(() {
            _currentRating = index + 1;
            FFAppState().ratingreview =
                _currentRating; // อัปเดต FFAppState().ratingreview
          });
        },
        child: Icon(
          icon,
          color: color,
          size: iconSize,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalStars = 5;
    double iconSize = widget.sizeicon;

    return Container(
      width: widget.width ??
          (totalStars * iconSize) +
              ((totalStars - 1) * 7.0), // กำหนดความกว้างตามจำนวนดาวและขนาด
      height: widget.height ?? iconSize, // กำหนดความสูงตามขนาดดาว
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(totalStars * 2 - 1, (index) {
          if (index.isOdd) {
            // เพิ่มช่องว่างระหว่างดาว 7 px
            return SizedBox(width: 7.0);
          } else {
            int starIndex = index ~/ 2;
            return buildStar(starIndex);
          }
        }),
      ),
    );
  }
}
