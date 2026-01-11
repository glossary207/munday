import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/supabase_auth/auth_util.dart';
import 'supabase/supabase_shim.dart';
export 'supabase/supabase_shim.dart';

import '../flutter_flow/flutter_flow_util.dart';
import 'schema/util/supabase_util.dart';

import 'schema/users_record.dart';
import 'schema/store_record.dart';
import 'schema/room_record.dart';
import 'schema/events_record.dart';
import 'schema/venues_record.dart';
import 'schema/ticket_record.dart';
import 'schema/user_in_venues_record.dart';
import 'schema/promotion_record.dart';
import 'schema/venue_layouts_record.dart';
import 'schema/room_venues_live_chat_record.dart';
import 'schema/group_invite_record.dart';

export 'dart:async' show StreamSubscription;
export 'supabase/supabase_shim.dart';
export 'package:supabase_flutter/supabase_flutter.dart'; // To replace firebase_core sort of
export 'schema/index.dart';
export 'schema/util/supabase_util.dart';
export 'schema/util/schema_util.dart';

export 'schema/users_record.dart';
export 'schema/store_record.dart';
export 'schema/room_record.dart';
export 'schema/events_record.dart';
export 'schema/venues_record.dart';
export 'schema/ticket_record.dart';
export 'schema/user_in_venues_record.dart';
export 'schema/promotion_record.dart';
export 'schema/venue_layouts_record.dart';
export 'schema/room_venues_live_chat_record.dart';
export 'schema/group_invite_record.dart';

