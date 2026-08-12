// Automatic FlutterFlow imports
import '/backend/backend.dart'; // (kept if other generated parts rely on side-effects)
import 'package:flutter/foundation.dart'; // for listEquals in WallPainter
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' show RealtimeChannel, PostgresChangeEvent;
import '/backend/supabase/supabase_helper.dart';

class LayoutPreviewWidget extends StatefulWidget {
  final double width;
  final double height;
  final String currentuid;
  final String venueId; // ✅ เปลี่ยนจาก DocumentReference เป็น String
  final DateTime date;
  final String floorId; // optional: which floor to preview

  LayoutPreviewWidget({
    super.key, // ✅ เพิ่ม key parameter
    required this.width,
    required this.height,
    required this.currentuid,
    required this.venueId, // ✅ เปลี่ยนจาก venueRef เป็น venueId
    required this.date,
    this.floorId = 'F1',
  });

  @override
  _LayoutPreviewWidgetState createState() => _LayoutPreviewWidgetState();
}

class _LayoutPreviewWidgetState extends State<LayoutPreviewWidget> {
  late TransformationController _transformationController;
  Rect? _boundingBox; // cached current bounding box
  bool _initialTransformApplied = false; // apply only once per date
  double _calculatedMinScale = 0.1; // default value
  String _activeFloorId = 'F1';
  Offset? _panStartGlobalPosition;
  Offset _panStartTranslation = Offset.zero;
  double _panStartScale = 1.0;
  bool _isPanningCanvas = false;

  // user

  // ป้องกันการกดซ้ำ
  final Map<String, bool> _processingTables = {}; // tableId -> isProcessing
  final Map<String, int> _lastTapTime = {}; // tableId -> timestamp
  int _lastAnyTableTapTime = 0;

  DateTime? _apiSentTime;
  DateTime? _apiReceivedTime;
  final GlobalKey gridKey = GlobalKey(); // GlobalKey สำหรับ grid
  double _canvasWidth = 0; // เก็บขนาด canvas
  double _canvasHeight = 0;
  bool _isInLockMode = true;

  // --- Layout state ---
  Map<String, dynamic>? _layoutData;
  bool _layoutLoading = true;
  RealtimeChannel? _layoutChannel;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _transformationController.addListener(_onTransformChanged);
    _activeFloorId = widget.floorId;
    _initLayout(widget.venueId, _yyyyMMdd(widget.date));
  }

  @override
  void didUpdateWidget(covariant LayoutPreviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.venueId != widget.venueId ||
        oldWidget.date != widget.date ||
        oldWidget.floorId != widget.floorId) {
      _initialTransformApplied = false;
      _boundingBox = null;
      _activeFloorId = widget.floorId;
      _initLayout(widget.venueId, _yyyyMMdd(widget.date));
    }
  }

  /// fetch ครั้งแรก แล้วเปิด Realtime channel โดยตรง
  Future<void> _initLayout(String venueId, String dateString) async {
    if (_layoutChannel != null) {
      await SupabaseHelper.client.removeChannel(_layoutChannel!);
      _layoutChannel = null;
    }
    if (!mounted) return;
    setState(() { _layoutLoading = true; });

    // 1) fetch ครั้งแรก
    final first = await SupabaseHelper.fetchVenueDailyLayoutOnce(venueId, dateString);
    print('🔵 [LayoutPreview] first fetch: ${first == null ? 'null' : 'ok'}');
    if (!mounted) return;
    setState(() { _layoutData = first; _layoutLoading = false; });

    // 2) เปิด Realtime channel — subscribe venue_daily_layout_tables โดยตรง
    // ทุก row ที่เปลี่ยน (INSERT/UPDATE/DELETE) = event fires = refetch ทันที
    if (!mounted) return;

    final channelName = 'preview-layout-$venueId-$dateString-${DateTime.now().millisecondsSinceEpoch}';
    _layoutChannel = SupabaseHelper.client
        .channel(channelName)
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'venue_daily_layout_tables',
          callback: (payload) async {
            print('🟢 [LayoutPreview] Realtime: venue_daily_layout_tables changed (${payload.eventType})');
            final updated = await SupabaseHelper.fetchVenueDailyLayoutOnce(venueId, dateString);
            if (mounted && updated != null) setState(() { _layoutData = updated; });
          },
        )
        .subscribe((status, [err]) {
          print('🔵 [LayoutPreview] channel "$channelName" → $status${err != null ? ' err: $err' : ''}');
        });
  }

  /// fetch layout ใหม่ — เรียกหลังกดจอง/ปล่อยโต๊ะสำเร็จ
  Future<void> _refetchAndEmitLayout() async {
    final layout = await SupabaseHelper.fetchVenueDailyLayoutOnce(widget.venueId, _yyyyMMdd(widget.date));
    print('🔵 [LayoutPreview] refetch: ${layout == null ? 'null' : 'ok'}');
    if (mounted && layout != null) setState(() { _layoutData = layout; });
  }

  void _onTransformChanged() {
    if (!mounted) return;

    final m = _transformationController.value;
    final scale = m.getMaxScaleOnAxis();
    final translation = m.getTranslation();
    final scaledWidth = _canvasWidth * scale;
    final scaledHeight = _canvasHeight * scale;

    bool needsCorrection = false;
    double newX = translation.x;
    double newY = translation.y;

    // ✅ ถ้า canvas แคบกว่าจอ → center X (แต่เก็บ Y ไว้)
    if (scaledWidth < widget.width) {
      final correctX = (widget.width - scaledWidth) / 2.0;
      if ((newX - correctX).abs() > 0.5) {
        // tolerance
        newX = correctX;
        needsCorrection = true;
      }
    }

    // ✅ ถ้า canvas เตี้ยกว่าจอ → center Y (แต่เก็บ X ไว้)
    if (scaledHeight < widget.height) {
      final correctY = (widget.height - scaledHeight) / 2.0;
      if ((newY - correctY).abs() > 0.5) {
        newY = correctY;
        needsCorrection = true;
      }
    }

    if (needsCorrection) {
      _transformationController.removeListener(_onTransformChanged);
      _transformationController.value = Matrix4.identity()
        ..translate(newX, newY)
        ..scale(scale);
      _transformationController.addListener(_onTransformChanged);
    }
  }

