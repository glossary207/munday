import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;

import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/supabase_auth/auth_util.dart';
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;
import "package:f_f_story_view_live_zhm3f3/backend/schema/enums/enums.dart"
    as f_f_story_view_live_zhm3f3_enums;

bool? checkRoomGetReference(
  RoomRecord? dataroom,
  SupabaseDocRef? sendID,
  SupabaseDocRef? receiveID,
) {
  if (dataroom == null || sendID == null || receiveID == null) {
    return false;
  }

  bool condition1 =
      (dataroom.usersend == sendID && dataroom.userrecive == receiveID);
  bool condition2 =
      (dataroom.usersend == receiveID && dataroom.userrecive == sendID);

  return condition1 || condition2;
}

double? posterscaleCopy(double? scalewile) {
  return scalewile != null ? (scalewile * 0.446 * 1.4141592) + 20 : null;
}

bool? showsearch(
  String? textSearchFor,
  String? textSearchIn,
) {
  // Convert both search strings to lowercase before checking
  return textSearchIn
          ?.toLowerCase()
          .contains(textSearchFor?.toLowerCase() ?? '') ??
      false;
}

bool returnDistanceBetweenTwoPoints2(
  LatLng? positionOne,
  LatLng? positionTwo,
  double? distance,
) {
  // ถ้าตัวใดเป็น null ให้ return false ทันที
  if (positionOne == null || positionTwo == null || distance == null) {
    print('One of the parameters is null, returning false.');
    return false;
  }

  // ใช้สูตร Haversine เพื่อคำนวณระยะทางระหว่างสองพิกัด
  var p = 0.017453292519943295;
  var a = 0.5 -
      math.cos((positionTwo.latitude - positionOne.latitude) * p) / 2 +
      math.cos(positionOne.latitude * p) *
          math.cos(positionTwo.latitude * p) *
          (1 - math.cos((positionTwo.longitude - positionOne.longitude) * p)) /
          2;

  // ผลลัพธ์ค่า result จะได้เป็นหน่วยกิโลเมตร
  double result = 12742 * math.asin(math.sqrt(a));

  // ปัดเศษค่า result ให้ทศนิยม 1 ตำแหน่ง
  double finalResultKm = double.parse(result.toStringAsFixed(1));

  // แปลงหน่วยจากกิโลเมตรเป็นเมตร (1 km = 1000 m)
  double finalResultMeters = finalResultKm * 1000;

  // แสดงข้อมูลการทดสอบ
  print('PositionOne: $positionOne');
  print('PositionTwo: $positionTwo');
  print('Distance in meters: $finalResultMeters');
  print('Compare to given distance: $distance');

  // เปรียบเทียบระยะทางจริงกับระยะทางที่ต้องการ (distance)
  bool isWithinDistance = finalResultMeters <= distance;
  print('Return: $isWithinDistance');

  return isWithinDistance;
}

double? screen(double? hig) {
  return hig == null ? null : hig - 180;
}

int? positionItemInSet(
  List<String>? sett,
  String? item,
) {
  if (sett == null || item == null) {
    return null; // Return null if the set or item is null
  }
  return sett
      .indexOf(item); // Find and return the position of the item in the set
}

bool? checklist(
  List<String>? listt,
  String? variable,
) {
  if (listt == null || variable == null) {
    return null; // Return null if either the list or the variable is null
  }
  return listt.contains(variable); // Check if the list contains the variable
}

List<SupabaseDocRef>? checklistAdd(
  List<SupabaseDocRef>? listA,
  List<SupabaseDocRef>? listB,
) {
  if (listA == null || listB == null) {
    return null; // Return null if either of the lists is null
  }
  var setA = listA.toSet();
  var setB = listB.toSet();
  var intersection = setA.intersection(setB);
  return intersection
      .toList(); // Convert the intersection set back to a list and return
}

List<SupabaseDocRef>? add2de1(
  List<SupabaseDocRef>? add1,
  List<SupabaseDocRef>? add2,
  List<SupabaseDocRef>? de1,
) {
  // รวมรายการ add1 และ add2 โดยไม่รวมรายการใดๆ ที่ตรงกับ de1
  List<SupabaseDocRef> newList = [];

  // ตรวจสอบและเพิ่ม add1 หากไม่เท่ากับ null และไม่ตรงกับ de1
  if (add1 != null) {
    newList.addAll(add1.where((item) => de1 == null || !de1.contains(item)));
  }

  // ตรวจสอบและเพิ่ม add2 หากไม่เท่ากับ null และไม่ตรงกับ de1
  if (add2 != null) {
    newList.addAll(add2.where((item) => de1 == null || !de1.contains(item)));
  }

  // คืนค่าลิสต์หากมีสมาชิก, หากไม่มีสมาชิกใดๆ คืนค่า null
  return newList.isNotEmpty ? newList : null;
}

double? postershow(
  double? screenx,
  double? screeny,
  double? screenxshow,
) {
  if (screenx != null && screeny != null && screenxshow != null) {
    return (((screenxshow - 20) * screeny) / screenx) + 40;
  }
  return null;
}

String? urldeleteDQ(String? urlfromAPI) {
  if (urlfromAPI == null) return null; // ตรวจสอบว่าค่าที่รับมาไม่เป็น null
  return urlfromAPI.replaceAll('"', ''); // ลบเครื่องหมาย " ออกจากข้อความ
}

List<SupabaseDocRef>? nonIntersectList(
  List<SupabaseDocRef>? listA,
  List<SupabaseDocRef>? listB,
) {
  // Check if either list is null, return the other list as is.
  if (listA == null || listA.isEmpty) return listB;
  if (listB == null || listB.isEmpty) return listA;

  // Create a new list to store the non-intersecting items.
  List<SupabaseDocRef> result = [];

  // Add items from listA that are not present in listB.
  for (var itemA in listA) {
    if (!listB.contains(itemA)) {
      result.add(itemA);
    }
  }

  // Add items from listB that are not present in listA.
  for (var itemB in listB) {
    if (!listA.contains(itemB)) {
      result.add(itemB);
    }
  }

  return result;
}

List<SupabaseDocRef>? removelistinlist(
  List<SupabaseDocRef>? normallist,
  List<SupabaseDocRef>? cheerslist,
) {
  if (normallist == null || cheerslist == null) return normallist;

  List<SupabaseDocRef> filteredList = [];
  for (var docRef in normallist) {
    if (!cheerslist.contains(docRef)) {
      filteredList.add(docRef);
    }
  }
  return filteredList;
}

int? add1(int? num) {
  if (num == null) {
    return null;
  }
  return num + 1;
}

List<int>? add1onlistselect(
  List<int>? list1,
  int? order,
) {
  // ตรวจสอบว่า list1 ไม่เป็น null และ order ไม่เป็น null และอยู่ในช่วงของ index ที่ถูกต้อง
  if (list1 != null && order != null && order >= 0 && order < list1.length) {
    list1[order] += 1; // เพิ่มค่าที่ตำแหน่ง order ใน list1 ด้วย 1
  }
  return list1; // คืนค่า list ที่อัปเดตแล้ว
}

