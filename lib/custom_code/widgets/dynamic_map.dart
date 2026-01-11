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

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

class DynamicMap extends StatefulWidget {
  const DynamicMap({
    super.key,
    this.width,
    this.height,
    this.points,
    required this.accessToken,
    this.startingPoint,
    this.startingZoom,
  });

  final double? width;
  final double? height;
  final List<LatLng>? points;
  final String accessToken;
  final LatLng? startingPoint;
  final double? startingZoom;

  @override
  State<DynamicMap> createState() => _DynamicMapState();
}

class _DynamicMapState extends State<DynamicMap> {
  List<Marker> allMarkers = []; // Added missing semicolon

  @override
  void initState() {
    super.initState(); // Fixed by adding parentheses
    if (widget.points != null) {
      // Avoid unnecessary null check
      addMarkersToMap(widget.points);
    }
  }

  void addMarkersToMap(List<LatLng>? points) {
    if (points != null) {
      for (LatLng point in points) {
        allMarkers.add(
          Marker(
            point: ll.LatLng(point.latitude, point.longitude),
            height: 15,
            width: 15,
            child: Icon(
              Icons.location_on, // Icon reference
              color: Colors.red, // Color reference
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: ll.LatLng(
            widget.startingPoint!.latitude,
            widget
                .startingPoint!.longitude), // Ensure startingPoint is not null
        initialZoom:
            widget.startingZoom ?? 14.0, // Provide default zoom if null
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/glossary207/cm0mlzi4600c901qy574e8vb8/tiles/256/{z}/{x}/{y}@2x?access_token=${widget.accessToken}', // Corrected typo
        ),
        MarkerLayer(markers: allMarkers), // Fixed marker layer
      ],
    );
  }
}
