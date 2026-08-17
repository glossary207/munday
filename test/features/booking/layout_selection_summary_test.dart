import 'package:flutter_test/flutter_test.dart';
import 'package:munday/features/booking/domain/layout_selection_summary.dart';

void main() {
  test('summarizes only tables owned by the current user across floors', () {
    final summary = summarizeOwnedLayoutSelection({
      'floors': {
        'F1': {
          'table_layout': {
            'A1': {
              'table_name': 'A1',
              'price': 500,
              'min_seat': 2,
              'status': {'status_code': 'pending', 'customer_uid': 'user-1'},
            },
            'A2': {
              'price': 700,
              'status': {'status_code': 'pending', 'customer_uid': 'user-2'},
            },
          },
        },
        'F2': {
          'table_layout': {
            'B1': {
              'table_name': 'VIP B1',
              'price': 1200.5,
              'min_seat': 4,
              'status': {
                'status_code': 'payment_pending',
                'customer_uid': 'user-1',
              },
            },
          },
        },
      },
    }, 'user-1');

    expect(summary.tableIds, ['A1', 'B1']);
    expect(summary.displayNames, ['A1', 'VIP B1']);
    expect(summary.totalPrice, 1700.5);
    expect(summary.minimumPartySize, 6);
  });

  test('returns an empty summary for an unauthenticated user', () {
    final summary = summarizeOwnedLayoutSelection({
      'table_layout': {
        'A1': {
          'status': {'status_code': 'available', 'customer_uid': ''},
        },
      },
    }, '');

    expect(summary.tableIds, isEmpty);
    expect(summary.totalPrice, 0);
  });
}
