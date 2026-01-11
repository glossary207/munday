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

class Calendarslide extends StatefulWidget {
  const Calendarslide({
    Key? key,
    this.width,
    this.height,
    this.dateNow,
    this.dateEvent,
    this.colorPicker,
    this.icon,
    required this.onselect,
    this.dateclickwidget,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DateTime? dateNow;
  final List<DateTime>? dateEvent;
  final Color? colorPicker;
  final Widget? icon;
  final Future<dynamic> Function() onselect;
  final DateTime? dateclickwidget;

  @override
  _CalendarslideState createState() => _CalendarslideState();
}

class _CalendarslideState extends State<Calendarslide> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    DateTime startDate = _getStartDate();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: List.generate(_calculateNumberOfDays(), (index) {
          // currentDate เริ่มต้นจากวันที่กำหนด (startDate) และเลื่อนไปตาม index
          DateTime currentDate = startDate.add(Duration(days: index));

          // ไม่รีเซ็ตเป็น 00:00:00 แล้ว เพราะเราใช้ concept วันเริ่มที่ 07:00
          // currentDate จะเป็น 07:00 ของแต่ละวันตาม block start

          bool isSelected = selectedDate == currentDate;
          bool isDateClickWidget = widget.dateclickwidget != null &&
              widget.dateclickwidget!.year == currentDate.year &&
              widget.dateclickwidget!.month == currentDate.month &&
              widget.dateclickwidget!.day == currentDate.day;

          // ตรวจสอบว่ามีเหตุการณ์ในวันนี้หรือไม่ (ตามวันที่ปฏิทิน)
          bool isEventDate = widget.dateEvent?.any((eventDate) =>
                  eventDate.year == currentDate.year &&
                  eventDate.month == currentDate.month &&
                  eventDate.day == currentDate.day) ??
              false;

          // กำหนดว่าเป็นวันหยุดสุดสัปดาห์หรือไม่
          bool isWeekend = currentDate.weekday == DateTime.saturday ||
              currentDate.weekday == DateTime.sunday;

          // กำหนดสีของตัวอักษรวัน
          Color dayNameColor;
          if (isWeekend) {
            dayNameColor =
                isSelected || isDateClickWidget ? Colors.white : Colors.red;
          } else {
            dayNameColor = FlutterFlowTheme.of(context).bodyMedium.color!;
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = currentDate;
                // เมื่อกดเลือก ให้บวกเวลาอีก 8 ชั่วโมง
                FFAppState().dateclick = selectedDate!.add(Duration(hours: 8));
                widget.onselect(); // เรียกใช้ action เมื่อเลือกวันที่
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3.5),
              width: widget.width ?? 100,
              height: widget.height ?? 171,
              decoration: BoxDecoration(
                color: isDateClickWidget
                    ? widget.colorPicker ?? FlutterFlowTheme.of(context).primary
                    : const Color.fromARGB(255, 13, 13, 13),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ตัวอักษรบอกวัน (Mon, Tue, ...)
                    Text(
                      _getDayName(currentDate),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                            color: dayNameColor,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        currentDate.day.toString(),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white, // ตัวเลขวันเป็นสีขาวเสมอ
                            ),
                      ),
                    ),
                    // ไอคอนเหตุการณ์ (ดาว) หากมีเหตุการณ์ในวันนี้
                    Icon(
                      Icons.star,
                      color: isEventDate ? Colors.white : Colors.transparent,
                      size: 11,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ฟังก์ชันสำหรับคำนวณ block start day ตามเงื่อนไข 7 โมงเช้า
  DateTime _blockStart(DateTime dt) {
    final dayStart = DateTime(dt.year, dt.month, dt.day);
    if (dt.hour < 7) {
      final previousDay = dayStart.subtract(const Duration(days: 1));
      return DateTime(previousDay.year, previousDay.month, previousDay.day, 7);
    } else {
      return DateTime(dt.year, dt.month, dt.day, 7);
    }
  }

  DateTime _getStartDate() {
    DateTime nowDate = widget.dateNow ?? DateTime.now();
    // ใช้ blockStart เพื่อให้วันเริ่มต้นอยู่ใน format ที่วันใหม่เริ่มตอน 7 โมง
    return _blockStart(nowDate);
  }

  int _calculateNumberOfDays() {
    return 60; // แสดง 60 วัน
  }

  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}
