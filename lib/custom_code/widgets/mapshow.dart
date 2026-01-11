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

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;

class Mapshow extends StatefulWidget {
  const Mapshow({
    super.key,
    this.width,
    this.height,
    this.locationVenuse,
    this.cerrentlocation,
    this.zoomstart,
    this.zoomMin,
    this.zoomMax,
    this.markerIcon,
    this.markerMeIcon,
    this.mapType,
    this.compassEnabled,
    this.moveMapCondition, // เพิ่มพารามิเตอร์สำหรับเงื่อนไขเลื่อนกล้อง
  });

  /// กำหนดความกว้างสูงของ Widget หากไม่กำหนดจะเต็มพื้นที่
  final double? width;
  final double? height;

  /// จุดที่ต้องการแสดงตำแหน่งของ Venue
  final LatLng? locationVenuse;

  /// ตำแหน่งปัจจุบัน (Current Location)
  final LatLng? cerrentlocation;

  /// ค่า Zoom เริ่มต้น
  final double? zoomstart;

  /// ค่า Zoom ต่ำสุด
  final double? zoomMin;

  /// ค่า Zoom สูงสุด
  final double? zoomMax;

  /// URL รูปภาพ Marker สำหรับ Venue
  final String? markerIcon;

  /// URL รูปภาพ Marker สำหรับตำแหน่งปัจจุบัน
  final String? markerMeIcon;

  /// ประเภทแผนที่ (normal, satellite, terrain, hybrid)
  final String? mapType;

  /// เปิด/ปิดแสดงเข็มทิศ
  final bool? compassEnabled;

  /// ตัวแปร bool ไว้คุมเงื่อนไขเลื่อนกล้อง
  final bool? moveMapCondition;

  @override
  State<Mapshow> createState() => _MapshowState();
}

class _MapshowState extends State<Mapshow> {
  /// Controller สำหรับ GoogleMap
  final Completer<gmf.GoogleMapController> _controller = Completer();

  /// เก็บ Marker ทั้งหมดในแผนที่
  Set<gmf.Marker> _markers = {};

  /// สถานะการโหลด Map Style
  bool _isMapStyleApplied = false;

  /// สถานะการโหลด Marker Icons
  bool _isMarkerLoaded = false;

  /// Marker Icon สำหรับ Venue
  gmf.BitmapDescriptor? _markerIcon;

  /// Marker Icon สำหรับตำแหน่งปัจจุบัน
  gmf.BitmapDescriptor? _markerMeIcon;

  /// ตัวแปรตรวจสอบว่าอยู่บนเว็บหรือไม่ (กำหนดเอง/เช็ค Platform)
  final bool isWeb = false;