List<int>? addToSetInt(
  List<int>? setdata,
  int? value,
) {
  // หาก setdata เป็น null, สร้าง list ใหม่
  setdata ??= [];

  // ตรวจสอบว่า value ไม่เป็น null ก่อนเพิ่มเข้าไปใน list
  if (value != null) {
    setdata.add(value); // เพิ่ม value เข้าไปใน list
  }

  return setdata; // คืนค่า list ที่อัปเดตแล้ว
}

List<int>? returnEmptyArraryIn() {
  return <int>[];
}

List<String>? returnEmptyArrarySt() {
  return <String>[];
}

List<SupabaseDocRef>? userintersec(
  List<SupabaseDocRef>? set1,
  List<SupabaseDocRef>? set2,
) {
  if (set1 == null || set2 == null) {
    return null;
  }
  var resultSet = <SupabaseDocRef>{};
  resultSet.addAll(set1);
  resultSet.addAll(set2);
  return resultSet.toList();
}

int? aminusB(
  int? a,
  int? b,
) {
  if (a != null && b != null) {
    return a - b;
  } else {
    return null;
  }
}

String? addsocial(
  String? social,
  String? id,
) {
  return '$social$id';
}

String getFileNameFromFirebaseStorageLink(String url) {
  RegExp regex = RegExp(r'[^/]+(?=\?)');
  var match = regex.stringMatch(Uri.decodeFull(url));
  if (match != null) return match;
  try {
    return Uri.parse(url).pathSegments.last;
  } catch (e) {
    return url;
  }
}

List<String> replaceImage(
  List<String> images,
  String newImage,
  int index,
) {
  List<String> newImages = List.from(images);
  newImages[index] = newImage;
  return newImages;
}

int? minus1(int? data) {
  return data! - 1;
}

List<String>? flipararyPhoto(List<String>? dataphoto) {
  if (dataphoto == null || dataphoto.isEmpty) return null;
  List<String> nonEmptyList =
      dataphoto.where((element) => element.isNotEmpty).toList();
  return nonEmptyList.reversed.toList();
}

List<UsersRecord>? datasumuser(
  List<UsersRecord>? data,
  List<SupabaseDocRef>? uidreferenc,
) {
  if (data == null || uidreferenc == null) return null;
  return data
      .where((user) => uidreferenc.any((ref) => ref == user.reference))
      .toList();
}

List<String>? add6ListPhoto(
  UserphotoshowStruct? listphoto,
  String? photoshow,
) {
  // 1. สร้างลิสต์ใหม่สำหรับเก็บผลลัพธ์
  final result = <String>[];

  // 2. ตรวจสอบ photoshow และเพิ่มเป็นตัวแรก
  if (photoshow != null && photoshow.isNotEmpty) {
    result.add(photoshow);
  } else {
    result.add(''); // กรณี photoshow เป็น null หรือว่าง
  }

  // 3. ดึงค่าจากฟิลด์ photo1, photo2, photo3, photo4, photo5, photo6
  final photoUrls = [
    listphoto?.photo1,
    listphoto?.photo2,
    listphoto?.photo3,
    listphoto?.photo4,
    listphoto?.photo5, // แก้จาก photos เป็น photo5
    listphoto?.photo6,
  ]
      .where((url) =>
          url != null &&
          url.isNotEmpty) // ตรวจสอบว่า url ไม่เป็น null และไม่ว่าง
      .cast<String>() // แปลงเป็น List<String>
      .toList();

  // 4. กรอง URL ที่ไม่ซ้ำกับ photoshow
  final filteredUrls = photoUrls.where((url) => url != photoshow).toList();

  // 5. เพิ่มข้อมูลสูงสุด 5 รายการ (รวมทั้งหมดไม่เกิน 6)
  final remainingSlots = math.min(5, filteredUrls.length);
  result.addAll(filteredUrls.take(remainingSlots));

  // 6. เติมสตริงว่างให้ครบ 6 รายการ
  while (result.length < 6) {
    result.add('');
  }

  return result;
}

int? multiply(
  int? a,
  int? b,
) {
  return a! * b!;
}

SupabaseDocRef? userChatRight(
  SupabaseDocRef? data1,
  SupabaseDocRef? data2,
  SupabaseDocRef? datadelete,
) {
  if (data1 != datadelete && data2 != datadelete) {
    // Both data1 and data2 do not match with datadelete
    return null; // or throw an exception, depending on your requirements
  } else if (data1 != datadelete) {
    return data1;
  } else {
    return data2;
  }
}

String? nameright(
  String? name1,
  String? name2,
  String? namedelete,
) {
  if (name1 != namedelete && name2 != namedelete) {
    // Both name1 and name2 do not match with namedelete
    return null; // or throw an exception, depending on your requirements
  } else if (name1 != namedelete) {
    return name1;
  } else {
    return name2;
  }
}

List<SupabaseDocRef>? allUserInPageRoom(
  List<SupabaseDocRef>? dataA,
  List<SupabaseDocRef>? dataB,
  SupabaseDocRef? deleteC,
) {
  if (dataA == null || dataB == null) return null;

  List<SupabaseDocRef> result = [];

  for (int i = 0; i < dataA.length; i++) {
    if (dataA[i] == deleteC) {
      result.add(dataB![i]);
    } else {
      result.add(dataA[i]);
    }
  }

  return result;
}

List<UsersRecord>? divert(
  List<UsersRecord>? dataA,
  List<SupabaseDocRef>? dataB,
  List<SupabaseDocRef>? dataC,
  List<SupabaseDocRef>? dataD,
) {
  if (dataA == null || dataB == null) return null;

  // Filter dataA to only include records that match dataB
  List<UsersRecord> filteredDataA = dataA.where((user) {
    return dataB.any((ref) => ref.id == user.reference.id);
  }).toList();

  // Remove dataC and dataD from the filtered list
  if (dataC != null) {
    filteredDataA.removeWhere((user) {
      return dataC.any((ref) => ref.id == user.reference.id);
    });
  }
  if (dataD != null) {
    filteredDataA.removeWhere((user) {
      return dataD.any((ref) => ref.id == user.reference.id);
    });
  }

  return filteredDataA;
}

List<UsersRecord>? divert2(
  List<UsersRecord>? dataA,
  List<SupabaseDocRef>? dataB,
) {
  if (dataA == null || dataB == null) return null;

  // Filter dataA to only include records that match dataB
  List<UsersRecord> filteredDataA = dataA.where((user) {
    return dataB.any((ref) => ref.id == user.reference.id);
  }).toList();

  return filteredDataA;
}

List<dynamic>? flipdoc(List<dynamic>? data1) {
  return data1?.reversed.toList();
}

