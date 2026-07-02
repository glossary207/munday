import 'package:munday/core/state/base_model.dart';
import '/shared/widgets/cards/showpeople_widget.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'share_page.dart' show SharePage;
import 'package:flutter/material.dart';
import 'package:munday/shared/widgets/cards/showpeople_model.dart';

class SharepageModel extends BaseModel {
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
    showpeopleModel = ShowpeopleModel()..internalInit(context);
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    showpeopleModel.dispose();
  }
}