// บังคับให้ canvas อยู่กึ่งกลางหน้าจอ
  void _centerCanvas() {
    // ✅ ตรวจสอบก่อนว่า canvas size ถูกต้อง
    if (_canvasWidth == 0 || _canvasHeight == 0) {
      return;
    }

    final scale = _transformationController.value.getMaxScaleOnAxis();
    final scaledWidth = _canvasWidth * scale;
    final scaledHeight = _canvasHeight * scale;

    final centerX = (widget.width - scaledWidth) / 2.0;
    final centerY = (widget.height - scaledHeight) / 2.0;

    // ✅ ปิด listener ก่อนอัปเดต (ป้องกัน infinite loop)
    _transformationController.removeListener(_onTransformChanged);

    _transformationController.value = Matrix4.identity()
      ..translate(centerX, centerY)
      ..scale(scale);

    // ✅ เปิด listener กลับ
    _transformationController.addListener(_onTransformChanged);
  }

  @override
  void dispose() {
    if (_layoutChannel != null) {
      SupabaseHelper.client.removeChannel(_layoutChannel!);
      _layoutChannel = null;
    }
    _transformationController.dispose();
    super.dispose();
  }

  bool _isProcessingAnyTable = false;

  // Debug helper สำหรับ Active_Reservations (Supabase version)
  void _debugActiveReservationData(
      String uid, String venueId, String dateString, String tableId) {
    print('🔍 ===== ACTIVE_RESERVATION DEBUG (Supabase) =====');
    final docId = '${uid}_${venueId}_$dateString';
    print('📋 Record ID: $docId');
    print('   user_id: $uid');
    print('   venue_id: $venueId');
    print('   date: $dateString');

    final now = DateTime.now();
    final expiresAt = now.add(Duration(minutes: 5));

    print('\n📦 Data Structure:');
    print('   user_id: $uid (UUID)');
    print('   venue_id: $venueId (UUID)');
    print('   date: $dateString (TEXT)');
    print('   table_ids: [$tableId] (TEXT[])');
    print('   status: "pending" (TEXT)');
    print('   created_at: $now (TIMESTAMPTZ)');
    print('   expires_at: $expiresAt (TIMESTAMPTZ)');

    final diffMinutes = expiresAt.difference(now).inMinutes.toDouble();
    print('\n⏰ Expiry Validation:');
    print('   Expires in: ${diffMinutes.toStringAsFixed(2)} minutes');
    print('   Valid range: 1-10 minutes');
    print(
        '   Result: ${diffMinutes >= 1 && diffMinutes <= 10 ? "✅ PASS" : "❌ FAIL"}');

    print('=====================================\n');
  }

  // ตรวจสอบว่าควรอนุญาตให้กดได้หรือไม่
  bool _canTap(String tableId) {
    // ตรวจสอบ global processing flag
    if (_isProcessingAnyTable) {
      return false;
    }

    // ตรวจสอบว่ากำลัง process อยู่หรือไม่
    if (_processingTables[tableId] == true) {
      return false;
    }

    // ตรวจสอบว่าเพิ่งกดไปหรือยัง (debounce 500ms)
    final now = DateTime.now().millisecondsSinceEpoch;
    final lastTap = _lastTapTime[tableId] ?? 0;
    if (now - _lastAnyTableTapTime < 200) {
      return false;
    }
    if (now - lastTap < 500) {
      return false;
    }

    return true;
  }

  double max(double a, double b) {
    return a > b ? a : b;
  }

  // ตรวจสอบว่าควรล็อค pan/zoom หรือไม่
  bool _shouldLockPanZoom() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    final scaledWidth = _canvasWidth * scale;
    final scaledHeight = _canvasHeight * scale;

    // ถ้า grid ยังไม่เต็มจอ (มีพื้นที่ดำอยู่) = lock mode
    return scaledWidth < widget.width && scaledHeight < widget.height;
  }

  Offset _clampTranslation(Offset translation, double scale) {
    if (_canvasWidth == 0 || _canvasHeight == 0) {
      return translation;
    }

    final scaledWidth = _canvasWidth * scale;
    final scaledHeight = _canvasHeight * scale;

    double minX = widget.width - scaledWidth;
    double maxX = 0.0;
    if (scaledWidth < widget.width) {
      final centeredX = (widget.width - scaledWidth) / 2.0;
      minX = centeredX;
      maxX = centeredX;
    }

    double minY = widget.height - scaledHeight;
    double maxY = 0.0;
    if (scaledHeight < widget.height) {
      final centeredY = (widget.height - scaledHeight) / 2.0;
      minY = centeredY;
      maxY = centeredY;
    }

    double clampDouble(double value, double lower, double upper) {
      if (value < lower) return lower;
      if (value > upper) return upper;
      return value;
    }

    return Offset(
      clampDouble(translation.dx, minX, maxX),
      clampDouble(translation.dy, minY, maxY),
    );
  }

  void _applyPan(Offset translation, double scale) {
    final clamped = _clampTranslation(translation, scale);

    _transformationController.removeListener(_onTransformChanged);
    _transformationController.value = Matrix4.identity()
      ..translate(clamped.dx, clamped.dy)
      ..scale(scale);
    _transformationController.addListener(_onTransformChanged);
  }

  Offset calculateLocalPosition(Offset globalPosition) {
    final RenderBox gridBox =
        gridKey.currentContext?.findRenderObject() as RenderBox;
    return gridBox.globalToLocal(globalPosition);
  }

  // Wrapper function สำหรับการกดโต๊ะ - เขียน Firestore โดยตรง
  Future<void> _handleTableTap(String tableId) async {
    if (!_canTap(tableId)) return;

    // ⏱️ เริ่มวัดเวลา
    final startTime = DateTime.now();

    // ตั้งค่า processing flag
    setState(() {
      _isProcessingAnyTable = true;
      _processingTables[tableId] = true;
      _lastTapTime[tableId] = DateTime.now().millisecondsSinceEpoch;
      _lastAnyTableTapTime = DateTime.now().millisecondsSinceEpoch;
    });

    try {
      final venueId = widget.venueId; // ✅ ใช้ venueId โดยตรง
      final dateString = _yyyyMMdd(widget.date);
      final uid = widget.currentuid;

      // ✅ Debug active reservation data (ปิดไว้ชั่วคราว)
      // _debugActiveReservationData(uid, venueId, dateString, tableId);

      _apiSentTime = DateTime.now();
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print(
          '🚀 [1] SUPABASE RPC STARTED at ${_apiSentTime!.millisecondsSinceEpoch}');
      print('   tableId: $tableId');

      // ✅ เช็คว่า user มีการจอง active อยู่แล้วหรือไม่ (ต่อวัน) - ใช้ Supabase
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('🔍 [CheckExistingReservations] START');
      print('   venueId: $venueId');
      print('   userId: $uid');
      print('   date: $dateString');
      print('   Querying: active_reservations table');

      Map<String, dynamic>? existingReservation;

      try {
        // ✅ ใช้ SupabaseHelper.query แทน Firebase
        final reservations = await SupabaseHelper.query(
          'active_reservations',
          equals: {
            'user_id': uid,
            'venue_id': venueId,
            'date': dateString,
          },
        );

        // กรอง status ที่ไม่ใช่ 'available' และเป็นของ user นี้
        // เช็คว่า user มีการจอง active อยู่แล้วหรือไม่ (pending, payment_pending, occupied)
        final filtered = reservations.where((r) {
          final status = r['status'] as String?;
          final userId = r['user_id']?.toString();
          return status != null &&
              status != 'available' &&
              userId ==
                  uid; // ✅ แก้จาก != เป็น == เพื่อหา reservation ของ user เอง
        }).toList();

        if (filtered.isNotEmpty) {
          existingReservation = filtered.first;
        }

        print('   ✅ Query successful');
        print('   Found ${filtered.length} existing reservations');
      } catch (e, stackTrace) {
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('❌ [CheckExistingReservations] ERROR!');
        print('   Error: $e');
        print('   StackTrace: $stackTrace');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        // ถ้า error ให้ข้ามการเช็คนี้และทำงานต่อ
        existingReservation = null;
      }

      if (existingReservation != null) {
        // User มีการจอง active อยู่แล้ว
        print('   ⚠️  User already has an active reservation');
        final existingStatus = existingReservation['status'] ?? 'unknown';
        final existingTableIds =
            existingReservation['table_ids'] as List? ?? [];
        final existingTableId = existingTableIds.isNotEmpty
            ? existingTableIds.first.toString()
            : 'unknown';

        // ✅ อนุญาตให้ toggle หรือเปลี่ยนโต๊ะได้ถ้า status เป็น 'pending'
        // (RPC function จะจัดการยกเลิกโต๊ะเดิมและจองโต๊ะใหม่ให้อัตโนมัติ)
        // ❌ บล็อกเฉพาะ payment_pending และ occupied เท่านั้น
        if (existingStatus == 'pending') {
          // ✅ อนุญาตให้ toggle/เปลี่ยนโต๊ะได้เมื่อ status เป็น pending
          // ไม่ว่าโต๊ะที่กดจะเป็นโต๊ะเดิม (toggle to cancel) หรือโต๊ะใหม่ (switch table)
          print('   ✅ Allowing toggle/switch for pending reservation');
          // ทำงานต่อ (ไม่ return) เพื่อให้เรียก RPC toggle
        } else if (existingStatus == 'payment_pending' ||
            existingStatus == 'occupied') {
          // ❌ บล็อก payment_pending และ occupied
          setState(() {
            _isProcessingAnyTable = false;
            _processingTables[tableId] = false;
          });

          if (mounted) {
            // สร้างข้อความแจ้งเตือนตามสถานะ
            String statusMessage;
            if (existingStatus == 'payment_pending') {
              statusMessage = 'รอยืนยันสลิป';
            } else if (existingStatus == 'occupied') {
              statusMessage = 'จองแล้ว';
            } else {
              statusMessage = existingStatus;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'คุณมีการจองโต๊ะ $existingTableId อยู่แล้ว (สถานะ: $statusMessage)',
                ),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 4),
              ),
            );
          }
          return; // หยุดการทำงาน
        }
        // ถ้า status อื่นๆ ที่ไม่ใช่ pending/payment_pending/occupied → ทำงานต่อ
      }

      // ✅ ใช้ Supabase RPC แทน Firebase Transaction
      final result = await SupabaseHelper.toggleTableReservation(
        venueId: venueId,
        date: dateString,
        tableId: tableId,
        userId: widget.currentuid,
        floorId: _activeFloorId,
      );

      // ✅ [2] เสร็จสิ้น
      _apiReceivedTime = DateTime.now();
      final writeDuration = _apiReceivedTime!.difference(_apiSentTime!);
      print(
          '📥 [2] SUPABASE RPC COMPLETED at ${_apiReceivedTime!.millisecondsSinceEpoch}');
      print('   ⏱️  RPC Time: ${writeDuration.inMilliseconds}ms');
      print('   ✅ Toggle successful');
      print('   Result: $result');

      // ✅ ดึง layout ใหม่แล้วส่งเข้า stream เพื่อให้ UI อัปเดตทันที (ไม่ต้องออกเข้าหน้า)
      _refetchAndEmitLayout();
    } catch (e, stackTrace) {
      print('❌ ===== ERROR IN _handleTableTap =====');
      print('Error: $e');
      print('Type: ${e.runtimeType}');

      print('Stack trace: $stackTrace');
      print('======================================\n');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ เกิดข้อผิดพลาด: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      final totalDuration = DateTime.now().difference(startTime);
      print('⏱️ Total Handler Time: ${totalDuration.inMilliseconds}ms');

      // Reset processing flag ทันที (ไม่มี delay)
      if (mounted) {
        setState(() {
          _isProcessingAnyTable = false;
          _processingTables[tableId] = false;
        });
      }
    }
  }

  // ฟังก์ชันคำนวณขนาดของ widget จากตำแหน่งใน Firestore
  Size _calculateSize(Map<String, dynamic> position) {
    final xi = position['xi'] ?? [0, 0];
    final yi = position['yi'] ?? [0, 0];
    if (xi is List && yi is List && xi.length == 2 && yi.length == 2) {
      double x0 = (xi[0] as num).toDouble();
      double x1 = (xi[1] as num).toDouble();
      double y0 = (yi[0] as num).toDouble();
      double y1 = (yi[1] as num).toDouble();

      double width = x1 - x0;
      double height = y1 - y0;
      return Size(width, height);
    }
    return Size(0.0, 0.0);
  }

