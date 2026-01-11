import '/flutter_flow/flutter_flow_util.dart';
import 'showpeople_noswipe_widget.dart' show ShowpeopleNoswipeWidget;
import 'package:flutter/material.dart';

class ShowpeopleNoswipeModel extends FlutterFlowModel<ShowpeopleNoswipeWidget> {
  ///  Local state fields for this component.

  List<String> photolist = [];
  void addToPhotolist(String item) => photolist.add(item);
  void removeFromPhotolist(String item) => photolist.remove(item);
  void removeAtIndexFromPhotolist(int index) => photolist.removeAt(index);
  void insertAtIndexInPhotolist(int index, String item) =>
      photolist.insert(index, item);
  void updatePhotolistAtIndex(int index, Function(String) updateFn) =>
      photolist[index] = updateFn(photolist[index]);

  SupabaseDocRef? idcurrent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
