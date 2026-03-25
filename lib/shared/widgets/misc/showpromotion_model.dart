import '/flutter_flow/flutter_flow_util.dart';
import 'showpromotion_widget.dart' show ShowpromotionWidget;
import 'package:flutter/material.dart';

class ShowpromotionModel extends FlutterFlowModel<ShowpromotionWidget> {
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
