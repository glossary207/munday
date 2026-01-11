import '/backend/backend.dart';
import '/components/rowpromotion_widget.dart';
import '/components/showpeople_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'in_venuse_widget.dart' show InVenuseWidget;
import 'package:flutter/material.dart';

class InVenuseModel extends FlutterFlowModel<InVenuseWidget> {
  ///  Local state fields for this page.

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
    rowpromotionModel = createModel(context, () => RowpromotionModel());
    showpeopleModel = createModel(context, () => ShowpeopleModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    rowpromotionModel.dispose();
    showpeopleModel.dispose();
  }
}
