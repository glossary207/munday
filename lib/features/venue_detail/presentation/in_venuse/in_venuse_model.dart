import 'dart:math' as math;

import "package:munday/shared/widgets/cards/showpeople_model.dart";

import 'package:munday/core/state/base_model.dart';
import '/backend/backend.dart';
import '/shared/widgets/misc/rowpromotion_widget.dart';
import '/shared/widgets/misc/rowpromotion_model.dart';
import '/shared/widgets/cards/showpeople_widget.dart';
import '/core/utils/app_util.dart';
import 'package:flutter/material.dart';

const _kInVenuseDemoVenueCoverVideoPaths = [
  'assets/videos/venue_cover.mp4',
  'assets/videos/video3.mp4',
];

final _inVenuseDemoVideoRandom = math.Random();

class InVenuseModel extends BaseModel {
  ///  Local state fields for this page.

  late String demoVenueCoverVideoPath;

  bool? zoom;

  bool? play = false;

  LatLng? location;

  bool? ononvite = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for rowpromotion component.
  late RowpromotionModel rowpromotionModel;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<VenuesRecord>? dataVV;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<VenuesRecord>? dataVVV;
  // Model for showpeople component.
  late ShowpeopleModel showpeopleModel;
  // Stores action output result for [Backend Call - Create Document] action in containerBody widget.
  GroupInviteRecord? idRefGroup;

  @override
  void initState(BuildContext context) {
    demoVenueCoverVideoPath =
        _kInVenuseDemoVenueCoverVideoPaths[_inVenuseDemoVideoRandom.nextInt(
          _kInVenuseDemoVenueCoverVideoPaths.length,
        )];
    rowpromotionModel = RowpromotionModel()..internalInit(context);
    showpeopleModel = ShowpeopleModel()..internalInit(context);
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    rowpromotionModel.dispose();
    showpeopleModel.dispose();
  }
}
