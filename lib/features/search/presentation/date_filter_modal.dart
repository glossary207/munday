import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_state.dart';

void showDateFilterModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black,
    builder: (dialogContext) => ChangeNotifierProvider.value(
      value: context.read<SearchState>(),
      child: const _DateFilterModal(),
    ),
  );
}

class _DateFilterModal extends StatelessWidget {
  const _DateFilterModal();

  @override
  Widget build(BuildContext context) {
    final searchState = context.watch<SearchState>();
    final now = DateTime.now();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Text(
            'When do you want to go out?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.black,
                surface: Colors.black,
                onSurface: Colors.white,
              ),
            ),
            child: CalendarDatePicker(
              initialDate: searchState.selectedDate ?? now,
              firstDate: now.subtract(const Duration(days: 365)),
              lastDate: now.add(const Duration(days: 365)),
              onDateChanged: (date) {
                context.read<SearchState>().updateSelectedDate(date);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
