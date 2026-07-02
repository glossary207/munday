import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart'; // Imports other custom widgets
import '/core/utils/index.dart'; // Imports custom actions
import '/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
import 'package:munday/core/theme/theme.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class RatingBar extends ConsumerStatefulWidget {
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
  ConsumerState<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends ConsumerState<RatingBar> {
  int _currentRating = 0;

  @override
  void initState() {
    super.initState();
    if (!widget.showOrInput) {
      // ถ้าเป็นโหมด input ให้ใช้ค่าปัจจุบันจาก context.appState.ratingreview
      _currentRating = context.appState.ratingreview;
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
            context.appState.ratingreview =
                _currentRating; // อัปเดต context.appState.ratingreview
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