List<dynamic>? jsonDataRoomAndStore(
  SupabaseDocRef? mainuser,
  List<RoomRecord>? roomdata,
  StoreRecord? storedata,
) {
  return roomdata?.map((room) {
    var userRef, photoProfile, name, online;
    if (room.usersend == mainuser) {
      userRef = room.userrecive;
      photoProfile = room.photorecive;
      name = room.namerecive;
    } else {
      userRef = room.usersend;
      photoProfile = room.photosend;
      name = room.namesend;
    }

    // Update photoprofile, name, and online from storedata if userinstore and user_ref match
    storedata?.user?.forEach((user) {
      if (user.userinstore == userRef) {
        photoProfile = user.photoprofile;
        name = user.name;
        online = user.online;
      }
    });

    return {
      'room_ref': room.reference,
      'user_ref': userRef,
      'photoprofile': photoProfile,
      'timeupdate': room.timeupdate,
      'lastmassage': room.lastmassage,
      'online': online ?? false, // Updated from storedata
      'name': name,
      'startchat': room.startchat,
      'LastpersonUpdate': room.lastpersonUpdate,
    };
  }).toList();
}

List<dynamic>? block(
  List<dynamic>? data1,
  List<SupabaseDocRef>? datablock1,
  List<SupabaseDocRef>? datablock2,
) {
  // สร้าง set ของ userinstore ที่ต้องการ block
  var blockSet = {...?datablock1, ...?datablock2};

  // กรอง data1 โดยเอาเฉพาะ elements ที่ userinstore ไม่อยู่ใน blockSet
  var result = data1
      ?.where((element) => !blockSet.contains(element['userinstore']))
      .toList();

  return result;
}

String? deleteroom(
  String? collectionName,
  String? documentId,
) {
  final firestore = SupabaseFirestore.instance;

  // ลบเอกสารในคอลเล็กชัน
  firestore.collection(collectionName!).doc(documentId).delete();

  return "444";
}

List<dynamic>? showUserCheersMe(
  List<SupabaseDocRef>? usercheersme,
  List<dynamic>? data,
) {
  // สร้าง set ของ usercheersme ที่ต้องการแสดง
  var cheersSet = Set.from(usercheersme ?? []);

  // กรอง data โดยเอาเฉพาะ elements ที่ userinstore อยู่ใน cheersSet
  var result = data
      ?.where((element) => cheersSet.contains(element['userinstore']))
      .toList();

  return result;
}

int? numup(int? num) {
  if (num != null) {
    return ((num / 4).ceil());
  }
  return null;
}

List<SupabaseDocRef>? onlinestatus(StoreRecord? store) {
  List<SupabaseDocRef> onlineUsers = [];
  if (store != null && store.user != null) {
    onlineUsers = store.user!
        .map((user) {
          if (user.online == true) {
            return user.userinstore;
          }
          return null;
        })
        .where((item) => item != null)
        .toList()
        .cast<SupabaseDocRef>();
  }
  return onlineUsers;
}

dynamic returndatafromstore(
  StoreRecord? storedata,
  SupabaseDocRef? id,
) {
  if (storedata != null && id != null) {
    for (var user in storedata.user) {
      if (user.userinstore == id) {
        return jsonEncode({
          'userinstore': user.userinstore?.path,
          'view': user.view,
          'photoprofile': user.photoprofile,
          'online': user.online,
          'name': user.name,
          'caption': user.caption,
        });
      }
    }
  }
  return null;
}

double? axb(
  double? a,
  double? b,
) {
  if (a == null || b == null) {
    return null;
  }
  return a * b;
}

bool? checkphotoshow(
  String? photo1,
  String? photo2,
  String? photo3,
  String? photo4,
  String? photo5,
  String? photo6,
) {
  int count = 0;

  // Check each photo if it's not null or empty
  if (photo1 != null && photo1.isNotEmpty) count++;
  if (photo2 != null && photo2.isNotEmpty) count++;
  if (photo3 != null && photo3.isNotEmpty) count++;
  if (photo4 != null && photo4.isNotEmpty) count++;
  if (photo5 != null && photo5.isNotEmpty) count++;
  if (photo6 != null && photo6.isNotEmpty) count++;

  return count >= 2;
}

List<dynamic>? dataEvent(
  double? maxDistance,
  List<EventsRecord>? events,
  LatLng? userLocation,
  List<String>? musicstyle,
  List<SupabaseDocRef>? loveEvents,
  List<String>? styleVenues,
  int? page,
  bool? searchMap,
  bool? searchDate,
  DateTime? dateselect,
  bool? alldata,
  bool? loveEventonly,
) {
  // กรณีข้อมูลไม่ครบ หรือจำเป็นต้องใช้งานแล้วไม่มี ให้ return null
  if (maxDistance == null || userLocation == null || events == null) {
    return null;
  }

  // ฟังก์ชันคำนวณระยะทางระหว่างจุดสองจุด (โดยประมาน)
  double calculateDistance(LatLng start, LatLng end) {
    const double degreeToKm = 111.32; // 1 องศาละติจูด ~ 111.32 กม.
    final dLat = (end.latitude - start.latitude) * degreeToKm;
    final dLon = (end.longitude - start.longitude) *
        degreeToKm *
        math.cos(start.latitude * math.pi / 180);
    final distance = math.sqrt(dLat * dLat + dLon * dLon);
    return double.parse(distance.toStringAsFixed(2));
  }

  // ฟังก์ชันกรองอีเวนต์ตามเงื่อนไขที่ต้องการ
  List<Map<String, dynamic>> filterEvents(List<EventsRecord> sourceEvents) {
    return sourceEvents.where((event) {
      // ตรวจสอบ location ของอีเวนต์
      if (event.location == null) return false;
      LatLng eventLocation =
          LatLng(event.location!.latitude, event.location!.longitude);

      // คำนวณระยะทาง
      double distance = calculateDistance(userLocation, eventLocation);

      // ตรวจสอบ music style
      bool matchesMusicStyle = musicstyle == null ||
          musicstyle.isEmpty ||
          musicstyle.contains(event.musicstyle);

      // ตรวจสอบ styleVenues
      bool matchesStyleVenues = styleVenues == null ||
          styleVenues.isEmpty ||
          styleVenues
              .every((style) => event.styleVenues?.contains(style) ?? false);

      // ตรวจสอบวันที่ หากมีการค้นหาตามวันที่
      bool matchesDate = true;
      if (searchDate == true && dateselect != null && event.date != null) {
        DateTime eventDate =
            DateTime(event.date!.year, event.date!.month, event.date!.day);
        DateTime selectedDate =
            DateTime(dateselect.year, dateselect.month, dateselect.day);
        matchesDate = eventDate == selectedDate;
      }

      // ส่งคืนเฉพาะอีเวนต์ที่เข้าเงื่อนไข
      return distance <= maxDistance &&
          matchesMusicStyle &&
          matchesStyleVenues &&
          matchesDate;
    }).map((event) {
      // สร้างข้อมูลอีเวนต์เป็น Map เพื่อนำไปใช้ง่าย ๆ
      LatLng eventLocation =
          LatLng(event.location!.latitude, event.location!.longitude);
      double distance = calculateDistance(userLocation, eventLocation);

      return {
        'Name_artise': event.nameArtise,
        'Name_store': event.nameStore,
        'Poster': event.poster,
        'capacity': event.capacity,
        'distance': distance,
        'max_capacity': event.maxCapacity,
        'musicstyle': event.musicstyle,
        'Date': event.date,
        'doc_ref': event.reference,
        'position': event.location!,
        'iDVenuse': event.iDVenues,
        'FREE': event.free,
        'PriceDetail': event.priceDetail,
      };
    }).toList();
  }

  // เริ่มต้นด้วยการกรองอีเวนต์ตามเงื่อนไขทั่วไป
  List<Map<String, dynamic>> filteredEvents = filterEvents(events);

  // ขั้นตอนการเรียงลำดับ (Date -> Distance)
  int compareEvents(Map<String, dynamic> a, Map<String, dynamic> b) {
    DateTime dateA = a['Date'];
    DateTime dateB = b['Date'];
    int dateComparison = dateA.compareTo(dateB);
    if (dateComparison != 0) {
      return dateComparison;
    }
    return a['distance'].compareTo(b['distance']);
  }

  // เรียงอีเวนต์ตาม Date ก่อน แล้วตาม Distance
  filteredEvents.sort(compareEvents);

  // หาก loveEventonly == true ให้เหลือเฉพาะอีเวนต์ใน loveEvents
  if (loveEventonly == true && loveEvents != null) {
    filteredEvents = filteredEvents
        .where((event) => loveEvents.contains(event['doc_ref']))
        .toList();
  }

  // ตรวจสอบหากต้องการข้อมูลทั้งหมด (alldata)
  if (alldata == true) {
    return filteredEvents;
  }

  // ตรวจสอบหากเป็นการ search ใน Map (searchMap)
  if (searchMap == true) {
    return filteredEvents;
  }

  // มิฉะนั้น ให้ทำการแบ่งหน้า (pagination) ตาม itemsPerPage
  int itemsPerPage = 20;
  int pageNumber = page ?? 1;
  int startIndex = (pageNumber - 1) * itemsPerPage;
  int endIndex = startIndex + itemsPerPage;

  if (startIndex >= filteredEvents.length) {
    return [];
  }

  if (endIndex > filteredEvents.length) {
    endIndex = filteredEvents.length;
  }

  // ดึงอีเวนต์ตามหน้าที่ต้องการ
  List<Map<String, dynamic>> paginatedEvents =
      filteredEvents.sublist(startIndex, endIndex);

  // หากมีอีเวนต์ในหน้านี้เพียง 1 รายการ ให้เพิ่ม dummy event (Name_store = '007')
  if (paginatedEvents.length == 1) {
    var singleEvent = Map<String, dynamic>.from(paginatedEvents.first);
    singleEvent['Name_store'] = '007';
    paginatedEvents.add(singleEvent);
  }

  return paginatedEvents;
}

