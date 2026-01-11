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

class Tagpay extends StatefulWidget {
  const Tagpay({
    super.key,
    this.width,
    this.height,
    this.condition,
    this.ifture,
    this.iffalse,
  });

  final double? width;
  final double? height;
  final bool? condition;
  final String? ifture;
  final String? iffalse;

  @override
  State<Tagpay> createState() => _TagpayState();
}

class _TagpayState extends State<Tagpay> {
  @override
  Widget build(BuildContext context) {
    final bool isTrue = widget.condition ?? false;
    final String displayText =
        isTrue ? widget.ifture ?? '' : widget.iffalse ?? '';
    final Color displayColor = isTrue ? Color(0xFF07B53B) : Colors.grey;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: widget.width ?? 30,
        height: widget.height ?? 100,
        decoration: BoxDecoration(
          color: displayColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Center(
          child: RotatedBox(
            quarterTurns: 3, // หมุน 270 องศา = 90 องศาขึ้น
            child: Text(
              displayText,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 6,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