// Helper function: แปลง DateTime เป็น YYYY-MM-DD
  String _yyyyMMdd(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  // ฟังก์ชันคำนวณขอบเขตของ Layout จากตำแหน่งของวัตถุทั้งหมด
  Rect _calculateBoundingBox(Map<String, Map<String, dynamic>> positions) {
    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    positions.forEach((key, value) {
      final xi = value['xi'] ?? [0, 0];
      final yi = value['yi'] ?? [0, 0];
      if (xi is List && yi is List && xi.length == 2 && yi.length == 2) {
        double x0 = (xi[0] as num).toDouble();
        double x1 = (xi[1] as num).toDouble(); // ← ขอบขวา
        double y0 = (yi[0] as num).toDouble();
        double y1 = (yi[1] as num).toDouble(); // ← ขอบล่าง

        /*print('🔍 Widget: $key');
        print('   X: [$x0, $x1] (width: ${x1 - x0})');
        print('   Y: [$y0, $y1] (height: ${y1 - y0})');
        */
        minX = x0 < minX ? x0 : minX;
        minY = y0 < minY ? y0 : minY;
        maxX = x1 > maxX ? x1 : maxX; // ← ใช้ x1 แทน x0
        maxY = y1 > maxY ? y1 : maxY; // ← ใช้ y1 แทน y0
      }
    });

    /*print('\n📊 Bounding Box:');
    print('   minX: $minX, maxX: $maxX (width: ${maxX - minX})');
    print('   minY: $minY, maxY: $maxY (height: ${maxY - minY})');
    */
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  // ฟังก์ชันตั้งค่า TransformationController ให้แสดง Layout ตรงกลาง
  void _setInitialTransformation(Rect boundingBox) {
    print('🎬 _setInitialTransformation called');
    print('   _initialTransformApplied: $_initialTransformApplied');
    // แทนที่บรรทัด 531-558 ด้วย:
    if (_initialTransformApplied) {
      print('⚠️ Already applied, skipping');
      return;
    }

    print('🎬 _setInitialTransformation called');

    final bboxWidth = boundingBox.width;
    final bboxHeight = boundingBox.height;
    final paddingX = bboxWidth * 0.1; // ✅ ลดจาก 0.3 เป็น 0.15
    final paddingY = bboxHeight * 0.1;
    final canvasWidth = bboxWidth + paddingX; // ✅ เปลี่ยนตรงนี้!
    final canvasHeight = bboxHeight + paddingY; // ✅ เปลี่ยนตรงนี้!

// ✅ ตั้งค่า state
    _canvasWidth = canvasWidth;
    _canvasHeight = canvasHeight;

    double scaleX = widget.width / canvasWidth;
    double scaleY = widget.height / canvasHeight;
    double fitScale = scaleX < scaleY ? scaleX : scaleY;

    _calculatedMinScale = fitScale * 0.99;
    double scale = fitScale;

    double translateX = (widget.width - canvasWidth * scale) / 2.0;
    double translateY = (widget.height - canvasHeight * scale) / 2.0;

    /*print(
        'canvas: ${canvasWidth}x${canvasHeight}, scale: $scale, translate: ($translateX, $translateY)');

    print('🔧 Setting scale to: $scale');
    print('   Called from: ${StackTrace.current.toString().split('\n')[1]}');
    */

    _transformationController.value = Matrix4.identity()
      ..translate(translateX, translateY)
      ..scale(scale);

    print(
        '✅ Scale is now: ${_transformationController.value.getMaxScaleOnAxis()}');
  }

  // ใช้ snapshot ของ venue_daily_layouts เพื่อเตรียม Transformation ครั้งแรก
  void _ensureInitialTransform(Map<String, Map<String, dynamic>> positions) {
    if (_initialTransformApplied) return;
    if (positions.isEmpty) return;
    final bbox = _calculateBoundingBox(positions);
    _setInitialTransformation(bbox);
    _initialTransformApplied = true;
    _boundingBox = bbox;
  }

  @override
  Widget build(BuildContext context) {
    // กรณียังโหลด
    if (_layoutLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 12),
            const Text('กำลังโหลด layout...', style: TextStyle(color: Colors.white70)),
          ],
        ),
      );
    }
    // กรณีไม่มีข้อมูล
    if (_layoutData == null) {
      return Center(
        child: Text('ยังไม่มี layout สำหรับวันที่ ${widget.date.toIso8601String().substring(0, 10)}'),
      );
    }

    // ข้อมูลจาก Supabase — อัปเดตแบบ setState ทุกครั้งที่มีการเปลี่ยนแปลง
    {
    final data = _layoutData!;

        // ✅ รองรับหลายชั้น: ถ้ามี floors ให้เลือก floor ตาม widget.floorId (fallback คีย์แรก)
        // ✅ รองรับ Supabase structure: floors (JSONB), other_data (JSONB), table_layout (legacy)
        Map<String, dynamic> tableLayoutMap;
        Map<String, dynamic> wallsMapRaw = const {};
        List<String> floorKeys = const [];

        // ✅ ตรวจสอบ floors ก่อน (Supabase structure)
        if (data.containsKey('floors') && data['floors'] is Map) {
          final floors = Map<String, dynamic>.from(data['floors']);
          floorKeys = floors.keys.map((e) => e.toString()).toList();
          String fid = _activeFloorId;
          if (!floors.containsKey(fid) && floors.isNotEmpty) {
            fid = floors.keys.first;
            // update active floor after build
            if (fid != _activeFloorId) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() => _activeFloorId = fid);
              });
            }
          }
          final fdata = Map<String, dynamic>.from(floors[fid] ?? {});
          tableLayoutMap =
              Map<String, dynamic>.from(fdata['table_layout'] ?? {});
          wallsMapRaw = Map<String, dynamic>.from(fdata['walls'] ?? {});
        } else if (data.containsKey('other_data') &&
            data['other_data'] is Map) {
          // ✅ รองรับ other_data (JSONB) structure
          final otherData = Map<String, dynamic>.from(data['other_data']);
          if (otherData.containsKey('floors') && otherData['floors'] is Map) {
            final floors = Map<String, dynamic>.from(otherData['floors']);
            floorKeys = floors.keys.map((e) => e.toString()).toList();
            String fid = _activeFloorId;
            if (!floors.containsKey(fid) && floors.isNotEmpty) {
              fid = floors.keys.first;
            }
            final fdata = Map<String, dynamic>.from(floors[fid] ?? {});
            tableLayoutMap =
                Map<String, dynamic>.from(fdata['table_layout'] ?? {});
            wallsMapRaw = Map<String, dynamic>.from(fdata['walls'] ?? {});
          } else {
            // legacy structure ใน other_data
            tableLayoutMap =
                Map<String, dynamic>.from(otherData['table_layout'] ?? {});
            wallsMapRaw = Map<String, dynamic>.from(otherData['walls'] ?? {});
          }
        } else {
          // ✅ legacy structure (table_layout ตรงๆ)
          tableLayoutMap =
              Map<String, dynamic>.from(data['table_layout'] ?? {});
          wallsMapRaw = Map<String, dynamic>.from(data['walls'] ?? {});
        }

        // แปลงเป็น positions สำหรับ UI
        final positions = <String, Map<String, dynamic>>{};
        tableLayoutMap.forEach((key, value) {
          if (value is Map) {
            final m = Map<String, dynamic>.from(value);
            positions[key] = m;
          }
        });

