import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_state.dart';

void showPriceFilterModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) => ChangeNotifierProvider.value(
      value: context.read<SearchState>(),
      child: const _PriceFilterDialog(),
    ),
  );
}

class _PriceFilterDialog extends StatefulWidget {
  const _PriceFilterDialog();

  @override
  State<_PriceFilterDialog> createState() => _PriceFilterDialogState();
}

class _PriceFilterDialogState extends State<_PriceFilterDialog> {
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    _currentRange = context.read<SearchState>().priceRange;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$${_currentRange.start.toInt()} - \$${_currentRange.end.toInt()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RangeSlider(
              values: _currentRange,
              min: 0,
              max: 100,
              activeColor: Colors.black,
              inactiveColor: Colors.grey[300],
              onChanged: (values) {
                setState(() {
                  _currentRange = values;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.read<SearchState>().updatePriceRange(_currentRange);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: Text(
                _currentRange.start == 0 && _currentRange.end == 100
                    ? 'FREE -> ANY AMOUNT'
                    : 'APPLY FILTER',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
