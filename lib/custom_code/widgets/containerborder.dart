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

class Containerborder extends StatelessWidget {
  final double width;
  final double height;
  final double dashWidth;
  final double dashSpace;
  final Color borderColor;
  final double borderWidth;
  final IconData icon;
  final double iconSize;
  final Color? iconColor;

  const Containerborder({
    Key? key,
    this.width = 50,
    this.height = 50,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.borderColor = const Color(0xFF373737),
    this.borderWidth = 2,
    this.icon = Icons.add,
    this.iconSize = 24,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: CustomPaint(
        painter: _DashedCirclePainter(
          color: borderColor,
          strokeWidth: borderWidth,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
        ),
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: iconColor ?? FlutterFlowTheme.of(context).primaryText,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = (size.width / 2) - (strokeWidth / 2);
    const double startAngle = 0;
    final double circumference = 2 * 3.141592653589793 * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final double dashAngle = 2 * 3.141592653589793 / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final double start = i * dashAngle;
      final double end =
          start + (dashAngle * dashWidth / (dashWidth + dashSpace));
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        start,
        end - start,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