  /// กำหนดสไตล์แผนที่ (ลบหรือแก้ไขได้ตามต้องการ)
  String mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#000000"
        }
      ]
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "on"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#000000"
        }
      ]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "administrative.country",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "stylers": [
        {
          "visibility": "on"
        }
      ]
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#bdbdbd"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#1f4225"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#000000"
        }
      ]
    },
    {
      "featureType": "poi.business",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#303030"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#7d531c"
        }
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#6c491a"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#303030"
        }
      ]
    },
    {
      "featureType": "transit",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#321111"
        }
      ]
    },
    {
      "featureType": "transit.station.rail",
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "on"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#1a2e3d"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#cccccc"
        }
      ]
    }
  ]
  ''';

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  /// ฟังก์ชันสำหรับโหลด Icon จาก URL แล้วแปลงเป็น BitmapDescriptor
  Future<gmf.BitmapDescriptor> _getBitmapDescriptorFromUrl(String url) async {
    if (isWeb) {
      // สำหรับเว็บ ให้ใช้ default marker หรือวิธีอื่นที่รองรับบนเว็บ
      return gmf.BitmapDescriptor.defaultMarker;
    } else {
      try {
        final http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final Uint8List bytes = response.bodyBytes;
          final ui.Codec codec =
              await ui.instantiateImageCodec(bytes, targetWidth: 130);
          final ui.FrameInfo fi = await codec.getNextFrame();
          final ByteData? byteData =
              await fi.image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData != null) {
            final Uint8List resizedBytes = byteData.buffer.asUint8List();
            return gmf.BitmapDescriptor.fromBytes(resizedBytes);
          }
        }
      } catch (e) {
        print('Error loading image: $e');
      }
      // หากเกิดข้อผิดพลาด ให้ใช้ default marker
      return gmf.BitmapDescriptor.defaultMarker;
    }
  }

  /// ฟังก์ชันสำหรับเตรียมข้อมูลก่อนสร้างแผนที่
  Future<void> _initializeMap() async {
    // โหลด Marker Icon สำหรับ Venue
    if (widget.markerIcon != null && widget.markerIcon!.isNotEmpty) {
      _markerIcon = await _getBitmapDescriptorFromUrl(widget.markerIcon!);
    }
    // โหลด Marker Icon สำหรับตำแหน่งปัจจุบัน
    if (widget.markerMeIcon != null && widget.markerMeIcon!.isNotEmpty) {
      _markerMeIcon = await _getBitmapDescriptorFromUrl(widget.markerMeIcon!);
    }

    // สร้าง Marker
    _setMarkers();

    setState(() {
      _isMarkerLoaded = true;
    });
  }

  /// ฟังก์ชันสำหรับสร้าง Marker 2 จุด (locationVenuse และ currentLocation)
  void _setMarkers() {
    final Set<gmf.Marker> markers = {};

    // Marker สำหรับ Venue
    if (widget.locationVenuse != null) {
      markers.add(
        gmf.Marker(
          markerId: const gmf.MarkerId('location_venuse'),
          position: gmf.LatLng(
            widget.locationVenuse!.latitude,
            widget.locationVenuse!.longitude,
          ),
          icon: _markerIcon ?? gmf.BitmapDescriptor.defaultMarker,
          zIndex: 2.0,
        ),
      );
    }

    // Marker สำหรับตำแหน่งปัจจุบัน
    if (widget.cerrentlocation != null) {
      markers.add(
        gmf.Marker(
          markerId: const gmf.MarkerId('current_location'),
          position: gmf.LatLng(
            widget.cerrentlocation!.latitude,
            widget.cerrentlocation!.longitude,
          ),
          icon: _markerMeIcon ??
              gmf.BitmapDescriptor.defaultMarkerWithHue(
                gmf.BitmapDescriptor.hueBlue,
              ),
          zIndex: 3.0,
        ),
      );
    }

    _markers = markers;
  }

  /// ฟังก์ชันแปลง string เป็น MapType
  gmf.MapType _getMapType(String? type) {
    switch (type) {
      case 'normal':
        return gmf.MapType.normal;
      case 'satellite':
        return gmf.MapType.satellite;
      case 'terrain':
        return gmf.MapType.terrain;
      case 'hybrid':
        return gmf.MapType.hybrid;
      default:
        return gmf.MapType.normal;
    }
  }

  /// ฟังก์ชันเลื่อนกล้องไปยังตำแหน่งปัจจุบัน (cerrentlocation)
  Future<void> _moveToCurrentLocation() async {
    if (widget.cerrentlocation == null) return;

    final controller = await _controller.future;
    await controller.animateCamera(
      gmf.CameraUpdate.newCameraPosition(
        gmf.CameraPosition(
          target: gmf.LatLng(
            widget.cerrentlocation!.latitude,
            widget.cerrentlocation!.longitude,
          ),
          zoom: widget.zoomstart ?? 15.0,
        ),
      ),
    );
  }

  /// เมื่อ Widget ถูก update (มีการ rebuild ด้วยเหตุผลต่าง ๆ)
  /// ให้ตรวจสอบว่า moveMapCondition เป็น true หรือไม่
  /// ถ้าเป็น true ให้เลื่อนกล้องไปยัง current location
  @override
  void didUpdateWidget(covariant Mapshow oldWidget) {
    super.didUpdateWidget(oldWidget);

    // หาก moveMapCondition ถูกเปิด (เป็น true) -> เรียก _moveToCurrentLocation
    if (widget.moveMapCondition == true) {
      _moveToCurrentLocation();
      // หากต้องการรีเซ็ตกลับเป็น false อัตโนมัติ ก็ทำได้ แต่ต้องระวังการแก้ค่าใน Widget
      // (ถ้าเป็น FFAppState() ก็เรียก FFAppState().MoveMap = false ได้)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: Stack(
        children: [
          gmf.GoogleMap(
            /// กำหนดให้ LocationVenuse เป็นตำแหน่งเริ่มต้นของกล้อง (center)
            initialCameraPosition: gmf.CameraPosition(
              target: widget.locationVenuse != null
                  ? gmf.LatLng(
                      widget.locationVenuse!.latitude,
                      widget.locationVenuse!.longitude,
                    )
                  : const gmf.LatLng(0, 0),
              zoom: widget.zoomstart ?? 14.0,
            ),
            mapType: _getMapType(widget.mapType),
            markers: _isMarkerLoaded ? _markers : {},
            compassEnabled: widget.compassEnabled ?? true,
            minMaxZoomPreference: gmf.MinMaxZoomPreference(
              widget.zoomMin ?? 0,
              widget.zoomMax ?? 20,
            ),
            zoomControlsEnabled: false, // ซ่อนปุ่ม Zoom +/-
            onMapCreated: (gmf.GoogleMapController controller) async {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
              // ตั้งค่า Map Style (ยกเว้นบนเว็บ)
              if (!isWeb) {
                try {
                  await controller.setMapStyle(mapStyle);
                } catch (e) {
                  print('Error setting map style: $e');
                }
              }
              setState(() {
                _isMapStyleApplied = true;
              });
            },
            onCameraMove: (gmf.CameraPosition position) {
              // หากต้องการใช้งานตำแหน่งกล้องเพื่ออัปเดตใน State หรือ AppState
              // สามารถนำ position.target.latitude / longitude ไปใช้ได้
            },
          ),
          // แสดง Loading ปิดทับ เมื่อยังโหลด MapStyle หรือ Marker ไม่เสร็จ
          if (!_isMapStyleApplied || !_isMarkerLoaded)
            Positioned.fill(
              child: Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