int? dateEventday(DateTime? time) {
  if (time == null) {
    return null;
  }

  return time.day;
}

String? dateMonthTH(DateTime? time) {
  if (time == null) {
    return null;
  }

  var thaiMonths = {
    1: 'ม.ค.',
    2: 'ก.พ.',
    3: 'มี.ค.',
    4: 'เม.ย.',
    5: 'พ.ค.',
    6: 'มิ.ย.',
    7: 'ก.ค.',
    8: 'ส.ค.',
    9: 'ก.ย.',
    10: 'ต.ค.',
    11: 'พ.ย.',
    12: 'ธ.ค.'
  };

  return thaiMonths[time.month];
}

List<dynamic>? dataVenuse(
  List<VenuesRecord>? data,
  double? maxDistance,
  List<SupabaseDocRef>? loveVenuse,
  LatLng? userLocation,
  List<String>? styleMusicfilter,
  List<String>? styleVenusefilter,
  int? page,
  bool? searchMap,
  bool? loveVenuseOnly,
) {
  // ถ้าข้อมูลจำเป็นไม่ครบ ให้ return null
  if (data == null || maxDistance == null || userLocation == null) {
    return null;
  }

  // ฟังก์ชันคำนวณระยะทางแบบคร่าว ๆ ระหว่าง 2 พิกัด (Euclidean + ปรับตามละติจูด)
  double calculateDistance(LatLng start, LatLng end) {
    const double degreeToKm = 111.32; // 1 องศาของ latitude ~ 111.32 กม.

    final dLat = (end.latitude - start.latitude) * degreeToKm;
    final dLon = (end.longitude - start.longitude) *
        degreeToKm *
        math.cos(start.latitude * math.pi / 180);

    final distance = math.sqrt(dLat * dLat + dLon * dLon);
    return double.parse(distance.toStringAsFixed(2));
  }

  // กรองและ Map venues ให้เป็นโครงสร้างข้อมูลที่เราต้องการ
  List<Map<String, dynamic>> filteredVenues = data.where((venue) {
    // ตรวจสอบว่ามีตำแหน่งหรือไม่
    if (venue.position == null) return false;

    // คำนวณระยะทาง
    final venueLocation =
        LatLng(venue.position!.latitude, venue.position!.longitude);
    final distance = calculateDistance(userLocation, venueLocation);

    // เช็คเงื่อนไข styleMusicfilter (ถ้าไม่มีการกรอง ก็ผ่าน)
    bool matchesMusicStyle = styleMusicfilter == null ||
        styleMusicfilter.isEmpty ||
        styleMusicfilter
            .any((style) => venue.styleMusic?.contains(style) ?? false);

    // เช็คเงื่อนไข styleVenusefilter (ถ้าไม่มีการกรอง ก็ผ่าน)
    bool matchesVenueStyle = styleVenusefilter == null ||
        styleVenusefilter.isEmpty ||
        styleVenusefilter
            .any((style) => venue.styleVenuse?.contains(style) ?? false);

    // เงื่อนไขหลักคือ ระยะทางไม่เกิน maxDistance และต้องตรงกับ style ที่กำหนด (Music หรือ Venuse)
    return (distance <= maxDistance) &&
        (matchesMusicStyle || matchesVenueStyle);
  }).map((venue) {
    // แปลงเป็น Map เพื่อสะดวกในการส่งออก
    final venueLocation =
        LatLng(venue.position!.latitude, venue.position!.longitude);
    final distance = calculateDistance(userLocation, venueLocation);

    return {
      'Name_Venuse': venue.nameVenuse,
      'BG': venue.bg,
      'capacity': venue.capacity,
      'max_capacity': venue.maxCapacity,
      'Open_Close_time': venue.openCloseTime,
      'styleVenuse': venue.styleVenuse,
      'StyleMusic': venue.styleMusic,
      'Logo': venue.logo,
      'Events': venue.events,
      'distance': distance,
      'doc_ref': venue.reference,
      'position': venue.position!,
      'iDVenuse': venue.reference,
      'EventID': venue.events,
      'rating': venue.rating,
      'promotion': venue.promotion,
      'listpromotion': venue.listpromotion,
    };
  }).toList();

  // ถ้า loveVenuseOnly == true ให้เอาเฉพาะอันที่อยู่ใน loveVenuse เท่านั้น
  if (loveVenuseOnly == true && loveVenuse != null) {
    filteredVenues = filteredVenues
        .where((venue) => loveVenuse.contains(venue['doc_ref']))
        .toList();
  }

  // เรียงตามระยะทางจากใกล้ไปไกล
  filteredVenues.sort((a, b) => a['distance'].compareTo(b['distance']));

  // หาก searchMap == true แสดงว่าต้องการค้นหาบนแผนที่ ไม่ต้องแบ่งหน้า
  if (searchMap == true) {
    return filteredVenues;
  } else {
    // หากต้องการแบ่งหน้า (pagination)
    int itemsPerPage = 20;
    int pageNumber = page ?? 1;
    int startIndex = (pageNumber - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    if (startIndex >= filteredVenues.length) {
      return [];
    }
    if (endIndex > filteredVenues.length) {
      endIndex = filteredVenues.length;
    }

    // คืนค่าข้อมูลเฉพาะหน้าที่เลือก
    return filteredVenues.sublist(startIndex, endIndex);
  }
}

double? latt(LatLng? location) {
  return location?.latitude;
}

double? lngg(LatLng? location) {
  return location?.longitude;
}

String? month(DateTime? dateclick) {
  if (dateclick == null) {
    return null;
  }
  final DateFormat formatter = DateFormat('MMMM');
  final String month = formatter.format(dateclick);
  return month;
}

String? googlemapURL(LatLng? latlonPosition) {
  if (latlonPosition == null) {
    return null; // Handle the case when latlonPosition is null
  }

  final latitude = latlonPosition.latitude;
  final longitude = latlonPosition.longitude;

  // Construct the Google Maps URL
  final googleMapUrl = 'https://www.google.com/maps?q=$latitude,$longitude';

  return googleMapUrl;
}

double? distanceLocation(
  LatLng? locationA,
  LatLng? locationB,
) {
  if (locationA == null || locationB == null) {
    return null;
  }

  const double degreeToKm = 111.32; // 1 degree of latitude ~ 111.32 km

  // Difference in degrees
  final dLat = (locationB.latitude - locationA.latitude) * degreeToKm;
  final dLon = (locationB.longitude - locationA.longitude) *
      degreeToKm *
      math.cos(locationA.latitude * math.pi / 180);

  // Pythagorean Theorem
  final distance = math.sqrt(dLat * dLat + dLon * dLon);

  return double.parse(distance.toStringAsFixed(2));
}

int? searchIndexEvent(
  List<EventsRecord>? event,
  SupabaseDocRef? dataselect,
) {
  // ตรวจสอบว่า dataEvent และ dataselect มีค่า null หรือไม่
  if (event == null || dataselect == null) {
    return null;
  }

  // ค้นหา index ของ dataselect ใน list ของ dataEvent
  for (int i = 0; i < event.length; i++) {
    if (event[i].reference == dataselect) {
      return i; // ส่งคืน index ที่พบ
    }
  }

  // หากไม่พบ dataselect ใน dataEvent ส่งคืน null
  return null;
}

int? searchIndexVenuse(
  List<VenuesRecord>? venuses,
  SupabaseDocRef? dataselect,
) {
  // ตรวจสอบว่า dataEvent และ dataselect มีค่า null หรือไม่
  if (venuses == null || dataselect == null) {
    return null;
  }

  // ค้นหา index ของ dataselect ใน list ของ dataEvent
  for (int i = 0; i < venuses.length; i++) {
    if (venuses[i].reference == dataselect) {
      return i; // ส่งคืน index ที่พบ
    }
  }

  // หากไม่พบ dataselect ใน dataEvent ส่งคืน null
  return null;
}

List<EventsRecord>? dataEventDocRef(
  double? maxDistance,
  LatLng? userLocation,
  List<SupabaseDocRef>? loveEvents,
  List<String>? musicstyle,
  List<EventsRecord>? events,
  bool? searchDate,
  DateTime? dateselect,
) {
  if (maxDistance == null || userLocation == null || events == null) {
    return null;
  }

  // Function to calculate approximate distance between two LatLng points using Euclidean formula
  double calculateDistance(LatLng start, LatLng end) {
    const double degreeToKm = 111.32; // 1 degree of latitude ~ 111.32 km

    // Difference in degrees
    final dLat = (end.latitude - start.latitude) * degreeToKm;
    final dLon = (end.longitude - start.longitude) *
        degreeToKm *
        math.cos(start.latitude * math.pi / 180);

    // Euclidean distance
    final distance = math.sqrt(dLat * dLat + dLon * dLon);

    // Return distance rounded to 2 decimal places
    return double.parse(distance.toStringAsFixed(2));
  }

  // Filter events based on distance, musicstyle, and date
  List<EventsRecord> filteredEvents = events.where((event) {
    if (event.location == null) return false; // Check if location is null

    LatLng eventLocation =
        LatLng(event.location!.latitude, event.location!.longitude);
    double distance = calculateDistance(userLocation, eventLocation);

    // Check distance and musicstyle
    bool matchesMusicStyle = musicstyle == null ||
        musicstyle.isEmpty ||
        musicstyle.contains(event.musicstyle);

    // Date filtering
    bool matchesDate = true;
    if (searchDate == true && dateselect != null && event.date != null) {
      DateTime eventDate =
          DateTime(event.date!.year, event.date!.month, event.date!.day);
      DateTime selectedDate =
          DateTime(dateselect.year, dateselect.month, dateselect.day);
      matchesDate = eventDate == selectedDate;
    }

    return distance <= maxDistance && matchesMusicStyle && matchesDate;
  }).toList();

  // Separate loveEvents and non-loveEvents
  List<EventsRecord> loveEventsList = [];
  List<EventsRecord> nonLoveEventsList = [];

  for (var event in filteredEvents) {
    // Check if loveEvents contains the reference of the event
    if (loveEvents != null && loveEvents.contains(event.reference)) {
      loveEventsList.add(event);
    } else {
      nonLoveEventsList.add(event);
    }
  }

  // Sort both lists by distance
  loveEventsList.sort((a, b) {
    LatLng aLocation = LatLng(a.location!.latitude, a.location!.longitude);
    LatLng bLocation = LatLng(b.location!.latitude, b.location!.longitude);
    return calculateDistance(userLocation, aLocation)
        .compareTo(calculateDistance(userLocation, bLocation));
  });

  nonLoveEventsList.sort((a, b) {
    LatLng aLocation = LatLng(a.location!.latitude, a.location!.longitude);
    LatLng bLocation = LatLng(b.location!.latitude, b.location!.longitude);
    return calculateDistance(userLocation, aLocation)
        .compareTo(calculateDistance(userLocation, bLocation));
  });

  // Combine the lists with loveEvents first
  List<EventsRecord> sortedEvents = [...loveEventsList, ...nonLoveEventsList];

  return sortedEvents;
}

String? addName(List<String>? names) {
  if (names == null || names.isEmpty) {
    return null; // ถ้ารายการว่างเปล่าหรือไม่มีค่าให้คืนค่า null
  }

  // ใช้ join เพื่อเชื่อมรายการของชื่อเข้าด้วยกัน
  return names.join(" "); // จะเชื่อมชื่อในรายการด้วย space ระหว่างชื่อ
}

String? linkLine(String? iDline) {
  if (iDline == null || iDline.isEmpty) {
    return null; // ตรวจสอบว่า ID ไม่เป็น null หรือว่าง
  }
  const String baseUrl = "line://ti/p/";
  return baseUrl + iDline; // ต่อ URL กับ parameter ID
}

List<String>? selectpicture(
  int? numselect,
  List<String>? data,
) {
  /// ตรวจสอบว่า data และ numselect ไม่เป็น null และ numselect อยู่ในขอบเขตของลิสต์หรือไม่
  if (data == null ||
      numselect == null ||
      numselect < 0 ||
      numselect >= data.length) {
    return data; // ถ้าข้อมูลหรือ index ไม่ถูกต้อง ให้ส่งกลับลิสต์เดิม
  }

  /// ทำการสลับตำแหน่งของภาพที่เลือกให้มาอยู่ตำแหน่งแรก
  String selectedPicture = data[numselect];
  data.removeAt(numselect);
  data.insert(0, selectedPicture);

  return data; // ส่งกลับลิสต์ที่แก้ไขแล้ว
}

String? addname(List<String>? data) {
  // add "," between name in list name
  if (data == null || data.isEmpty) {
    return null;
  }

  return data.join(',');
}

double? listaverage(List<ReviewStruct>? data) {
  // ตรวจสอบว่ารายการไม่เป็น null และไม่ว่างเปล่า
  if (data == null || data.isEmpty) {
    return null;
  }

  double sum = 0.0;
  final int length = data.length;

  // ใช้ลูปแบบดัชนีเพื่อเพิ่มประสิทธิภาพ
  for (int i = 0; i < length; i++) {
    sum += data[i].rate;
  }

  // คำนวณค่าเฉลี่ย
  return sum / length;
}

double? inttodouble(int? data) {
  return data?.toDouble();
}

int? doubleinteger(double? data) {
  if (data == null) {
    return null;
  }
  return data.floor();
}

List<VenuesRecord>? dataVenuseDocref(
  double? maxDistance,
  LatLng? userLocation,
  List<SupabaseDocRef>? loveVenues,
  List<String>? styleMusicfilter,
  List<String>? styleVenusefilter,
  List<VenuesRecord>? venues,
) {
  if (maxDistance == null || userLocation == null || venues == null) {
    return null;
  }

  // ฟังก์ชันสำหรับคำนวณระยะห่างระหว่างสองจุด LatLng โดยใช้สูตร Euclidean
  double calculateDistance(LatLng start, LatLng end) {
    const double degreeToKm = 111.32; // 1 degree ของละติจูด ~ 111.32 กม.

    // ความแตกต่างขององศา
    final dLat = (end.latitude - start.latitude) * degreeToKm;
    final dLon = (end.longitude - start.longitude) *
        degreeToKm *
        math.cos(start.latitude * math.pi / 180);

    // ระยะทางแบบ Euclidean
    final distance = math.sqrt(dLat * dLat + dLon * dLon);

    // คืนค่าระยะทางที่ปัดเศษทศนิยมสองตำแหน่ง
    return double.parse(distance.toStringAsFixed(2));
  }

  // กรองเวนิวส์ตามระยะทางและสไตล์
  List<VenuesRecord> filteredVenues = venues.where((venue) {
    if (venue.position == null)
      return false; // ตรวจสอบว่า position ไม่เป็น null

    LatLng venueLocation =
        LatLng(venue.position!.latitude, venue.position!.longitude);
    double distance = calculateDistance(userLocation, venueLocation);

    // ตรวจสอบว่าเวนิวส์ตรงกับสไตล์เพลงที่เลือก
    bool matchesMusicStyle = styleMusicfilter == null ||
        styleMusicfilter.isEmpty ||
        styleMusicfilter
            .any((style) => venue.styleMusic?.contains(style) ?? false);

    // ตรวจสอบว่าเวนิวส์ตรงกับสไตล์เวนิวส์ที่เลือก
    bool matchesVenueStyle = styleVenusefilter == null ||
        styleVenusefilter.isEmpty ||
        styleVenusefilter
            .any((style) => venue.styleVenuse?.contains(style) ?? false);

    return distance <= maxDistance && matchesMusicStyle && matchesVenueStyle;
  }).toList();

  // แยกเวนิวส์ที่อยู่ในรายการโปรดและไม่อยู่ในรายการโปรด
  List<VenuesRecord> loveVenuesList = [];
  List<VenuesRecord> nonLoveVenuesList = [];

  for (var venue in filteredVenues) {
    // ตรวจสอบว่า loveVenues มี reference ของเวนิวส์นี้หรือไม่
    if (loveVenues != null && loveVenues.contains(venue.reference)) {
      loveVenuesList.add(venue);
    } else {
      nonLoveVenuesList.add(venue);
    }
  }

  // จัดเรียงทั้งสองรายการตามระยะทาง
  loveVenuesList.sort((a, b) {
    LatLng aLocation = LatLng(a.position!.latitude, a.position!.longitude);
    LatLng bLocation = LatLng(b.position!.latitude, b.position!.longitude);
    return calculateDistance(userLocation, aLocation)
        .compareTo(calculateDistance(userLocation, bLocation));
  });

  nonLoveVenuesList.sort((a, b) {
    LatLng aLocation = LatLng(a.position!.latitude, a.position!.longitude);
    LatLng bLocation = LatLng(b.position!.latitude, b.position!.longitude);
    return calculateDistance(userLocation, aLocation)
        .compareTo(calculateDistance(userLocation, bLocation));
  });

  // รวมรายการโดยมีเวนิวส์ที่ชอบอยู่ก่อน
  List<VenuesRecord> sortedVenues = [...loveVenuesList, ...nonLoveVenuesList];

  return sortedVenues;
}

bool? checkdate(
  DateTime? date1,
  DateTime? date2,
) {
  if (date1 == null || date2 == null) {
    return null; // คืนค่า null ถ้าข้อมูลใดๆ เป็น null
  }

  // นิยามใหม่ของ "วัน" คือ ช่วงเวลา 7:00 น. ของแต่ละวัน จนถึง 7:00 น. ของวันถัดไป
  // ขั้นตอน:
  // 1. หาเวลาเริ่มต้นของช่วง "วัน" ที่ date1 อยู่ในนั้น
  //    - ถ้า date1 ก่อน 7 โมงเช้า (hour < 7) แสดงว่าช่วงวันของ date1 เริ่มตั้งแต่ 7 โมงเช้าของวันก่อนหน้า
  //    - ถ้า date1 หลังหรือเท่ากับ 7 โมงเช้า (hour >= 7) แสดงว่าช่วงวันของ date1 เริ่มตั้งแต่ 7 โมงเช้าของวันเดียวกัน
  //
  // 2. ทำแบบเดียวกันกับ date2
  //
  // 3. ถ้าเริ่มต้นช่วงวันเดียวกัน (block start) ของ date1 และ date2 ตรงกัน แสดงว่ายังเป็น "วัน" เดียวกันตามเงื่อนไขใหม่
  //    ถ้าไม่ตรงกัน คืน false

  DateTime blockStart(DateTime dt) {
    final dayStart =
        DateTime(dt.year, dt.month, dt.day); // ช่วง 00:00 ของวันนั้น
    if (dt.hour < 7) {
      // ยังไม่ถึง 7 โมง แสดงว่าอยู่ในช่วงวันก่อนหน้า
      final previousDay = dayStart.subtract(const Duration(days: 1));
      return DateTime(previousDay.year, previousDay.month, previousDay.day, 7);
    } else {
      // ตั้งแต่ 7 โมงเช้าเป็นต้นไป ถือว่าเป็นช่วงวันใหม่
      return DateTime(dt.year, dt.month, dt.day, 7);
    }
  }

  final blockStart1 = blockStart(date1);
  final blockStart2 = blockStart(date2);

  return blockStart1 == blockStart2;
}

double? scaleshowuser(
  double? screenwide,
  double? num,
) {
  if (screenwide == null || num == null) {
    return null; // กรณีค่าที่ส่งมาเป็น null
  }

  // คำนวณ 25% ของ screenwide
  double twentyFivePercentScreenwide = 0.25 * screenwide;

  // คำนวณ 25%screenwide + 24
  double computedValue = twentyFivePercentScreenwide + 24;

  // ปัด num ขึ้นไปเป็นจำนวนเต็ม
  double roundedNum = (num * 0.25).ceilToDouble();

  // ผลลัพธ์สุดท้าย
  return (computedValue * roundedNum) + 100;
}

double? addpending(
  double? a,
  double? b,
) {
  // data A + data B
  if (a == null || b == null) {
    return null;
  }

  return a + b;
}

double? posterscale(
  double? scalewile,
  bool? showall,
) {
  if (scalewile != null) {
    double baseScale = scalewile * 0.446 * 1.4141592;
    if (showall == true) {
      return baseScale + 17;
    } else {
      return baseScale;
    }
  } else {
    return null;
  }
}

DateTime? boxstarttime(DateTime? datanow) {
  if (datanow != null) {
    return datanow.subtract(Duration(hours: 7));
  }
  return null; // คืนค่า null ถ้า datanow เป็น null
}

List<VenuesRecord>? connectVenuse(
  List<VenuesRecord>? dataVenuse,
  LatLng? location,
  double? distance,
) {
  if (dataVenuse == null || location == null || distance == null) {
    return null;
  }

  // ใช้ distance เป็นหน่วยเมตร
  final maxDistance = distance;

  // ฟังก์ชันคำนวณระยะทางโดยประมาณในหน่วยเมตร
  // โดยใช้การประมาณเชิง Euclidean และสมมติให้ 1 องศาละติจูด ≈ 111,320 เมตร
  double calculateDistance(LatLng start, LatLng end) {
    const double degreeToM = 111320.0; // 1 degree of latitude ~ 111,320 m
    final dLat = (end.latitude - start.latitude) * degreeToM;
    final dLon = (end.longitude - start.longitude) *
        degreeToM *
        math.cos(start.latitude * math.pi / 180);

    return math.sqrt(dLat * dLat + dLon * dLon);
  }

  // คัดกรองร้านค้าที่อยู่ภายในระยะที่กำหนด (เมตร)
  final filteredVenues = dataVenuse.where((venue) {
    if (venue.position == null) return false;
    final venueLocation =
        LatLng(venue.position!.latitude, venue.position!.longitude);
    final dist = calculateDistance(location, venueLocation);
    return dist <= maxDistance;
  }).toList();

  return filteredVenues;
}

bool? check2position(
  LatLng? lo1,
  LatLng? lo2,
  double? distance,
) {
  print(lo1);
  print(lo2);
  print(distance);
  // ตรวจสอบค่าว่าห้ามเป็น null หรือ distance ต้องเป็นค่ามากกว่า 0
  if (lo1 == null || lo2 == null || distance == null || distance <= 0) {
    return null;
  }

  // รัศมีโลกโดยประมาณ (กิโลเมตร)
  const double earthRadius = 6371.0;
  double toRadians(double degree) => degree * math.pi / 180;

  // คำนวณความแตกต่างของละติจูดและลองจิจูด
  double dLat = toRadians(lo2.latitude - lo1.latitude);
  double dLng = toRadians(lo2.longitude - lo1.longitude);

  // ใช้สูตร Haversine ในการคำนวณระยะทางระหว่างสองจุด
  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(toRadians(lo1.latitude)) *
          math.cos(toRadians(lo2.latitude)) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  double km = earthRadius * c;
  print(km);
  print(distance);

  // ตรวจสอบว่าอยู่ภายในระยะทางที่กำหนดหรือไม่
  return true;
}

double? positionprice(double? wlid) {
  if (wlid == null) {
    return null; // กรณี wlid เป็น null
  }
  return wlid * 0.028; // คำนวณ 2.8% ของ wlid
}

String? newCustomFunction(
  String? name,
  int? num,
) {
  if (name == null || num == null || num <= 0) {
    return name;
  }

  if (name.length <= num) {
    return name;
  }

  return name.substring(0, num) + '...';
}

bool? checkdayactivepromotion(
  bool? mon,
  bool? tue,
  bool? wed,
  bool? thu,
  bool? fri,
  bool? sat,
  bool? sun,
  DateTime? date,
) {
  // หากไม่มีค่า date ก็ให้ return false ทันที
  if (date == null) {
    return false;
  }

  // ตรวจสอบ date.weekday (1 = จันทร์, 2 = อังคาร, ... 7 = อาทิตย์)
  switch (date.weekday) {
    case DateTime.monday: // 1
      return mon == true;
    case DateTime.tuesday: // 2
      return tue == true;
    case DateTime.wednesday: // 3
      return wed == true;
    case DateTime.thursday: // 4
      return thu == true;
    case DateTime.friday: // 5
      return fri == true;
    case DateTime.saturday: // 6
      return sat == true;
    case DateTime.sunday: // 7
      return sun == true;
    default:
      // กรณีค่าไม่ตรง หรือเกิดข้อผิดพลาด
      return false;
  }
}

List<PromotionDataSubStruct>? sourcedatadatepromotion(
  List<PromotionDataSubStruct>? data,
  DateTime? dateclick,
  bool? todaycheck,
) {
  // 1) ถ้า data เป็น null => return null
  if (data == null) {
    return null;
  }

  // 2) สร้างตัวแปร dayToUse โดย:
  //    - ถ้า todaycheck == true => ใช้ DateTime.now() (current time)
  //    - ถ้าไม่ใช่ => ใช้ dateclick ถ้า dateclick != null,
  //      แต่ถ้า dateclick เป็น null ก็ fallback เป็น now() ไปเลย
  final DateTime dayToUse =
      (todaycheck == true) ? DateTime.now() : (dateclick ?? DateTime.now());

  // 3) แปลง dayToUse เป็นตัวย่อวัน (Mon, Tue, Wed, Thu, Fri, Sat, Sun)
  final List<String> abbreviations = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];
  // weekday: Monday=1, Tuesday=2, ..., Sunday=7
  final String clickedDayAbbrev = abbreviations[dayToUse.weekday - 1];
  final int clickedWeekday = dayToUse.weekday;

  // ฟังก์ชันภายในเพื่อตรวจสอบว่าโปรโมชั่นหนึ่งๆ เปิดใช้งานในวันนั้นหรือไม่
  bool isPromotionActive(PromotionDataSubStruct promo, int weekday) {
    bool active;
    switch (weekday) {
      case DateTime.monday:
        active = promo.mon == true;
        break;
      case DateTime.tuesday:
        active = promo.tue == true;
        break;
      case DateTime.wednesday:
        active = promo.wed == true;
        break;
      case DateTime.thursday:
        active = promo.thu == true;
        break;
      case DateTime.friday:
        active = promo.fri == true;
        break;
      case DateTime.saturday:
        active = promo.sat == true;
        break;
      case DateTime.sunday:
        active = promo.sun == true;
        break;
      default:
        active = false;
    }
    return active;
  }

  // 4) สร้างสำเนาของ data แล้ว sort โดยโปรโมชั่นที่เปิดใช้งานในวันนั้นจะอยู่ข้างบน
  final List<PromotionDataSubStruct> sortedList =
      List<PromotionDataSubStruct>.from(data);

  sortedList.sort((a, b) {
    final bool aHasDay = isPromotionActive(a, clickedWeekday);
    final bool bHasDay = isPromotionActive(b, clickedWeekday);

    if (aHasDay && !bHasDay) {
      return -1; // a อยู่ข้างบน
    } else if (!aHasDay && bHasDay) {
      return 1; // b อยู่ข้างบน
    } else {
      return 0; // ไม่มีการเปลี่ยนแปลงลำดับ
    }
  });

  // 5) ถ้า todaycheck == true => แสดงเฉพาะรายการที่เปิดใช้งานในวันนั้น
  if (todaycheck == true) {
    sortedList.removeWhere(
      (promo) => !isPromotionActive(promo, clickedWeekday),
    );
  }

  // 6) Return list ที่ผ่านการ sort (และอาจ filter หาก todaycheck == true)
  return sortedList;
}

