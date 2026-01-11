import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _searchuser = false;
  bool get searchuser => _searchuser;
  set searchuser(bool value) {
    _searchuser = value;
  }

  String _userselectUID = '';
  String get userselectUID => _userselectUID;
  set userselectUID(String value) {
    _userselectUID = value;
  }

  bool _ActiveProfileUserPopup = false;
  bool get ActiveProfileUserPopup => _ActiveProfileUserPopup;
  set ActiveProfileUserPopup(bool value) {
    _ActiveProfileUserPopup = value;
  }

  String _namestorelink = '';
  String get namestorelink => _namestorelink;
  set namestorelink(String value) {
    _namestorelink = value;
  }

  SupabaseDocRef? _userselect;
  SupabaseDocRef? get userselect => _userselect;
  set userselect(SupabaseDocRef? value) {
    _userselect = value;
  }

  bool _ActivePromotion = false;
  bool get ActivePromotion => _ActivePromotion;
  set ActivePromotion(bool value) {
    _ActivePromotion = value;
  }

  bool _readyshowcheers = false;
  bool get readyshowcheers => _readyshowcheers;
  set readyshowcheers(bool value) {
    _readyshowcheers = value;
  }

  bool _PopupShowCheers = false;
  bool get PopupShowCheers => _PopupShowCheers;
  set PopupShowCheers(bool value) {
    _PopupShowCheers = value;
  }

  bool _zoom = false;
  bool get zoom => _zoom;
  set zoom(bool value) {
    _zoom = value;
  }

  bool _apiready = false;
  bool get apiready => _apiready;
  set apiready(bool value) {
    _apiready = value;
  }

  String _apione = '';
  String get apione => _apione;
  set apione(String value) {
    _apione = value;
  }

  String _apitwo = '';
  String get apitwo => _apitwo;
  set apitwo(String value) {
    _apitwo = value;
  }

  String _apithree = '';
  String get apithree => _apithree;
  set apithree(String value) {
    _apithree = value;
  }

  bool _lockfuctionadd = false;
  bool get lockfuctionadd => _lockfuctionadd;
  set lockfuctionadd(bool value) {
    _lockfuctionadd = value;
  }

  List<SupabaseDocRef> _showID = [];
  List<SupabaseDocRef> get showID => _showID;
  set showID(List<SupabaseDocRef> value) {
    _showID = value;
  }

  void addToShowID(SupabaseDocRef value) {
    showID.add(value);
  }

  void removeFromShowID(SupabaseDocRef value) {
    showID.remove(value);
  }

  void removeAtIndexFromShowID(int index) {
    showID.removeAt(index);
  }

  void updateShowIDAtIndex(
    int index,
    SupabaseDocRef Function(SupabaseDocRef) updateFn,
  ) {
    showID[index] = updateFn(_showID[index]);
  }

  void insertAtIndexInShowID(int index, SupabaseDocRef value) {
    showID.insert(index, value);
  }

  LatLng? _location;
  LatLng? get location => _location;
  set location(LatLng? value) {
    _location = value;
  }

  bool _relock = false;
  bool get relock => _relock;
  set relock(bool value) {
    _relock = value;
  }

  String _croppedImage = '';
  String get croppedImage => _croppedImage;
  set croppedImage(String value) {
    _croppedImage = value;
  }

  bool _instore = false;
  bool get instore => _instore;
  set instore(bool value) {
    _instore = value;
  }

  List<String> _addviewID = [];
  List<String> get addviewID => _addviewID;
  set addviewID(List<String> value) {
    _addviewID = value;
  }

  void addToAddviewID(String value) {
    addviewID.add(value);
  }

  void removeFromAddviewID(String value) {
    addviewID.remove(value);
  }

  void removeAtIndexFromAddviewID(int index) {
    addviewID.removeAt(index);
  }

  void updateAddviewIDAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    addviewID[index] = updateFn(_addviewID[index]);
  }

  void insertAtIndexInAddviewID(int index, String value) {
    addviewID.insert(index, value);
  }

  int _datachacge = 0;
  int get datachacge => _datachacge;
  set datachacge(int value) {
    _datachacge = value;
  }

  SupabaseDocRef? _storedoc;
  SupabaseDocRef? get storedoc => _storedoc;
  set storedoc(SupabaseDocRef? value) {
    _storedoc = value;
  }

  List<SupabaseDocRef> _blockroomadd = [];
  List<SupabaseDocRef> get blockroomadd => _blockroomadd;
  set blockroomadd(List<SupabaseDocRef> value) {
    _blockroomadd = value;
  }

  void addToBlockroomadd(SupabaseDocRef value) {
    blockroomadd.add(value);
  }

  void removeFromBlockroomadd(SupabaseDocRef value) {
    blockroomadd.remove(value);
  }

  void removeAtIndexFromBlockroomadd(int index) {
    blockroomadd.removeAt(index);
  }

  void updateBlockroomaddAtIndex(
    int index,
    SupabaseDocRef Function(SupabaseDocRef) updateFn,
  ) {
    blockroomadd[index] = updateFn(_blockroomadd[index]);
  }

  void insertAtIndexInBlockroomadd(int index, SupabaseDocRef value) {
    blockroomadd.insert(index, value);
  }

  String _languages = '';
  String get languages => _languages;
  set languages(String value) {
    _languages = value;
  }

  bool _lockeditprofilepopup = false;
  bool get lockeditprofilepopup => _lockeditprofilepopup;
  set lockeditprofilepopup(bool value) {
    _lockeditprofilepopup = value;
  }

  bool _showprofile = false;
  bool get showprofile => _showprofile;
  set showprofile(bool value) {
    _showprofile = value;
  }

  List<String> _photohowto = [
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/m7f50e60o4li/12.png',
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/ptigutwmwcxt/13.png',
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/to20g1xtx0w4/14.png',
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/2b9qe93zugdw/15.png'
  ];
  List<String> get photohowto => _photohowto;
  set photohowto(List<String> value) {
    _photohowto = value;
  }

  void addToPhotohowto(String value) {
    photohowto.add(value);
  }

  void removeFromPhotohowto(String value) {
    photohowto.remove(value);
  }

  void removeAtIndexFromPhotohowto(int index) {
    photohowto.removeAt(index);
  }

  void updatePhotohowtoAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    photohowto[index] = updateFn(_photohowto[index]);
  }

  void insertAtIndexInPhotohowto(int index, String value) {
    photohowto.insert(index, value);
  }

  String _menuActiveitem = '';
  String get menuActiveitem => _menuActiveitem;
  set menuActiveitem(String value) {
    _menuActiveitem = value;
  }

  List<String> _menuItems = ['Home', 'Events', 'Venues', 'Promotion'];
  List<String> get menuItems => _menuItems;
  set menuItems(List<String> value) {
    _menuItems = value;
  }

  void addToMenuItems(String value) {
    menuItems.add(value);
  }

  void removeFromMenuItems(String value) {
    menuItems.remove(value);
  }

  void removeAtIndexFromMenuItems(int index) {
    menuItems.removeAt(index);
  }

  void updateMenuItemsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    menuItems[index] = updateFn(_menuItems[index]);
  }

  void insertAtIndexInMenuItems(int index, String value) {
    menuItems.insert(index, value);
  }

  DateTime? _dateclick;
  DateTime? get dateclick => _dateclick;
  set dateclick(DateTime? value) {
    _dateclick = value;
  }

  List<DateTime> _dateevents = [];
  List<DateTime> get dateevents => _dateevents;
  set dateevents(List<DateTime> value) {
    _dateevents = value;
  }

  void addToDateevents(DateTime value) {
    dateevents.add(value);
  }

  void removeFromDateevents(DateTime value) {
    dateevents.remove(value);
  }

  void removeAtIndexFromDateevents(int index) {
    dateevents.removeAt(index);
  }

  void updateDateeventsAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    dateevents[index] = updateFn(_dateevents[index]);
  }

  void insertAtIndexInDateevents(int index, DateTime value) {
    dateevents.insert(index, value);
  }

  List<String> _BGTEST = [
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/2tq369gzi0mf/428195740_727411762896878_3952389177617707713_n.jpg',
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/9it3k8cj92qi/456519889_931858535634681_5232096964936971543_n.jpg',
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lx2juiwhujj0/368250799_669125878576117_3371658792756169447_n.jpg'
  ];
  List<String> get BGTEST => _BGTEST;
  set BGTEST(List<String> value) {
    _BGTEST = value;
  }

  void addToBGTEST(String value) {
    BGTEST.add(value);
  }

  void removeFromBGTEST(String value) {
    BGTEST.remove(value);
  }

  void removeAtIndexFromBGTEST(int index) {
    BGTEST.removeAt(index);
  }

  void updateBGTESTAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    BGTEST[index] = updateFn(_BGTEST[index]);
  }

  void insertAtIndexInBGTEST(int index, String value) {
    BGTEST.insert(index, value);
  }

  int _indexlistEvents = 0;
  int get indexlistEvents => _indexlistEvents;
  set indexlistEvents(int value) {
    _indexlistEvents = value;
  }

  SupabaseDocRef? _EventSelection;
  SupabaseDocRef? get EventSelection => _EventSelection;
  set EventSelection(SupabaseDocRef? value) {
    _EventSelection = value;
  }

  LatLng? _MapCenter;
  LatLng? get MapCenter => _MapCenter;
  set MapCenter(LatLng? value) {
    _MapCenter = value;
  }

  bool _MoveMap = false;
  bool get MoveMap => _MoveMap;
  set MoveMap(bool value) {
    _MoveMap = value;
  }

  SupabaseDocRef? _VenuseSelection;
  SupabaseDocRef? get VenuseSelection => _VenuseSelection;
  set VenuseSelection(SupabaseDocRef? value) {
    _VenuseSelection = value;
  }

  double _Filterdistance = 10.0;
  double get Filterdistance => _Filterdistance;
  set Filterdistance(double value) {
    _Filterdistance = value;
  }

  List<String> _StyleVenuse = [];
  List<String> get StyleVenuse => _StyleVenuse;
  set StyleVenuse(List<String> value) {
    _StyleVenuse = value;
  }

  void addToStyleVenuse(String value) {
    StyleVenuse.add(value);
  }

  void removeFromStyleVenuse(String value) {
    StyleVenuse.remove(value);
  }

  void removeAtIndexFromStyleVenuse(int index) {
    StyleVenuse.removeAt(index);
  }

  void updateStyleVenuseAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    StyleVenuse[index] = updateFn(_StyleVenuse[index]);
  }

  void insertAtIndexInStyleVenuse(int index, String value) {
    StyleVenuse.insert(index, value);
  }

  List<String> _StyleMusic = [];
  List<String> get StyleMusic => _StyleMusic;
  set StyleMusic(List<String> value) {
    _StyleMusic = value;
  }

  void addToStyleMusic(String value) {
    StyleMusic.add(value);
  }

  void removeFromStyleMusic(String value) {
    StyleMusic.remove(value);
  }

  void removeAtIndexFromStyleMusic(int index) {
    StyleMusic.removeAt(index);
  }

  void updateStyleMusicAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    StyleMusic[index] = updateFn(_StyleMusic[index]);
  }

  void insertAtIndexInStyleMusic(int index, String value) {
    StyleMusic.insert(index, value);
  }

  List<String> _SeatSelect = [];
  List<String> get SeatSelect => _SeatSelect;
  set SeatSelect(List<String> value) {
    _SeatSelect = value;
  }

  void addToSeatSelect(String value) {
    SeatSelect.add(value);
  }

  void removeFromSeatSelect(String value) {
    SeatSelect.remove(value);
  }

  void removeAtIndexFromSeatSelect(int index) {
    SeatSelect.removeAt(index);
  }

  void updateSeatSelectAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    SeatSelect[index] = updateFn(_SeatSelect[index]);
  }

  void insertAtIndexInSeatSelect(int index, String value) {
    SeatSelect.insert(index, value);
  }

  int _Totlepricebooking = 0;
  int get Totlepricebooking => _Totlepricebooking;
  set Totlepricebooking(int value) {
    _Totlepricebooking = value;
  }

  LatLng? _locationsearch;
  LatLng? get locationsearch => _locationsearch;
  set locationsearch(LatLng? value) {
    _locationsearch = value;
  }

  int _ratingreview = 0;
  int get ratingreview => _ratingreview;
  set ratingreview(int value) {
    _ratingreview = value;
  }

  List<String> _datadate = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> get datadate => _datadate;
  set datadate(List<String> value) {
    _datadate = value;
  }

  void addToDatadate(String value) {
    datadate.add(value);
  }

  void removeFromDatadate(String value) {
    datadate.remove(value);
  }

  void removeAtIndexFromDatadate(int index) {
    datadate.removeAt(index);
  }

  void updateDatadateAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    datadate[index] = updateFn(_datadate[index]);
  }

  void insertAtIndexInDatadate(int index, String value) {
    datadate.insert(index, value);
  }

  bool _Next = false;
  bool get Next => _Next;
  set Next(bool value) {
    _Next = value;
  }

  bool _Back = false;
  bool get Back => _Back;
  set Back(bool value) {
    _Back = value;
  }

  bool _Match = false;
  bool get Match => _Match;
  set Match(bool value) {
    _Match = value;
  }

  SupabaseDocRef? _Idcurrent;
  SupabaseDocRef? get Idcurrent => _Idcurrent;
  set Idcurrent(SupabaseDocRef? value) {
    _Idcurrent = value;
  }

  bool _PreMatch = false;
  bool get PreMatch => _PreMatch;
  set PreMatch(bool value) {
    _PreMatch = value;
  }

  bool _PreNext = false;
  bool get PreNext => _PreNext;
  set PreNext(bool value) {
    _PreNext = value;
  }

  bool _logtap = false;
  bool get logtap => _logtap;
  set logtap(bool value) {
    _logtap = value;
  }

  int _IndexScrollMenu = 0;
  int get IndexScrollMenu => _IndexScrollMenu;
  set IndexScrollMenu(int value) {
    _IndexScrollMenu = value;
  }

  List<StoryItemStruct> _storylist = [
    StoryItemStruct.fromSerializableMap(jsonDecode(
        '{\"type\":\"pageVideo\",\"title\":\"Hello World\",\"url\":\"https://firebasestorage.googleapis.com/v0/b/chatblack-6g2orl.appspot.com/o/cms_uploads%2FVenues%2F1734213238003000%2FDownload%20(25).mp4?alt=media&token=bd960803-f07e-4155-9fef-1f91d27c418e\",\"backgroundColor\":\"#0000\",\"caption\":\"Hello World\"}')),
    StoryItemStruct.fromSerializableMap(jsonDecode(
        '{\"type\":\"pageVideo\",\"title\":\"Hello World\",\"url\":\"https://firebasestorage.googleapis.com/v0/b/chatblack-6g2orl.appspot.com/o/cms_uploads%2FVenues%2F1734213238005000%2FDownload%20(26).mp4?alt=media&token=ef6ea896-11ee-423b-a5f9-9a845f1fd389\",\"backgroundColor\":\"#0000\",\"caption\":\"Hello World\"}'))
  ];
  List<StoryItemStruct> get storylist => _storylist;
  set storylist(List<StoryItemStruct> value) {
    _storylist = value;
  }

  void addToStorylist(StoryItemStruct value) {
    storylist.add(value);
  }

  void removeFromStorylist(StoryItemStruct value) {
    storylist.remove(value);
  }

  void removeAtIndexFromStorylist(int index) {
    storylist.removeAt(index);
  }

  void updateStorylistAtIndex(
    int index,
    StoryItemStruct Function(StoryItemStruct) updateFn,
  ) {
    storylist[index] = updateFn(_storylist[index]);
  }

  void insertAtIndexInStorylist(int index, StoryItemStruct value) {
    storylist.insert(index, value);
  }

  final _datachatManager = StreamRequestManager<RoomRecord>();
  Stream<RoomRecord> datachat({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<RoomRecord> Function() requestFn,
  }) =>
      _datachatManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDatachatCache() => _datachatManager.clear();
  void clearDatachatCacheKey(String? uniqueKey) =>
      _datachatManager.clearRequest(uniqueKey);
}
