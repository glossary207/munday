import '/components/showpeople_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sharepage_widget.dart' show SharepageWidget;
import 'package:flutter/material.dart';

class SharepageModel extends FlutterFlowModel<SharepageWidget> {
  ///  Local state fields for this page.

  bool? zoom;

  bool? play = false;

  LatLng? location;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for showpeople component.
  late ShowpeopleModel showpeopleModel;

  @override
  void initState(BuildContext context) {
    showpeopleModel = createModel(context, () => ShowpeopleModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    showpeopleModel.dispose();
  }
}
