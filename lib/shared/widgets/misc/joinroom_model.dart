import 'package:munday/core/state/base_model.dart';
import '/backend/backend.dart';
import '/core/utils/app_util.dart';
import 'joinroom_widget.dart' show JoinroomWidget;
import 'package:flutter/material.dart';

class JoinroomModel extends BaseModel {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<VenuesRecord>? dataV;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