bool? checkday(
  List<PromotionDataSubStruct>? data,
  DateTime? date,
) {
  // หากไม่มีข้อมูลโปรโมชั่นหรือไม่มีวันที่ให้ตรวจสอบ ก็ให้ return false ทันที
  if (data == null || date == null) {
    return false;
  }

  // ฟังก์ชันภายในเพื่อตรวจสอบว่าโปรโมชั่นหนึ่งๆ เปิดใช้งานในวันนั้นหรือไม่
  bool isPromotionActive(PromotionDataSubStruct promotion, int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return promotion.mon == true;
      case DateTime.tuesday:
        return promotion.tue == true;
      case DateTime.wednesday:
        return promotion.wed == true;
      case DateTime.thursday:
        return promotion.thu == true;
      case DateTime.friday:
        return promotion.fri == true;
      case DateTime.saturday:
        return promotion.sat == true;
      case DateTime.sunday:
        return promotion.sun == true;
      default:
        return false;
    }
  }

  // ใช้ฟังก์ชัน any เพื่อตรวจสอบว่าโปรโมชั่นใด ๆ ในรายการใช้งานได้ในวันนั้นหรือไม่
  return data.any((promotion) => isPromotionActive(promotion, date.weekday));
}

double? scaleshowphoto(
  double? wild,
  double? border,
) {
  // ตรวจสอบค่า null ของพารามิเตอร์
  if (wild == null || border == null) {
    return null;
  }

  // คำนวณตามสูตรที่กำหนด
  return ((wild - 2 * border) / 3) * 2 + 20;
}

