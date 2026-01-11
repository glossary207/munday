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

import '/flutter_flow/flutter_flow_util.dart'; // นำเข้า isWeb

import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmf;
import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/animation.dart'; // นำเข้าแพ็กเกจสำหรับอนิเมชัน

class MapVenuse extends StatefulWidget {
  const MapVenuse({
    Key? key,
    this.width,
    this.height,
    this.items,
    this.itemClick,
    this.locationStart,
    this.zoomStart,
    this.zoomMin,
    this.zoomMax,
    this.markerIcon,
    this.markerMeIcon,
    this.compassEnabled,
    this.mapType,
    this.currentLocation,
    this.makerSelectedIcon,
    this.whenSelect,
    this.whenSetStyleSuccess,
    this.moveMapCondition,
    this.radian, // เพิ่มพารามิเตอร์ radian
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<VenuesRecord>? items;
  final SupabaseDocRef? itemClick;
  final LatLng? locationStart;
  final double? zoomStart;
  final double? zoomMin;
  final double? zoomMax;
  final String? markerIcon;
  final String? markerMeIcon;
  final bool? compassEnabled;
  final String? mapType;
  final LatLng? currentLocation;
  final String? makerSelectedIcon;
  final Future Function()? whenSelect;
  final Future Function()? whenSetStyleSuccess;
  final bool? moveMapCondition;
  final double? radian; // เพิ่มพารามิเตอร์ radian

  @override
  State<MapVenuse> createState() => _MapVenuseState();
}

class _MapVenuseState extends State<MapVenuse>
    with SingleTickerProviderStateMixin {
  // Map controller
  Completer<gmf.GoogleMapController> _controller = Completer();

  // Map style
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

  // Set of markers
  Set<gmf.Marker> _markers = {};

  // Set of circles
  Set<gmf.Circle> _circles = {};

  // Animated circle
  gmf.Circle? _animatedCircle;

  // Custom marker icons
  gmf.BitmapDescriptor? _customMarkerIcon;
  gmf.BitmapDescriptor? _customMarkerMeIcon;
  gmf.BitmapDescriptor? _customMarkerSelectedIcon;

  // Animation controllers and animations
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Custom state for loading
  bool _isMapStyleApplied = false;
  bool _isMarkerLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();

    // ตั้งค่า AnimationController และ Animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600), // Duration สำหรับ Scale
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addListener(() {
      _updateAnimatedCircle();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeMap() async {
    await _loadCustomMarkerIcons();
    _setMarkers();
    _setCircles();
    if (FFAppState().VenuseSelection != null) {
      _moveToSelectedVenuse();
    } else if (widget.locationStart != null) {
      _moveToLocation(widget.locationStart!);
    }
  }

  Future<void> _loadCustomMarkerIcons() async {
    try {
      if (widget.markerIcon != null && widget.markerIcon!.isNotEmpty) {
        _customMarkerIcon =
            await _getBitmapDescriptorFromUrl(widget.markerIcon!);
      }
      if (widget.markerMeIcon != null && widget.markerMeIcon!.isNotEmpty) {
        _customMarkerMeIcon =
            await _getBitmapDescriptorFromUrl(widget.markerMeIcon!);
      }
      if (widget.makerSelectedIcon != null &&
          widget.makerSelectedIcon!.isNotEmpty) {
        _customMarkerSelectedIcon =
            await _getBitmapDescriptorFromUrl(widget.makerSelectedIcon!);
      }
      setState(() {
        _isMarkerLoaded = true;
      });
    } catch (e) {
      print('Error loading custom markers: $e');
      setState(() {
        _isMarkerLoaded = true;
      });
    }
  }

  Future<gmf.BitmapDescriptor> _getBitmapDescriptorFromUrl(String url) async {
    if (isWeb) {
      // สำหรับเว็บ ให้ใช้ default marker หรือวิธีอื่นที่รองรับเว็บ
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
          } else {
            throw Exception('Failed to convert image to ByteData.');
          }
        } else {
          throw Exception('Failed to download image from URL.');
        }
      } catch (e) {
        print('Error loading image: $e');
        // หากเกิดข้อผิดพลาด ให้ใช้ default marker
        return gmf.BitmapDescriptor.defaultMarker;
      }
    }
  }

  void _setMarkers() {
    if (!_isMarkerLoaded) return;

    Set<gmf.Marker> markers = {};
    if (widget.items != null) {
      for (final venuse in widget.items!) {
        if (venuse.position != null) {
          final position = gmf.LatLng(
            venuse.position!.latitude,
            venuse.position!.longitude,
          );

          final isSelected = FFAppState().VenuseSelection != null &&
              FFAppState().VenuseSelection == venuse.reference;

          final markerIcon = isSelected
              ? (_customMarkerSelectedIcon ??
                  gmf.BitmapDescriptor.defaultMarker)
              : (_customMarkerIcon ?? gmf.BitmapDescriptor.defaultMarker);

          final marker = gmf.Marker(
            markerId: gmf.MarkerId(venuse.reference.id),
            position: position,
            icon: markerIcon,
            zIndex: isSelected
                ? 3.0
                : 2.0, // ตั้งค่า zIndex ของไอคอนให้สูงกว่าวงกลม
            onTap: () async {
              FFAppState().VenuseSelection = venuse.reference;
              setState(() {
                _setMarkers();
              });
              await _moveToSelectedVenuse();
              if (widget.whenSelect != null) {
                await widget.whenSelect!();
              }
            },
          );
          markers.add(marker);
        }
      }
    }

    // เพิ่ม Marker ของ currentLocation
    if (widget.currentLocation != null) {
      final position = gmf.LatLng(
        widget.currentLocation!.latitude,
        widget.currentLocation!.longitude,
      );
      final marker = gmf.Marker(
        markerId: const gmf.MarkerId('current_location'),
        position: position,
        icon: _customMarkerMeIcon ??
            gmf.BitmapDescriptor.defaultMarkerWithHue(
              gmf.BitmapDescriptor.hueBlue,
            ),
        zIndex: 4.0, // ตั้งค่า zIndex ให้สูงที่สุดสำหรับตำแหน่งปัจจุบัน
      );
      markers.add(marker);
    }

    setState(() {
      _markers = markers;
    });
  }

  // ฟังก์ชันสำหรับตั้งค่า Circle
  void _setCircles() {
    if (widget.currentLocation != null && widget.radian != null) {
      _animatedCircle = gmf.Circle(
        circleId: gmf.CircleId('animated_radius_circle'),
        center: gmf.LatLng(
          widget.currentLocation!.latitude,
          widget.currentLocation!.longitude,
        ),
        radius: 0, // เริ่มต้นด้วยรัศมี 0
        fillColor: Colors.transparent,
        strokeColor: Colors.transparent,
        strokeWidth: 3,
        zIndex: 0, // ตั้งค่า zIndex ของวงกลมให้ต่ำกว่าไอคอน
      );

      _circles = {_animatedCircle!};
    } else {
      _circles = {};
    }
    setState(() {});
  }

  // ฟังก์ชันสำหรับอัปเดต Circle ตามอนิเมชัน
  void _updateAnimatedCircle() {
    if (_animatedCircle != null &&
        widget.currentLocation != null &&
        widget.radian != null) {
      final scale = _scaleAnimation.value;

      final radius = widget.radian! *
          1000 *
          scale; // แปลงรัศมีจากกิโลเมตรเป็นเมตรและคูณด้วย scale

      final fillColor = Color.fromARGB(10, 255, 0, 0); // สีพื้นหลังพร้อมโปร่งใส
      final strokeColor = Color.fromARGB(60, 255, 0, 0); // สีขอบ

      _animatedCircle = gmf.Circle(
        circleId: _animatedCircle!.circleId,
        center: _animatedCircle!.center,
        radius: radius,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidth: 3,
        zIndex: 0,
      );

      _circles = {_animatedCircle!};

      setState(() {});
    }
  }

  Future<void> _moveToSelectedVenuse() async {
    if (FFAppState().VenuseSelection != null) {
      final venuseRecord =
          await VenuesRecord.getDocumentOnce(FFAppState().VenuseSelection!);
      if (venuseRecord != null && venuseRecord.position != null) {
        final controller = await _controller.future;
        final position = gmf.LatLng(
          venuseRecord.position!.latitude,
          venuseRecord.position!.longitude,
        );
        controller.animateCamera(gmf.CameraUpdate.newLatLng(position));
      }
    }
  }

  Future<void> _moveToLocation(LatLng location) async {
    final controller = await _controller.future;
    final position = gmf.LatLng(
      location.latitude,
      location.longitude,
    );
    controller.animateCamera(gmf.CameraUpdate.newLatLng(position));

    // รันอนิเมชันเมื่อเคลื่อนที่ไปยังตำแหน่งใหม่
    _runAnimation();
  }

  Future<void> _moveToCurrentLocation() async {
    if (widget.currentLocation != null) {
      final controller = await _controller.future;
      final position = gmf.LatLng(
        widget.currentLocation!.latitude,
        widget.currentLocation!.longitude,
      );
      controller.animateCamera(gmf.CameraUpdate.newLatLng(position));

      // รันอนิเมชันเมื่อเคลื่อนที่ไปยังตำแหน่งปัจจุบัน
      _runAnimation();
    }
  }

  // ฟังก์ชันสำหรับรันอนิเมชัน
  void _runAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

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

  @override
  void didUpdateWidget(covariant MapVenuse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items ||
        oldWidget.currentLocation != widget.currentLocation ||
        oldWidget.itemClick != widget.itemClick) {
      _setMarkers();
    }
    if (oldWidget.itemClick != widget.itemClick) {
      _moveToSelectedVenuse();
    }

    // ตรวจสอบ FFAppState().MoveMap และเรียกใช้ _moveToCurrentLocation
    if (FFAppState().MoveMap == true) {
      _moveToCurrentLocation();
      // รีเซ็ตค่า FFAppState().MoveMap เป็น false
      FFAppState().MoveMap = false;
    }

    // ตรวจสอบการเปลี่ยนแปลงของ currentLocation และ radian เพื่ออัปเดตวงกลม
    if (oldWidget.currentLocation != widget.currentLocation ||
        oldWidget.radian != widget.radian) {
      _setCircles();
      _runAnimation(); // รันอนิเมชันเมื่อ currentLocation หรือ radian เปลี่ยนแปลง
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
            initialCameraPosition: gmf.CameraPosition(
              target: widget.locationStart != null
                  ? gmf.LatLng(
                      widget.locationStart!.latitude,
                      widget.locationStart!.longitude,
                    )
                  : const gmf.LatLng(0, 0),
              zoom: widget.zoomStart ?? 14,
            ),
            mapType: _getMapType(widget.mapType),
            markers: _isMarkerLoaded ? _markers : {},
            circles: _circles, // เพิ่ม circles เข้าไปใน GoogleMap
            compassEnabled: widget.compassEnabled ?? true,
            minMaxZoomPreference: gmf.MinMaxZoomPreference(
                widget.zoomMin ?? 0, widget.zoomMax ?? 20),
            onMapCreated: (gmf.GoogleMapController controller) async {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
              try {
                if (!isWeb) {
                  await controller.setMapStyle(mapStyle);
                }
              } catch (e) {
                print('Error setting map style: $e');
              }
              if (widget.whenSetStyleSuccess != null) {
                await widget.whenSetStyleSuccess!();
              }
              setState(() {
                _isMapStyleApplied = true;
              });

              // หลังจากแผนที่พร้อมแล้ว เคลื่อนที่ไปยังตำแหน่งที่ต้องการ
              if (FFAppState().VenuseSelection != null) {
                await _moveToSelectedVenuse();
              } else if (widget.locationStart != null) {
                await _moveToLocation(widget.locationStart!);
              } else if (widget.currentLocation != null &&
                  widget.moveMapCondition == true) {
                await _moveToCurrentLocation();
              }
            },
            zoomControlsEnabled: false,
            onCameraMove: (gmf.CameraPosition position) {
              FFAppState().MapCenter = LatLng(
                position.target.latitude,
                position.target.longitude,
              );
            },
          ),
          if (!_isMapStyleApplied || !_isMarkerLoaded)
            Positioned.fill(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
