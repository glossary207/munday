import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'popupuser_widget.dart' show PopupuserWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class PopupuserModel extends FlutterFlowModel<PopupuserWidget> {
  ///  Local state fields for this component.

  bool showcheers = false;

  List<String> photolist = [];
  void addToPhotolist(String item) => photolist.add(item);
  void removeFromPhotolist(String item) => photolist.remove(item);
  void removeAtIndexFromPhotolist(int index) => photolist.removeAt(index);
  void insertAtIndexInPhotolist(int index, String item) =>
      photolist.insert(index, item);
  void updatePhotolistAtIndex(int index, Function(String) updateFn) =>
      photolist[index] = updateFn(photolist[index]);

  int? check = 0;

  int? swipindex;

  SupabaseDocRef? idcurrent;

  List<UsersRecord> dataload = [];
  void addToDataload(UsersRecord item) => dataload.add(item);
  void removeFromDataload(UsersRecord item) => dataload.remove(item);
  void removeAtIndexFromDataload(int index) => dataload.removeAt(index);
  void insertAtIndexInDataload(int index, UsersRecord item) =>
      dataload.insert(index, item);
  void updateDataloadAtIndex(int index, Function(UsersRecord) updateFn) =>
      dataload[index] = updateFn(dataload[index]);

  int? indexdata;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - dowloaddataswipe] action in popupuser widget.
  List<UsersRecord>? dataswipe;
  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;
  // Stores action output result for [Backend Call - Read Document] action in SwipeableStack widget.
  UsersRecord? update;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
  }

  @override
  void dispose() {}
}