List<SupabaseDocRef>? addref1(
  List<SupabaseDocRef>? data,
  SupabaseDocRef? userref,
) {
  final newList = <SupabaseDocRef>[];
  if (userref != null) {
    newList.add(userref); // เพิ่ม userref เป็นอันดับแรก
    if (data != null) {
      final index = data.indexOf(userref);
      if (index != -1) {
        // แยกส่วนหลังและส่วนก่อน userref
        final elementsAfter = data.sublist(index + 1);
        final elementsBefore = data.sublist(0, index);
        newList.addAll(elementsAfter); // เพิ่มส่วนหลัง
        newList.addAll(elementsBefore); // เพิ่มส่วนก่อน
      } else {
        // หากไม่พบ userref ใน data ให้เพิ่มข้อมูลทั้งหมด (ยกเว้น userref)
        newList.addAll(data.where((item) => item != userref));
      }
    }
  } else {
    // หาก userref เป็น null ให้ใช้ข้อมูลเดิม
    if (data != null) {
      newList.addAll(data);
    }
  }
  return newList.isNotEmpty ? newList : null;
}

int? int5(int? numdata) {
  // สำหรับค่า numdata ที่น้อยกว่า 5 จะคืนค่า null
  if (numdata == null || numdata < 5) {
    return null;
  }
  // เมื่อ numdata >= 5 ให้คำนวณ index โดยเริ่มที่ 5=0, 6=1, 7=2, 8=3, 9=4 แล้ววนซ้ำ
  return (numdata - 5) % 5;
}