// ✅ ตรวจสอบว่า positions ไม่ว่างเปล่า
        if (positions.isEmpty) {
          return const Center(
            child: Text('ยังไม่มีโต๊ะในวันนี้'),
          );
        }

        // คำนวณ bounding box
        _ensureInitialTransform(positions);
        Rect bbox = _boundingBox ?? _calculateBoundingBox(positions);

        // Parse walls
        final rawWalls = wallsMapRaw;
        final List<List<Offset>> wallPointLists = [];
        if (rawWalls is Map) {
          rawWalls.forEach((k, v) {
            if (v is Map && v['points'] is List) {
              final pts = <Offset>[];
              for (final p in (v['points'] as List)) {
                if (p is Map && p['x'] != null && p['y'] != null) {
                  pts.add(Offset(
                      (p['x'] as num).toDouble(), (p['y'] as num).toDouble()));
                }
              }
              if (pts.length >= 2) wallPointLists.add(pts);
            }
          });
        }

        // Expand bbox with walls
        if (wallPointLists.isNotEmpty) {
          double minX = bbox.left;
          double minY = bbox.top;
          double maxX = bbox.right;
          double maxY = bbox.bottom;
          for (final wall in wallPointLists) {
            for (final pt in wall) {
              if (pt.dx < minX) minX = pt.dx;
              if (pt.dy < minY) minY = pt.dy;
              if (pt.dx > maxX) maxX = pt.dx;
              if (pt.dy > maxY) maxY = pt.dy;
            }
          }
          bbox = Rect.fromLTRB(minX, minY, maxX, maxY);
          _boundingBox = bbox;
        }

        // คำนวณ padding แบบสัดส่วนกับขนาด content
        final bboxWidth = bbox.width.isFinite ? bbox.width : 0;
        final bboxHeight = bbox.height.isFinite ? bbox.height : 0;

