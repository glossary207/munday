import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends SupabaseRecord {
  UsersRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "caption" field.
  String? _caption;
  String get caption => _caption ?? '';
  bool hasCaption() => _caption != null;

  // "photoshow" field.
  UserphotoshowStruct? _photoshow;
  UserphotoshowStruct get photoshow => _photoshow ?? UserphotoshowStruct();
  bool hasPhotoshow() => _photoshow != null;

  // "checkin" field.
  String? _checkin;
  String get checkin => _checkin ?? '';
  bool hasCheckin() => _checkin != null;

  // "unread" field.
  int? _unread;
  int get unread => _unread ?? 0;
  bool hasUnread() => _unread != null;

  // "cheers" field.
  List<SupabaseDocRef>? _cheers;
  List<SupabaseDocRef> get cheers => _cheers ?? const [];
  bool hasCheers() => _cheers != null;

  // "usermassage" field.
  List<SupabaseDocRef>? _usermassage;
  List<SupabaseDocRef> get usermassage => _usermassage ?? const [];
  bool hasUsermassage() => _usermassage != null;

  // "cheersEnd" field.
  List<SupabaseDocRef>? _cheersEnd;
  List<SupabaseDocRef> get cheersEnd => _cheersEnd ?? const [];
  bool hasCheersEnd() => _cheersEnd != null;

  // "usermassageRead" field.
  List<SupabaseDocRef>? _usermassageRead;
  List<SupabaseDocRef> get usermassageRead => _usermassageRead ?? const [];
  bool hasUsermassageRead() => _usermassageRead != null;

  // "seeusercheers" field.
  bool? _seeusercheers;
  bool get seeusercheers => _seeusercheers ?? false;
  bool hasSeeusercheers() => _seeusercheers != null;

  // "usercheerme" field.
  List<SupabaseDocRef>? _usercheerme;
  List<SupabaseDocRef> get usercheerme => _usercheerme ?? const [];
  bool hasUsercheerme() => _usercheerme != null;

  // "showprofilecheers" field.
  List<SupabaseDocRef>? _showprofilecheers;
  List<SupabaseDocRef> get showprofilecheers =>
      _showprofilecheers ?? const [];
  bool hasShowprofilecheers() => _showprofilecheers != null;

  // "list_store" field.
  List<String>? _listStore;
  List<String> get listStore => _listStore ?? const [];
  bool hasListStore() => _listStore != null;

  // "unlimitcheers" field.
  bool? _unlimitcheers;
  bool get unlimitcheers => _unlimitcheers ?? false;
  bool hasUnlimitcheers() => _unlimitcheers != null;

  // "id_transaction_list" field.
  List<String>? _idTransactionList;
  List<String> get idTransactionList => _idTransactionList ?? const [];
  bool hasIdTransactionList() => _idTransactionList != null;

  // "pay_list" field.
  List<int>? _payList;
  List<int> get payList => _payList ?? const [];
  bool hasPayList() => _payList != null;

  // "newuser" field.
  bool? _newuser;
  bool get newuser => _newuser ?? false;
  bool hasNewuser() => _newuser != null;

  // "Blockuser" field.
  List<SupabaseDocRef>? _blockuser;
  List<SupabaseDocRef> get blockuser => _blockuser ?? const [];
  bool hasBlockuser() => _blockuser != null;

  // "BlockEDuser" field.
  List<SupabaseDocRef>? _blockEDuser;
  List<SupabaseDocRef> get blockEDuser => _blockEDuser ?? const [];
  bool hasBlockEDuser() => _blockEDuser != null;

  // "online" field.
  bool? _online;
  bool get online => _online ?? false;
  bool hasOnline() => _online != null;

  // "IDIG" field.
  String? _idig;
  String get idig => _idig ?? '';
  bool hasIdig() => _idig != null;

  // "IDFacebook" field.
  String? _iDFacebook;
  String get iDFacebook => _iDFacebook ?? '';
  bool hasIDFacebook() => _iDFacebook != null;

  // "Report" field.
  int? _report;
  int get report => _report ?? 0;
  bool hasReport() => _report != null;

  // "view" field.
  int? _view;
  int get view => _view ?? 0;
  bool hasView() => _view != null;

  // "checkinID" field.
  SupabaseDocRef? _checkinID;
  SupabaseDocRef? get checkinID => _checkinID;
  bool hasCheckinID() => _checkinID != null;

  // "readcheers" field.
  int? _readcheers;
  int get readcheers => _readcheers ?? 0;
  bool hasReadcheers() => _readcheers != null;

  // "openseeuser" field.
  List<SupabaseDocRef>? _openseeuser;
  List<SupabaseDocRef> get openseeuser => _openseeuser ?? const [];
  bool hasOpenseeuser() => _openseeuser != null;

  // "freeseeuser" field.
  int? _freeseeuser;
  int get freeseeuser => _freeseeuser ?? 0;
  bool hasFreeseeuser() => _freeseeuser != null;

  // "roomsend" field.
  List<SupabaseDocRef>? _roomsend;
  List<SupabaseDocRef> get roomsend => _roomsend ?? const [];
  bool hasRoomsend() => _roomsend != null;

  // "roomrecive" field.
  List<SupabaseDocRef>? _roomrecive;
  List<SupabaseDocRef> get roomrecive => _roomrecive ?? const [];
  bool hasRoomrecive() => _roomrecive != null;

  // "PopupEditProfile" field.
  bool? _popupEditProfile;
  bool get popupEditProfile => _popupEditProfile ?? false;
  bool hasPopupEditProfile() => _popupEditProfile != null;

  // "FCMtoken" field.
  String? _fCMtoken;
  String get fCMtoken => _fCMtoken ?? '';
  bool hasFCMtoken() => _fCMtoken != null;

  // "loveEvent" field.
  List<SupabaseDocRef>? _loveEvent;
  List<SupabaseDocRef> get loveEvent => _loveEvent ?? const [];
  bool hasLoveEvent() => _loveEvent != null;

  // "loveVenuse" field.
  List<SupabaseDocRef>? _loveVenuse;
  List<SupabaseDocRef> get loveVenuse => _loveVenuse ?? const [];
  bool hasLoveVenuse() => _loveVenuse != null;

  // "tickets" field.
  List<SupabaseDocRef>? _tickets;
  List<SupabaseDocRef> get tickets => _tickets ?? const [];
  bool hasTickets() => _tickets != null;

  // "IDROOMVenues" field.
  List<SupabaseDocRef>? _iDROOMVenues;
  List<SupabaseDocRef> get iDROOMVenues => _iDROOMVenues ?? const [];
  bool hasIDROOMVenues() => _iDROOMVenues != null;

  // "loginVenuesRoom" field.
  SupabaseDocRef? _loginVenuesRoom;
  SupabaseDocRef? get loginVenuesRoom => _loginVenuesRoom;
  bool hasLoginVenuesRoom() => _loginVenuesRoom != null;

  // "nameLoginVenues" field.
  String? _nameLoginVenues;
  String get nameLoginVenues => _nameLoginVenues ?? '';
  bool hasNameLoginVenues() => _nameLoginVenues != null;

  // "cheers_limit" field.
  int? _cheersLimit;
  int get cheersLimit => _cheersLimit ?? 0;
  bool hasCheersLimit() => _cheersLimit != null;

  // "set_cheers" field.
  bool? _setCheers;
  bool get setCheers => _setCheers ?? false;
  bool hasSetCheers() => _setCheers != null;

  // "logo_room" field.
  String? _logoRoom;
  String get logoRoom => _logoRoom ?? '';
  bool hasLogoRoom() => _logoRoom != null;

  // "Group_invite_ID" field.
  SupabaseDocRef? _groupInviteID;
  SupabaseDocRef? get groupInviteID => _groupInviteID;
  bool hasGroupInviteID() => _groupInviteID != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _caption = snapshotData['caption'] as String?;
    _photoshow = snapshotData['photoshow'] is UserphotoshowStruct
        ? snapshotData['photoshow']
        : UserphotoshowStruct.maybeFromMap(snapshotData['photoshow']);
    _checkin = snapshotData['checkin'] as String?;
    _unread = castToType<int>(snapshotData['unread']);
    _cheers = getDataList(snapshotData['cheers']);
    _usermassage = getDataList(snapshotData['usermassage']);
    _cheersEnd = getDataList(snapshotData['cheersEnd']);
    _usermassageRead = getDataList(snapshotData['usermassageRead']);
    _seeusercheers = snapshotData['seeusercheers'] as bool?;
    _usercheerme = getDataList(snapshotData['usercheerme']);
    _showprofilecheers = getDataList(snapshotData['showprofilecheers']);
    _listStore = getDataList(snapshotData['list_store']);
    _unlimitcheers = snapshotData['unlimitcheers'] as bool?;
    _idTransactionList = getDataList(snapshotData['id_transaction_list']);
    _payList = getDataList(snapshotData['pay_list']);
    _newuser = snapshotData['newuser'] as bool?;
    _blockuser = getDataList(snapshotData['Blockuser']);
    _blockEDuser = getDataList(snapshotData['BlockEDuser']);
    _online = snapshotData['online'] as bool?;
    _idig = snapshotData['IDIG'] as String?;
    _iDFacebook = snapshotData['IDFacebook'] as String?;
    _report = castToType<int>(snapshotData['Report']);
    _view = castToType<int>(snapshotData['view']);
    _checkinID = snapshotData['checkinID'] as SupabaseDocRef?;
    _readcheers = castToType<int>(snapshotData['readcheers']);
    _openseeuser = getDataList(snapshotData['openseeuser']);
    _freeseeuser = castToType<int>(snapshotData['freeseeuser']);
    _roomsend = getDataList(snapshotData['roomsend']);
    _roomrecive = getDataList(snapshotData['roomrecive']);
    _popupEditProfile = snapshotData['PopupEditProfile'] as bool?;
    _fCMtoken = snapshotData['FCMtoken'] as String?;
    _loveEvent = getDataList(snapshotData['loveEvent']);
    _loveVenuse = getDataList(snapshotData['loveVenuse']);
    _tickets = getDataList(snapshotData['tickets']);
    _iDROOMVenues = getDataList(snapshotData['IDROOMVenues']);
    _loginVenuesRoom = snapshotData['loginVenuesRoom'] as SupabaseDocRef?;
    _nameLoginVenues = snapshotData['nameLoginVenues'] as String?;
    _cheersLimit = castToType<int>(snapshotData['cheers_limit']);
    _setCheers = snapshotData['set_cheers'] as bool?;
    _logoRoom = snapshotData['logo_room'] as String?;
    _groupInviteID = snapshotData['Group_invite_ID'] as SupabaseDocRef?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(SupabaseDocSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      UsersRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? caption,
  UserphotoshowStruct? photoshow,
  String? checkin,
  int? unread,
  bool? seeusercheers,
  bool? unlimitcheers,
  bool? newuser,
  bool? online,
  String? idig,
  String? iDFacebook,
  int? report,
  int? view,
  SupabaseDocRef? checkinID,
  int? readcheers,
  int? freeseeuser,
  bool? popupEditProfile,
  String? fCMtoken,
  SupabaseDocRef? loginVenuesRoom,
  String? nameLoginVenues,
  int? cheersLimit,
  bool? setCheers,
  String? logoRoom,
  SupabaseDocRef? groupInviteID,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'caption': caption,
      'photoshow': UserphotoshowStruct().toMap(),
      'checkin': checkin,
      'unread': unread,
      'seeusercheers': seeusercheers,
      'unlimitcheers': unlimitcheers,
      'newuser': newuser,
      'online': online,
      'IDIG': idig,
      'IDFacebook': iDFacebook,
      'Report': report,
      'view': view,
      'checkinID': checkinID,
      'readcheers': readcheers,
      'freeseeuser': freeseeuser,
      'PopupEditProfile': popupEditProfile,
      'FCMtoken': fCMtoken,
      'loginVenuesRoom': loginVenuesRoom,
      'nameLoginVenues': nameLoginVenues,
      'cheers_limit': cheersLimit,
      'set_cheers': setCheers,
      'logo_room': logoRoom,
      'Group_invite_ID': groupInviteID,
    }.withoutNulls,
  );

  // Handle nested data for "photoshow" field.
  addUserphotoshowStructData(supabaseData, photoshow, 'photoshow');

  return supabaseData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.caption == e2?.caption &&
        e1?.photoshow == e2?.photoshow &&
        e1?.checkin == e2?.checkin &&
        e1?.unread == e2?.unread &&
        listEquality.equals(e1?.cheers, e2?.cheers) &&
        listEquality.equals(e1?.usermassage, e2?.usermassage) &&
        listEquality.equals(e1?.cheersEnd, e2?.cheersEnd) &&
        listEquality.equals(e1?.usermassageRead, e2?.usermassageRead) &&
        e1?.seeusercheers == e2?.seeusercheers &&
        listEquality.equals(e1?.usercheerme, e2?.usercheerme) &&
        listEquality.equals(e1?.showprofilecheers, e2?.showprofilecheers) &&
        listEquality.equals(e1?.listStore, e2?.listStore) &&
        e1?.unlimitcheers == e2?.unlimitcheers &&
        listEquality.equals(e1?.idTransactionList, e2?.idTransactionList) &&
        listEquality.equals(e1?.payList, e2?.payList) &&
        e1?.newuser == e2?.newuser &&
        listEquality.equals(e1?.blockuser, e2?.blockuser) &&
        listEquality.equals(e1?.blockEDuser, e2?.blockEDuser) &&
        e1?.online == e2?.online &&
        e1?.idig == e2?.idig &&
        e1?.iDFacebook == e2?.iDFacebook &&
        e1?.report == e2?.report &&
        e1?.view == e2?.view &&
        e1?.checkinID == e2?.checkinID &&
        e1?.readcheers == e2?.readcheers &&
        listEquality.equals(e1?.openseeuser, e2?.openseeuser) &&
        e1?.freeseeuser == e2?.freeseeuser &&
        listEquality.equals(e1?.roomsend, e2?.roomsend) &&
        listEquality.equals(e1?.roomrecive, e2?.roomrecive) &&
        e1?.popupEditProfile == e2?.popupEditProfile &&
        e1?.fCMtoken == e2?.fCMtoken &&
        listEquality.equals(e1?.loveEvent, e2?.loveEvent) &&
        listEquality.equals(e1?.loveVenuse, e2?.loveVenuse) &&
        listEquality.equals(e1?.tickets, e2?.tickets) &&
        listEquality.equals(e1?.iDROOMVenues, e2?.iDROOMVenues) &&
        e1?.loginVenuesRoom == e2?.loginVenuesRoom &&
        e1?.nameLoginVenues == e2?.nameLoginVenues &&
        e1?.cheersLimit == e2?.cheersLimit &&
        e1?.setCheers == e2?.setCheers &&
        e1?.logoRoom == e2?.logoRoom &&
        e1?.groupInviteID == e2?.groupInviteID;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.caption,
        e?.photoshow,
        e?.checkin,
        e?.unread,
        e?.cheers,
        e?.usermassage,
        e?.cheersEnd,
        e?.usermassageRead,
        e?.seeusercheers,
        e?.usercheerme,
        e?.showprofilecheers,
        e?.listStore,
        e?.unlimitcheers,
        e?.idTransactionList,
        e?.payList,
        e?.newuser,
        e?.blockuser,
        e?.blockEDuser,
        e?.online,
        e?.idig,
        e?.iDFacebook,
        e?.report,
        e?.view,
        e?.checkinID,
        e?.readcheers,
        e?.openseeuser,
        e?.freeseeuser,
        e?.roomsend,
        e?.roomrecive,
        e?.popupEditProfile,
        e?.fCMtoken,
        e?.loveEvent,
        e?.loveVenuse,
        e?.tickets,
        e?.iDROOMVenues,
        e?.loginVenuesRoom,
        e?.nameLoginVenues,
        e?.cheersLimit,
        e?.setCheers,
        e?.logoRoom,
        e?.groupInviteID
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
