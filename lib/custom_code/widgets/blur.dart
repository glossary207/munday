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

import 'dart:ui';

class Blur extends StatefulWidget {
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
  State<Blur> createState() => _BlurState();
}

class _BlurState extends State<Blur> {
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
