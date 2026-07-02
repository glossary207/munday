// Automatic FlutterFlow imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart'; // Imports other custom widgets
import '/core/utils/index.dart'; // Imports custom actions
import '/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui';
import 'package:munday/core/theme/theme.dart';

class Blur extends ConsumerStatefulWidget {
  const Blur({
    Key? key,
    this.width,
    this.height,
    this.off,
  }) : super(key: key);

  final double? width;
  final double? height;
  final bool? off;

  @override
  ConsumerState<Blur> createState() => _BlurState();
}

class _BlurState extends ConsumerState<Blur> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.off == true ? 0.0 : 1.0,
      duration: Duration(
          milliseconds:
              300), // ตั้งค่าระยะเวลาที่ต้องการให้ fade เป็น 0.3 วินาที
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: Container(
              width: widget.width,
              height: widget.height,
              color: Colors.white.withOpacity(0.0),
            ),
          ),
        ),
      ),
    );
  }
}
