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

class ContainerOnOffCondition extends ConsumerStatefulWidget {
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
  ConsumerState<ContainerOnOffCondition> createState() =>
      _ContainerOnOffConditionState();
}

class _ContainerOnOffConditionState extends ConsumerState<ContainerOnOffCondition> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState(), // ฟัง state ตลอด
      builder: (context, _) {
        final bool isOn = context.appState.logtap; // true = on

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
