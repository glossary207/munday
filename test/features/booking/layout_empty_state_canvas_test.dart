import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munday/shared/widgets/layout/layout_preview_widget.dart';

void main() {
  test('booking scroll content does not contain flex children', () {
    final source = File(
      'lib/features/booking/presentation/booking/booking_page.dart',
    ).readAsStringSync();

    expect(
      source,
      isNot(contains('Flexible(')),
      reason:
          'Flexible inside the booking scroll view causes unbounded-height '
          'RenderFlex failures.',
    );
  });

  testWidgets('shows a visible loaded layout when the floor has no tables', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: LayoutEmptyStateCanvas(
              width: 360,
              height: 420,
              date: DateTime(2026, 8, 12),
              floorId: 'F1',
              floorKeys: ['F1'],
            ),
          ),
        ),
      ),
    );

    expect(find.text('พบผังร้านแล้ว'), findsOneWidget);
    expect(find.text('ชั้น F1 • ยังไม่มีโต๊ะ'), findsOneWidget);
    expect(find.text('2026-08-12'), findsOneWidget);
    expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
  });
}
