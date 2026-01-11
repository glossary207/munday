import '/components/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'main_widget.dart' show MainWidget;
import 'package:flutter/material.dart';

class MainModel extends FlutterFlowModel<MainWidget> {
  ///  Local state fields for this page.

  List<String> stylemusic = [];
  void addToStylemusic(String item) => stylemusic.add(item);
  void removeFromStylemusic(String item) => stylemusic.remove(item);
  void removeAtIndexFromStylemusic(int index) => stylemusic.removeAt(index);
  void insertAtIndexInStylemusic(int index, String item) =>
      stylemusic.insert(index, item);
  void updateStylemusicAtIndex(int index, Function(String) updateFn) =>
      stylemusic[index] = updateFn(stylemusic[index]);

  List<dynamic> dataVenues = [];
  void addToDataVenues(dynamic item) => dataVenues.add(item);
  void removeFromDataVenues(dynamic item) => dataVenues.remove(item);
  void removeAtIndexFromDataVenues(int index) => dataVenues.removeAt(index);
  void insertAtIndexInDataVenues(int index, dynamic item) =>
      dataVenues.insert(index, item);
  void updateDataVenuesAtIndex(int index, Function(dynamic) updateFn) =>
      dataVenues[index] = updateFn(dataVenues[index]);

  List<dynamic> dataEvent = [];
  void addToDataEvent(dynamic item) => dataEvent.add(item);
  void removeFromDataEvent(dynamic item) => dataEvent.remove(item);
  void removeAtIndexFromDataEvent(int index) => dataEvent.removeAt(index);
  void insertAtIndexInDataEvent(int index, dynamic item) =>
      dataEvent.insert(index, item);
  void updateDataEventAtIndex(int index, Function(dynamic) updateFn) =>
      dataEvent[index] = updateFn(dataEvent[index]);

  double? wlid;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for navBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
  }
}
