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

// ใช้ CardSwiper เวอร์ชันที่ FlutterFlow ติดตั้ง (ซึ่งมักไม่มี param direction ใน swipe())
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Swipecard extends StatefulWidget {
  const Swipecard({
    super.key,
    this.width,
    this.height,
    this.dataid,
  });

  /// ความกว้างของ Widget
  final double? width;

  /// ความสูงของ Widget
  final double? height;

  /// รายการ SupabaseDocRef (จาก collection 'users') ที่อยากนำมาแสดง
  final List<SupabaseDocRef>? dataid;

  @override
  State<Swipecard> createState() => _SwipecardState();
}

class _SwipecardState extends State<Swipecard> {
  /// Controller ของ CardSwiper
  final CardSwiperController _controller = CardSwiperController();

  /// เก็บผลลัพธ์หลังจาก Fetch Users มาแล้ว (List<UsersRecord>)
  late Future<List<UsersRecord>> _usersFuture;

  /// ตัวอย่าง field เก็บค่าจาก Transaction
  int? _counterValue;

  @override
  void initState() {
    super.initState();
    // เรียกฟังก์ชันดึงข้อมูลครั้งเดียวตอน initState
    _usersFuture = _fetchUsersOnce();
  }

  /// ฟังก์ชันดึงข้อมูล UserRecord ทีละ SupabaseDocRef (Reference ในที่นี้คือ ID String หรือ SupabaseDocRef shim)
  /// แล้วสร้างเป็น List<UsersRecord> ครั้งเดียว ไม่ใช้ Stream
  Future<List<UsersRecord>> _fetchUsersOnce() async {
    final results = <UsersRecord>[];

    // หาก widget.dataid == null หรือว่าง ก็รีเทิร์นลิสต์เปล่า
    if (widget.dataid == null || widget.dataid!.isEmpty) {
      return results;
    }

    // อ่านแต่ละ SupabaseDocRef ทีละตัว
    for (final ref in widget.dataid!) {
      // ref เป็น SupabaseDocRef (from shim) มี method get() ที่ return SupabaseDocSnapshot (shim)
      final snap = await ref.get();
      if (snap.exists) {
        // ใช้ fromSnapshot ของ UsersRecord (เป็นฟังก์ชันที่ FlutterFlow สร้างให้อัตโนมัติ)
        final userRecord = UsersRecord.fromSnapshot(snap);
        results.add(userRecord);
      }
    }
    return results;
  }

  /// ฟังก์ชันตัวอย่าง Transaction (Increment ฟิลด์ counter)
  Future<void> _runMyTransaction(String documentId) async {
    // Supabase implementation: uses simple update or RPC.
    // To be atomic, use an RPC 'increment_counter'. Here we do simple read-write.
    try {
      final docRef = UsersRecord.collection.doc(documentId);
      final snap = await docRef.get();
      if (!snap.exists) return;

      final data = snap.data as Map<String, dynamic>;
      final currentCounter = data['counter'] as int? ?? 0;
      final newCounter = currentCounter + 1;

      await docRef.update({'counter': newCounter});

      _counterValue = newCounter;

      setState(() {});
      print('Update success! New counter = $_counterValue');
    } catch (e) {
      print('Update failed: $e');
    }
  }

  /// ตรวจจับค่าใน FFAppState() (Next, Match, Back)
  /// แล้วสั่ง swipe() / undo()
  @override
  void didUpdateWidget(covariant Swipecard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ถ้า Next == true => ปัดออก (ไม่กำหนดทิศได้)
    if (FFAppState().Next == true) {
      FFAppState().PreNext = true;
      _controller.swipe();
    }

    // ถ้า Match == true => ปัดออก
    if (FFAppState().Match == true) {
      FFAppState().PreMatch = true;
      _controller.swipe();
    }

    // ถ้า Back == true => Undo
    if (FFAppState().Back == true) {
      _controller.undo();
    }
  }

  /// callback เมื่อการ์ดถูกปัด (Gesture หรือสั่ง _controller.swipe())
  bool _onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    print('Swiped from $previousIndex to ${direction.name}');

    // ถ้าทิศ == ซ้าย => ถือว่า Next
    if (direction == CardSwiperDirection.left) {
      FFAppState().Next = false;
      FFAppState().PreNext = false;
      if (currentIndex != null &&
          currentIndex >= 0 &&
          currentIndex < (widget.dataid?.length ?? 0)) {
        FFAppState().Idcurrent = widget.dataid![currentIndex];
      }
    }
    // ถ้าทิศ == ขวา => ถือว่า Match
    else if (direction == CardSwiperDirection.right) {
      FFAppState().Match = false;
      FFAppState().PreMatch = false;
      if (currentIndex != null &&
          currentIndex >= 0 &&
          currentIndex < (widget.dataid?.length ?? 0)) {
        FFAppState().Idcurrent = widget.dataid![currentIndex];
      }
    }

    return true; // ยืนยันเอาการ์ดออก
  }

  /// callback เมื่อ undo เสร็จ
  bool _onUndo(
      int? previousIndex, int currentIndex, CardSwiperDirection direction) {
    print('Undo from $currentIndex to $previousIndex');
    FFAppState().Back = false;
    if (previousIndex != null &&
        previousIndex >= 0 &&
        previousIndex < (widget.dataid?.length ?? 0)) {
      FFAppState().Idcurrent = widget.dataid![previousIndex];
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? 400.0,
      // พื้นหลังโปร่งใส
      color: Colors.transparent,

      child: FutureBuilder<List<UsersRecord>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // ระหว่างกำลังโหลดข้อมูลครั้งแรก => อาจโชว์ loading
            return const Center(child: CircularProgressIndicator());
          }
          final usersList = snapshot.data!;
          if (usersList.isEmpty) {
            return const Center(child: Text('No users to show'));
          }

          // ถ้ามีข้อมูลแล้ว สร้าง CardSwiper โดยใช้ List<UsersRecord> ใน memory
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ตัวอย่างปุ่ม Transaction
              ElevatedButton(
                onPressed: () async {
                  final docId = usersList.first.reference.id;
                  await _runMyTransaction(docId);
                },
                child: Text('Run Transaction (counter: ${_counterValue ?? 0})'),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: CardSwiper(
                  controller: _controller,
                  // จำนวนการ์ด = ขนาด usersList
                  cardsCount: usersList.length,
                  onSwipe: _onSwipe,
                  onUndo: _onUndo,
                  numberOfCardsDisplayed: 5,
                  scale: 0.86,
                  backCardOffset: const Offset(15, 15),
                  padding: const EdgeInsets.all(16.0),
                  cardBuilder: (context, index, horizontalThresholdPercentage,
                      verticalThresholdPercentage) {
                    final userRecord = usersList[index];

                    // ในที่นี้ userRecord คือข้อมูล users ที่โหลดมาแล้ว (ไม่ต้อง stream)
                    final imageUrl = userRecord.photoUrl ??
                        'https://via.placeholder.com/300?text=No+Photo';

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
