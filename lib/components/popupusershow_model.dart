import '/flutter_flow/flutter_flow_util.dart';
import 'popupusershow_widget.dart' show PopupusershowWidget;
import 'package:flutter/material.dart';

class PopupusershowModel extends FlutterFlowModel<PopupusershowWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