double? addtapsilverscale(
  double? width,
  double? add,
) {
  if (width == null || add == null) {
    return null;
  }
  return (width - add);
}

String? linkgrab(
  String? storeName,
  LatLng? location,
) {
  if (storeName == null || storeName.trim().isEmpty || location == null) {
    return null;
  }

  // ตัดช่องว่างส่วนเกิน + fix ทศนิยมให้พอดู/พิมพ์ง่าย
  final name = storeName.trim();
  final lat = location.latitude.toStringAsFixed(6);
  final lon = location.longitude.toStringAsFixed(6);

  // สร้างสกีม Grab โดยตรง:
  // grab://open?screenType=BOOKING&dropOffLatitude=...&dropOffLongitude=...&destination=...
  // หมายเหตุ: ใช้ Uri เพื่อให้ encode ค่าพารามิเตอร์ให้อัตโนมัติ
  final uri = Uri(
    scheme: 'grab',
    host: 'open',
    queryParameters: <String, String>{
      'screenType': 'BOOKING',
      'dropOffLatitude': lat,
      'dropOffLongitude': lon,
      'destination': name,

      // --- เผื่อเปิดใช้ในอนาคต (บังคับจุดรับ) ---
      // 'pickupLatitude': '...',
      // 'pickupLongitude': '...',
      // 'pickupName': '...',
    },
  );

  return uri.toString();
}
