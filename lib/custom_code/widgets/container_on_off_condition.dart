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

class ContainerOnOffCondition extends StatefulWidget {
  const ContainerOnOffCondition({
    super.key,
    this.width,
    this.height,
    this.color,
    this.heightfalse,
  });

  final double? width; // ความกว้างเมื่อ on/off
  final double? height; // ความสูงเมื่อ on = true
  final Color? color; // สี overlay (ถ้าไม่ส่ง = โปร่ง)
  final double? heightfalse; // ความสูงเมื่อ on = false

  @override
  State<ContainerOnOffCondition> createState() =>
      _ContainerOnOffConditionState();
}

class _ContainerOnOffConditionState extends State<ContainerOnOffCondition> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FFAppState(), // ฟัง state ตลอด
      builder: (context, _) {
        final bool isOn = FFAppState().logtap; // true = on

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300), // ปรับได้ตามชอบ
          width: widget.width ?? double.infinity,
          height: isOn
              ? (widget.height ?? double.infinity)
              : (widget.heightfalse ?? 0.0),
          color: widget.color ?? const Color.fromARGB(0, 0, 0, 0),
        );
      },
    );
  }
}