// เพิ่ม padding (เลือกแบบใดแบบหนึ่ง)
        final paddingX = bboxWidth * 0.1; // แบบสัดส่วน (30%)
        final paddingY = bboxHeight * 0.1;
// หรือ
// final paddingX = 100.0;  // แบบคงที่
// final paddingY = 100.0;

        final canvasWidth = bboxWidth + paddingX;
        final canvasHeight = bboxHeight + paddingY;

        final boundarySize =
            canvasWidth > canvasHeight ? canvasWidth : canvasHeight;
        final margin = boundarySize * 0.05;

        final horizontalMargin = max(0.0, (widget.width - canvasWidth) / 2);
        final verticalMargin = max(0.0, (widget.height - canvasHeight) / 2);

// ✅ ตั้ง state

        print('✅ Canvas size updated: ${canvasWidth}x${canvasHeight}');
        print('   Padding: ${paddingX}x${paddingY}');

// ✅ เพิ่มบรรทัดนี้!

        print('✅ Canvas size updated: ${canvasWidth}x${canvasHeight}');

        // Transform walls
        final transformedWalls = wallPointLists
            .map((wall) => wall
                .map((p) => Offset(p.dx - bbox.left + (paddingX / 2),
                    p.dy - bbox.top + (paddingY / 2)))
                .toList())
            .toList();

        return Container(
          width: widget.width,
          height: widget.height,
          color: Colors.black,
          child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: _calculatedMinScale, // ✅ ใช้ calculated scale
              maxScale: 10.0,
              constrained: false,
              boundaryMargin: EdgeInsets.symmetric(
                  horizontal: horizontalMargin, vertical: verticalMargin),
              panEnabled: false,
              scaleEnabled: true,
              child: GestureDetector(
                // ✅ เปลี่ยนเป็น opaque เพื่อดูดซับ tap events ที่ grid (ไม่ให้ bubble up)
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) {
                  // ✅ ป้องกันไม่ให้ tap bubble up ไปยัง parent
                  print('widget.width: ${widget.width}');
                  print('widget.height: ${widget.height}');
                  print('canvasWidth: $canvasWidth');
                  print('canvasHeight: $canvasHeight');
                  print(
                      'scale: ${_transformationController.value.getMaxScaleOnAxis()}');
                  print('minScale: ${_calculatedMinScale}');
                  print(
                      'scaleEnabled: ${_transformationController.value.getMaxScaleOnAxis()}');
                },
                onPanStart: (details) {
                  if (_shouldLockPanZoom()) {
                    _isPanningCanvas = false;
                    _panStartGlobalPosition = null;
                    return;
                  }

                  _isPanningCanvas = true;
                  _panStartGlobalPosition = details.globalPosition;

                  final translation =
                      _transformationController.value.getTranslation();
                  _panStartTranslation = Offset(translation.x, translation.y);
                  _panStartScale =
                      _transformationController.value.getMaxScaleOnAxis();
                },
                onPanUpdate: (details) {
                  if (!_isPanningCanvas || _panStartGlobalPosition == null) {
                    return;
                  }

                  final dx =
                      details.globalPosition.dx - _panStartGlobalPosition!.dx;
                  final dy =
                      details.globalPosition.dy - _panStartGlobalPosition!.dy;

                  final proposed = _panStartTranslation.translate(dx, dy);
                  _applyPan(proposed, _panStartScale);
                },
                onPanEnd: (details) {
                  _isPanningCanvas = false;
                  _panStartGlobalPosition = null;
                },
                onPanCancel: () {
                  _isPanningCanvas = false;
                  _panStartGlobalPosition = null;
                },
                child: Stack(
                  children: [
                    // Floor selector (only when floors exist)
                    if (false && floorKeys.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: PopupMenuButton<String>(
                            tooltip: 'เลือก Floor',
                            onSelected: (v) {
                              if (v != _activeFloorId) {
                                setState(() {
                                  _activeFloorId = v;
                                  _initialTransformApplied = false;
                                  _boundingBox = null;
                                });
                              }
                            },
                            itemBuilder: (ctx) => floorKeys
                                .map((k) => PopupMenuItem<String>(
                                      value: k,
                                      child: Text('Floor $k'),
                                    ))
                                .toList(),
                            child: Row(
                              children: const [
                                Icon(Icons.layers, color: Colors.black),
                                SizedBox(width: 6),
                                Text('Floor',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    // Grid (non-interactive)
                    IgnorePointer(
                      ignoring: true,
                      child: CustomPaint(
                        size: Size(canvasWidth, canvasHeight),
                        painter: GridPainter(),
                      ),
                    ),

                    // Walls
                    if (transformedWalls.isNotEmpty)
                      IgnorePointer(
                        ignoring: true,
                        child: CustomPaint(
                          size: Size(canvasWidth, canvasHeight),
                          painter: WallPainter(transformedWalls),
                        ),
                      ),

                    // Tables/Chairs
                    ...positions.entries.map((entry) {
                      final id = entry.key;
                      final map = entry.value;
                      final xi = map['xi'] ?? [0, 0];
                      final yi = map['yi'] ?? [0, 0];
                      final type = map['type'];
                      final rawStatus = map['status'];
                      final price = (map['price'] as num?)?.toDouble() ?? 0.0;

                      // Normalize status
                      Map<String, dynamic> statusMap;
                      if (rawStatus is Map) {
                        statusMap = Map<String, dynamic>.from(rawStatus);
                      } else {
                        statusMap = {
                          'status_code': 'available',
                          'customer_uid': '',
                          'status_action_timestamp': 0,
                        };
                      }

                      final name = map['table_name'] ?? id;
                      final colorField = map['color'] ?? 'grey';
                      final size = _calculateSize(map);
                      final leftPosition = (xi[0] as num).toDouble() -
                          bbox.left +
                          (paddingX / 2);
                      final topPosition =
                          (yi[0] as num).toDouble() - bbox.top + (paddingY / 2);

                      Widget widgetToDisplay;

                      switch (type) {
                        case 'table':
                          widgetToDisplay = TableWidget(
                            key: ValueKey(id),
                            id: name,
                            width: size.width,
                            height: size.height,
                            status: statusMap,
                            currentuid: widget.currentuid,
                            price: price,
                            onSelect: () {
                              _handleTableTap(id);
                            },
                            colorName: colorField,
                            isProcessing: _processingTables[id] ?? false,
                          );
                          break;

                        case 'chair':
                          widgetToDisplay = ChairWidget(
                            id: name,
                            width: size.width,
                            height: size.height,
                            status: statusMap,
                            currentuid: widget.currentuid,
                            price: price,
                            onSelect: () {
                              _handleTableTap(id);
                            },
                            isProcessing: _processingTables[id] ?? false,
                          );
                          break;

                        case 'stage':
                          widgetToDisplay = StageWidget(
                            id: name,
                            width: size.width,
                            height: size.height,
                          );
                          break;

                        case 'bar':
                          widgetToDisplay = BarWidget(
                            id: name,
                            width: size.width,
                            height: size.height,
                          );
                          break;

                        default:
                          widgetToDisplay = Container();
                      }

                      return Positioned(
                        left: leftPosition,
                        top: topPosition,
                        child: widgetToDisplay,
                      );
                    }).toList(),
                    // Floor selector (top-most)
                    if (floorKeys.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: PopupMenuButton<String>(
                            tooltip: 'เลือก Floor',
                            onSelected: (v) {
                              if (v != _activeFloorId) {
                                setState(() {
                                  _activeFloorId = v;
                                  _initialTransformApplied = false;
                                  _boundingBox = null;
                                });
                              }
                            },
                            itemBuilder: (ctx) => floorKeys
                                .map((k) => PopupMenuItem<String>(
                                      value: k,
                                      child: Text('Floor $k'),
                                    ))
                                .toList(),
                            child: Row(
                              children: const [
                                Icon(Icons.layers, color: Colors.black),
                                SizedBox(width: 6),
                                Text('Floor',
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )),
        );
    } // end data block
  }
}

// ==============================
// TableWidget (ใช้ TweenAnimationBuilder สำหรับ Animation)
// ==============================
class TableWidget extends StatefulWidget {
  final String id;
  final double width;
  final double height;
  final Map<String, dynamic>
      status; // map with status_code, status_reserve_id, status_action_timestamp
  final String currentuid;
  final VoidCallback onSelect;
  final String colorName;
  final double price;
  final bool isProcessing;

  const TableWidget({
    Key? key,
    required this.id,
    required this.width,
    required this.height,
    required this.status,
    required this.currentuid,
    required this.onSelect,
    required this.colorName,
    required this.price,
    this.isProcessing = false,
  }) : super(key: key);

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  void didUpdateWidget(covariant TableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    String oldStatus =
        (oldWidget.status['status_code'] ?? 'available').toString();
    String newStatus = (widget.status['status_code'] ?? 'available').toString();

    if (oldStatus != newStatus) {
      ;
    }
  }

  /// ฟังก์ชันแปลง colorName -> Color จริง
  Color _mapColorName(String name) {
    switch (name.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'pink':
        return Colors.pink;
      case 'grey':
        return Colors.grey;
      default:
        return Colors.grey; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    // ป้องกันไม่ให้ 0x0
    final double boxWidth = widget.width < 30 ? 30 : widget.width;
    final double boxHeight = widget.height < 30 ? 30 : widget.height;
    String displayName = widget.id;
    if (displayName.startsWith('table_')) {
      displayName = displayName.substring(6); // ตัด "table_" ออก
    }

    // สีแท็บซ้าย จาก Firestore
    final Color leftTabColor = _mapColorName(widget.colorName);

    // ตรวจสอบสถานะ
    final code = (widget.status['status_code'] ?? 'available').toString();
    final reserveId = (widget.status['customer_uid'] ?? '').toString();

    final bool isPending = code == 'pending';
    final bool isPaymentPending = code == 'payment_pending';
    final bool isOccupied = code == 'occupied';
    final bool isAvailable = code == 'available';
    final bool isOwned = reserveId == widget.currentuid;

    // กำหนดสีพื้นหลังตาม status
    Color bgColor;
    if (isPending) {
      // pending → สีฟ้าทั้งอัน
      bgColor = Colors.blue.shade700;
    } else if (isPaymentPending) {
      // payment_pending → สีฟ้าทั้งอัน
      bgColor = Colors.blue.shade700;
    } else if (isOccupied) {
      // occupied → เช็ค customer_uid
      if (isOwned) {
        bgColor = Colors.green.shade700; // ของเรา → สีเขียว
      } else {
        bgColor = Colors.grey.shade700; // ของคนอื่น → สีเทา
      }
    } else {
      // available → สีปกติ
      bgColor = Color(0xFF2D2D2D);
    }

    // ตรวจสอบว่าควรใส่ overlay หรือไม่
    final bool shouldOverlay =
        (isPending || isPaymentPending || isOccupied) && !isOwned;

    return GestureDetector(
      // กดได้เฉพาะ available หรือ pending/occupied ที่เป็นของเรา
      onTap:
          (isAvailable || (isPending && isOwned) || (isOccupied && isOwned)) &&
                  !widget.isProcessing
              ? widget.onSelect
              : null,
      child: SizedBox(
        width: boxWidth,
        height: boxHeight,
        child: Stack(
          children: [
            // กล่องหลัก - ใช้ AnimatedContainer เพื่อให้เปลี่ยนสีได้
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                children: [
                  // แถบสีซ้าย
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 5,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: leftTabColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ชื่อโต๊ะตรงกลาง
                  Center(
                    child: Text(
                      displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // เส้น 4 ด้าน (ขาโต๊ะ)
            Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: 5,
                height: boxHeight * 0.4,
                decoration: const BoxDecoration(
                  color: Color(0xFF404040),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: 5,
                height: boxHeight * 0.4,
                decoration: const BoxDecoration(
                  color: Color(0xFF404040),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -1),
              child: Container(
                width: boxWidth * 0.4,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFF404040),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 1),
              child: Container(
                width: boxWidth * 0.4,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFF404040),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),

            // ถ้า pending หรือ unavailable ของคนอื่น => ใส่ overlay ทับ 75%
            if (shouldOverlay && !isOwned)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

            // ขอบสีขาว ถ้าเป็นของผู้ใช้ปัจจุบัน
            if (isOwned)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

            // แสดง loading indicator เมื่อกำลัง process
            if (widget.isProcessing)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==============================
// ChairWidget
// ==============================
class ChairWidget extends StatelessWidget {
  final String id;
  final double width;
  final double height;
  final Map<String, dynamic> status; // map form
  final String currentuid;
  final VoidCallback onSelect;
  final double price;
  final bool isProcessing;

  ChairWidget({
    required this.id,
    required this.width,
    required this.height,
    required this.status,
    required this.currentuid,
    required this.onSelect,
    required this.price,
    this.isProcessing = false,
  });

  String get code => (status['status_code'] ?? 'available').toString();
  String get reserveId => (status['customer_uid'] ?? '').toString();
  bool get isPending => code == 'pending';
  bool get isPaymentPending => code == 'payment_pending';
  bool get isOccupied => code == 'occupied';
  bool get isAvailable => code == 'available';
  bool get isOwned => reserveId == currentuid;

  @override
  Widget build(BuildContext context) {
    // ป้องกันไม่ให้ 0x0
    final double boxWidth = width < 30 ? 30 : width;
    final double boxHeight = height < 30 ? 30 : height;
    String displayName = id;
    if (displayName.startsWith('chair_')) {
      displayName = displayName.substring(6); // ตัด "chair_" ออก
    }

    // สีพื้นหลังหลักของเก้าอี้
    Color bgColor;
    if (isPending) {
      // pending → สีฟ้าทั้งอัน
      bgColor = Colors.blue.shade700;
    } else if (isPaymentPending) {
      // payment_pending → สีฟ้าทั้งอัน
      bgColor = Colors.blue.shade700;
    } else if (isOccupied) {
      // occupied → เช็ค customer_uid
      if (isOwned) {
        bgColor = Colors.green.shade700; // ของเรา → สีเขียว
      } else {
        bgColor = Colors.grey.shade700; // ของคนอื่น → สีเทา
      }
    } else {
      // available → สีฟ้าอ่อน (default chair color)
      bgColor = Colors.blue;
    }

    // ตรวจสอบว่าควรใส่ overlay หรือไม่
    final bool shouldOverlay =
        (isPending || isPaymentPending || isOccupied) && !isOwned;

    return GestureDetector(
      // กดได้เฉพาะ available หรือ pending/occupied ที่เป็นของเรา
      onTap:
          (isAvailable || (isPending && isOwned) || (isOccupied && isOwned)) &&
                  !isProcessing
              ? onSelect
              : null,
      child: SizedBox(
        width: boxWidth,
        height: boxHeight,
        child: Stack(
          children: [
            // กล่องหลัก
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.0),
                border: isOwned
                    ? Border.all(color: Colors.white, width: 2.0)
                    : null,
              ),
              child: Center(
                child: Text(
                  displayName,
                  style: TextStyle(
                    color:
                        isAvailable || isOwned ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ถ้า pending หรือ unavailable => ใส่ overlay ทับ 75%
            if (shouldOverlay && !isOwned)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),

            // แสดง loading indicator เมื่อกำลัง process
            if (isProcessing)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==============================
// StageWidget
// ==============================
class StageWidget extends StatelessWidget {
  final String id;
  final double width;
  final double height;

  StageWidget({required this.id, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Text(
          id,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ==============================
// BarWidget
// ==============================
class BarWidget extends StatelessWidget {
  final String id;
  final double width;
  final double height;

  BarWidget({required this.id, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Text(
          id,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ==============================
// GridPainter วาดเส้นตาราง
// ==============================
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke;

    for (double i = 0.0; i < size.width; i += 10.0) {
      canvas.drawLine(Offset(i, 0.0), Offset(i, size.height), paint);
    }
    for (double i = 0.0; i < size.height; i += 10.0) {
      canvas.drawLine(Offset(0.0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Painter สำหรับแสดงกำแพงใน preview (อ่านอย่างเดียว)
class WallPainter extends CustomPainter {
  final List<List<Offset>> walls;
  WallPainter(this.walls);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    for (final wall in walls) {
      if (wall.length < 2) continue;
      final path = Path()..moveTo(wall.first.dx, wall.first.dy);
      for (int i = 1; i < wall.length; i++) {
        path.lineTo(wall[i].dx, wall[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant WallPainter oldDelegate) =>
      !listEquals(oldDelegate.walls, walls);
}
