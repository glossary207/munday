import 'package:flutter_test/flutter_test.dart';
import 'package:munday/backend/supabase/supabase_helper.dart';

void main() {
  test('normalizes legacy x/y geometry and nested meta', () {
    final normalized = SupabaseHelper.normalizeLayoutPayload({
      'id': 'layout-1',
      'other_data': {
        'floors': {
          'F1': {
            'table_layout': {
              'table_A1': {
                'x': 120,
                'y': 200,
                'width': 60,
                'height': 40,
                'status': {'status_code': 'pending', 'customer_uid': 'user-1'},
                'meta': {
                  'price': 1000,
                  'min_capacity': 2,
                  'max_capacity': 4,
                  'table_name': 'A1',
                },
              },
            },
          },
        },
      },
    });

    final table =
        normalized['other_data']['floors']['F1']['table_layout']['table_A1']
            as Map<String, dynamic>;
    expect(table['xi'], [120.0, 180.0]);
    expect(table['yi'], [200.0, 240.0]);
    expect(table['price'], 1000);
    expect(table['min_seat'], 2);
    expect(table['max_seat'], 4);
    expect(table['table_name'], 'A1');
  });

  test('keeps legacy tables when normalized migration only has a floor', () {
    final merged = SupabaseHelper.mergeLayoutSources(
      baseLayout: {
        'id': 'layout-1',
        'other_data': {
          'floors': {
            'F1': {
              'table_layout': {
                'table_A1': {
                  'x': 120,
                  'y': 200,
                  'width': 60,
                  'height': 60,
                  'status': {'status_code': 'available'},
                },
              },
            },
          },
        },
      },
      normalizedFloors: {
        'F1': {'_row_id': 'floor-row-1', 'table_layout': <String, dynamic>{}},
      },
    );

    final floor = merged['floors']['F1'] as Map<String, dynamic>;
    final table = floor['table_layout']['table_A1'] as Map<String, dynamic>;
    expect(floor['_row_id'], 'floor-row-1');
    expect(table['xi'], [120.0, 180.0]);
    expect(table['yi'], [200.0, 260.0]);
    expect(merged['_layout_inventory'], {
      'legacy_tables': 1,
      'normalized_tables': 0,
      'merged_tables': 1,
    });
  });

  test(
    'normalized table overrides live fields without dropping legacy tables',
    () {
      final merged = SupabaseHelper.mergeLayoutSources(
        baseLayout: {
          'other_data': {
            'F1': {
              'table_layout': {
                'table_A1': {
                  'xi': [10, 70],
                  'yi': [20, 80],
                  'price': 500,
                  'status': {'status_code': 'available'},
                },
                'table_A2': {
                  'xi': [90, 150],
                  'yi': [20, 80],
                  'status': {'status_code': 'available'},
                },
              },
            },
          },
        },
        normalizedFloors: {
          'F1': {
            'table_layout': {
              'table_A1': {
                'xi': [12, 72],
                'yi': [22, 82],
                'status': {'status_code': 'pending', 'customer_uid': 'user-1'},
              },
            },
          },
        },
      );

      final tables = merged['floors']['F1']['table_layout'] as Map;
      expect(tables.keys, containsAll(['table_A1', 'table_A2']));
      expect(tables['table_A1']['xi'], [12, 72]);
      expect(tables['table_A1']['price'], 500);
      expect(tables['table_A1']['status']['status_code'], 'pending');
    },
  );

  test('maps a direct legacy table layout onto the normalized floor key', () {
    final merged = SupabaseHelper.mergeLayoutSources(
      baseLayout: {
        'table_layout': {
          'table_A1': {
            'xi': [0, 60],
            'yi': [0, 60],
          },
        },
      },
      normalizedFloors: {
        'Ground': {
          '_row_id': 'floor-row-ground',
          'table_layout': <String, dynamic>{},
        },
      },
    );

    expect(merged['floors']['Ground']['table_layout'], contains('table_A1'));
    expect(merged['floors'], isNot(contains('F1')));
  });
}
