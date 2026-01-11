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

import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationName extends StatefulWidget {
  const LocationName({
    super.key,
    this.width,
    this.height,
    this.locationNow,
  });

  final double? width;
  final double? height;
  final LatLng? locationNow;

  @override
  State<LocationName> createState() => _LocationNameState();
}

class _LocationNameState extends State<LocationName> {
  Future<String?> _getSubArea(double lat, double lng) async {
    const String apiKey =
        'AIzaSyCvraDTa5qHL6xNKTWn3JOKPUu5IBU18Fc'; // ใส่ API Key ของคุณ
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'].isNotEmpty) {
          String? level1; // จังหวัดหรือกรุงเทพ
          String? level2; // อำเภอ หรือ เขต
          String? level3; // ตำบล หรือ แขวง

          for (var component in data['results'][0]['address_components']) {
            List<dynamic> types = component['types'];
            if (types.contains('administrative_area_level_1')) {
              level1 = component['long_name'];
            }
            if (types.contains('administrative_area_level_2')) {
              level2 = component['long_name'];
            }
            if (types.contains('administrative_area_level_3')) {
              level3 = component['long_name'];
            }
          }

          // ตรวจสอบว่าอยู่กรุงเทพหรือไม่
          if (level1 != null && level1.contains('กรุงเทพมหานคร')) {
            // กรุงเทพมหานคร: administrative_area_level_3 คือ แขวง
            if (level3 != null) {
              return level3; // แขวง
            } else if (level2 != null) {
              return level2; // เผื่อกรณีไม่เจอ level3
            }
          } else {
            // ต่างจังหวัด: administrative_area_level_3 คือ ตำบล ถ้าไม่มีลอง fallback ไป level2
            if (level3 != null) {
              return level3; // ตำบล
            } else if (level2 != null) {
              return level2; // อำเภอ
            }
          }
        }
        return null; // No data found
      } else {
        throw Exception('Failed to fetch location');
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.locationNow == null) {
      return const Text(
        'No location provided',
        style: TextStyle(fontSize: 12),
      );
    }

    return FutureBuilder<String?>(
      future: _getSubArea(
        widget.locationNow!.latitude,
        widget.locationNow!.longitude,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading...',
            style: TextStyle(fontSize: 12),
          );
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(fontSize: 12),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return Text(
            snapshot.data!,
            style: const TextStyle(fontSize: 12),
          );
        } else {
          return const Text(
            'No data available',
            style: TextStyle(fontSize: 12),
          );
        }
      },
    );
  }
}
