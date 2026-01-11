import '/flutter_flow/flutter_flow_util.dart';
import 'item_widget.dart' show ItemWidget;
import 'package:flutter/material.dart';

class ItemModel extends FlutterFlowModel<ItemWidget> {
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

  ///  State fields for stateful widgets in this component.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
