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

class CalendarslideEvent extends ConsumerStatefulWidget {
  const CalendarslideEvent({
    super.key,
    this.width,
    this.height,
    this.dateNow,
    this.colorPicker,
    required this.onselect,
    this.dateclickwidget,
  });

  final double? width;
  final double? height;
  final DateTime? dateNow;
  final Color? colorPicker;
  final Future Function() onselect;
  final DateTime? dateclickwidget;

  @override
  ConsumerState<CalendarslideEvent> createState() => _CalendarslideEventState();
}

class _CalendarslideEventState extends ConsumerState<CalendarslideEvent> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // ถ้ามีการเซ็ต context.appState.dateclick ไว้แล้ว ให้ใช้วันนั้นเป็น selectedDate
    // ไม่งั้นให้ใช้ค่าจาก _getStartDate()
    if (context.appState.dateclick != null) {
      selectedDate = DateTime(
        context.appState.dateclick!.year,
        context.appState.dateclick!.month,
        context.appState.dateclick!.day,
      );
    } else {
      selectedDate = _getStartDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = _getStartDate();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: List.generate(_calculateNumberOfDays(), (index) {
          DateTime currentDate = startDate.add(Duration(days: index));
          currentDate = DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
          );

          bool isSelected = selectedDate == currentDate;
          bool isDateClickWidget = widget.dateclickwidget != null &&
              widget.dateclickwidget!.year == currentDate.year &&
              widget.dateclickwidget!.month == currentDate.month &&
              widget.dateclickwidget!.day == currentDate.day;

          bool isWeekend = currentDate.weekday == DateTime.saturday ||
              currentDate.weekday == DateTime.sunday;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = DateTime(
                  currentDate.year,
                  currentDate.month,
                  currentDate.day,
                );
                context.appState.dateclick = selectedDate;
                widget.onselect();
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3.5),
              width: widget.width ?? 100,
              height: widget.height ?? 171,
              decoration: BoxDecoration(
                color: isDateClickWidget
                    ? (widget.colorPicker ??
                        Theme.of(context).colorScheme.primary)
                    : const Color.fromARGB(255, 13, 13, 13),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getDayName(currentDate),
                      style: Theme.of(context).textTheme.bodyMedium!.override(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                            color: isWeekend
                                ? (isSelected ? Colors.white : Colors.red)
                                : Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        currentDate.day.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.override(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                      ),
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

  DateTime _getStartDate() {
    DateTime startDate =
        widget.dateNow ?? DateTime.now().subtract(const Duration(days: 30));
    return DateTime(startDate.year, startDate.month, startDate.day);
  }

  int _calculateNumberOfDays() {
    return 60;
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