Stream<List<T>> queryCollection<T>(
  SupabaseQuery collection,
  RecordBuilder<T> recordBuilder, {
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.snapshots().map((s) => s.docs
      .map(
        (d) => safeGet(
          () => recordBuilder(d),
          (e) => print('Error serializing doc ${d.reference.path}\n$e'),
        ),
      )
      .where((d) => d != null)
      .map((d) => d!)
      .toList());
}

Future<List<T>> queryCollectionOnce<T>(
  SupabaseQuery collection,
  RecordBuilder<T> recordBuilder, {
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) async {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.get().then((s) => s.docs
      .map(
        (d) => safeGet(
          () => recordBuilder(d),
          (e) => print('Error serializing doc ${d.reference.path}\n$e'),
        ),
      )
      .where((d) => d != null)
      .map((d) => d!)
      .toList());
}

Future<int> queryCollectionCount(
  SupabaseQuery collection, {
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0) {
    query = query.limit(limit);
  }

  return query.count().get().then((s) => s.count);
}

typedef RecordBuilder<T> = T? Function(SupabaseDocSnapshot snapshot);

// --- UsersRecord ---
Future<int> queryUsersRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      UsersRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<UsersRecord>> queryUsersRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      UsersRecord.collection,
      UsersRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<UsersRecord>> queryUsersRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      UsersRecord.collection,
      UsersRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- StoreRecord ---
Future<int> queryStoreRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      StoreRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<StoreRecord>> queryStoreRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      StoreRecord.collection,
      StoreRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<StoreRecord>> queryStoreRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      StoreRecord.collection,
      StoreRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- RoomRecord ---
Future<int> queryRoomRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      RoomRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<RoomRecord>> queryRoomRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      RoomRecord.collection,
      RoomRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<RoomRecord>> queryRoomRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      RoomRecord.collection,
      RoomRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- EventsRecord ---
Future<int> queryEventsRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      EventsRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<EventsRecord>> queryEventsRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      EventsRecord.collection,
      EventsRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<EventsRecord>> queryEventsRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      EventsRecord.collection,
      EventsRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- VenuesRecord ---
Future<int> queryVenuesRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      VenuesRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<VenuesRecord>> queryVenuesRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      VenuesRecord.collection,
      VenuesRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<VenuesRecord>> queryVenuesRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      VenuesRecord.collection,
      VenuesRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- TicketRecord ---
Future<int> queryTicketRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TicketRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TicketRecord>> queryTicketRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TicketRecord.collection,
      TicketRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TicketRecord>> queryTicketRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TicketRecord.collection,
      TicketRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- UserInVenuesRecord ---
Future<int> queryUserInVenuesRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      UserInVenuesRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<UserInVenuesRecord>> queryUserInVenuesRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      UserInVenuesRecord.collection,
      UserInVenuesRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<UserInVenuesRecord>> queryUserInVenuesRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      UserInVenuesRecord.collection,
      UserInVenuesRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- PromotionRecord ---
Future<int> queryPromotionRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      PromotionRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<PromotionRecord>> queryPromotionRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      PromotionRecord.collection,
      PromotionRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<PromotionRecord>> queryPromotionRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      PromotionRecord.collection,
      PromotionRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- VenueLayoutsRecord ---
Future<int> queryVenueLayoutsRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      VenueLayoutsRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<VenueLayoutsRecord>> queryVenueLayoutsRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      VenueLayoutsRecord.collection,
      VenueLayoutsRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<VenueLayoutsRecord>> queryVenueLayoutsRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      VenueLayoutsRecord.collection,
      VenueLayoutsRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- RoomVenuesLiveChatRecord ---
Future<int> queryRoomVenuesLiveChatRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      RoomVenuesLiveChatRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<RoomVenuesLiveChatRecord>> queryRoomVenuesLiveChatRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      RoomVenuesLiveChatRecord.collection,
      RoomVenuesLiveChatRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<RoomVenuesLiveChatRecord>> queryRoomVenuesLiveChatRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      RoomVenuesLiveChatRecord.collection,
      RoomVenuesLiveChatRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

// --- GroupInviteRecord ---
Future<int> queryGroupInviteRecordCount({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      GroupInviteRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<GroupInviteRecord>> queryGroupInviteRecord({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      GroupInviteRecord.collection,
      GroupInviteRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<GroupInviteRecord>> queryGroupInviteRecordOnce({
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      GroupInviteRecord.collection,
      GroupInviteRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

class FFSupabasePage<T> {
  final List<T> data;
  final Stream<List<T>>? dataStream;
  final SupabaseQueryDocSnapshot? nextPageMarker;

  FFSupabasePage(this.data, this.dataStream, this.nextPageMarker);
}

Future<FFSupabasePage<T>> queryCollectionPage<T>(
  SupabaseQuery collection,
  RecordBuilder<T> recordBuilder, {
  SupabaseQuery Function(SupabaseQuery)? queryBuilder,
  SupabaseDocSnapshot? nextPageMarker,
  required int pageSize,
  required bool isStream,
}) async {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection).limit(pageSize);
  if (nextPageMarker != null) {
    query = query.startAfterDocument(nextPageMarker);
  }
  Stream<SupabaseQuerySnapshot>? docSnapshotStream;
  SupabaseQuerySnapshot docSnapshot;
  if (isStream) {
    docSnapshotStream = query.snapshots();
    docSnapshot = await docSnapshotStream.first;
  } else {
    docSnapshot = await query.get();
  }
  List<T> getDocs(SupabaseQuerySnapshot s) => s.docs
      .map(
        (d) => safeGet(
          () => recordBuilder(d),
          (e) => print('Error serializing doc ${d.reference.path}\n$e'),
        ),
      )
      .where((d) => d != null)
      .map((d) => d!)
      .toList();
  final data = getDocs(docSnapshot);
  final dataStream = docSnapshotStream?.map(getDocs);
  // docs.last might not work if SupabaseQuerySnapshot shim doesn't expose it list-like.
  // Updating Shim to ensure SupabaseQuerySnapshot.docs is a List.
  final nextPageToken = docSnapshot.docs.isEmpty
      ? null
      : docSnapshot.docs.last as SupabaseQueryDocSnapshot?;
  return FFSupabasePage(data, dataStream, nextPageToken);
}

// Creates a Firestore document representing the logged in user if it doesn't yet exist
Future maybeCreateUser(User user) async {
  // User is now Supabase User
  final userRecord = UsersRecord.collection.doc(user.id);
  final userExists = await userRecord.get().then((u) => u.exists);
  if (userExists) {
    currentUserDocument = await UsersRecord.getDocumentOnce(userRecord);
    return;
  }

  final userData = createUsersRecordData(
    email: user.email,
    displayName:
        user.userMetadata?['full_name'] ?? user.email, // Best guess mapping
    photoUrl: user.userMetadata?['avatar_url'],
    uid: user.id,
    phoneNumber: user.phone,
    createdTime: getCurrentTimestamp,
  );

  await userRecord.set(userData);
  currentUserDocument = UsersRecord.getDocumentFromData(userData, userRecord);
}

Future updateUserDocument({String? email}) async {
  await currentUserDocument?.reference
      .update(createUsersRecordData(email: email));
}
