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
import 'package:munday/core/theme/theme.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class Tagpay extends ConsumerStatefulWidget {
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
  ConsumerState<Tagpay> createState() => _TagpayState();
}

class _TagpayState extends ConsumerState<Tagpay> {
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
              style: Theme.of(context).textTheme.bodyMedium!.override(
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
