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
import '/shared/widgets/index.dart'; // Imports other custom widgets
import '/core/utils/index.dart'; // Imports custom actions
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
  static const TextStyle _style = TextStyle(
    color: Color(0xFFBCBCBC),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
  );

  Future<String?>? _locationFuture;
  double? _lastLat;
  double? _lastLng;

  bool get _hasValidLocation {
    final loc = widget.locationNow;
    if (loc == null) return false;
    return !(loc.latitude == 0.0 && loc.longitude == 0.0);
  }

  @override
  void initState() {
    super.initState();
    if (_hasValidLocation) {
      _lastLat = widget.locationNow!.latitude;
      _lastLng = widget.locationNow!.longitude;
      _locationFuture = _getProvince(_lastLat!, _lastLng!);
    }
  }

  @override
  void didUpdateWidget(LocationName oldWidget) {
    super.didUpdateWidget(oldWidget);
    final loc = widget.locationNow;
    if (loc == null || (loc.latitude == 0.0 && loc.longitude == 0.0)) return;
    if (loc.latitude != _lastLat || loc.longitude != _lastLng) {
      _lastLat = loc.latitude;
      _lastLng = loc.longitude;
      setState(() {
        _locationFuture = _getProvince(_lastLat!, _lastLng!);
      });
    }
  }

  Future<String?> _getProvince(double lat, double lng) async {
    const String apiKey = 'AIzaSyCvraDTa5qHL6xNKTWn3JOKPUu5IBU18Fc';
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          for (var component in data['results'][0]['address_components']) {
            final types = component['types'] as List<dynamic>;
            if (types.contains('administrative_area_level_1')) {
              return component['long_name'] as String?;
            }
          }
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasValidLocation) return const SizedBox.shrink();

    return FutureBuilder<String?>(
      future: _locationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        final name = snapshot.data;
        if (name == null || name.isEmpty) return const SizedBox.shrink();
        return Text(name, style: _style);
      },
    );
  }
}
