import 'package:munday/core/state/base_model.dart';
import '/backend/backend.dart';
import '/core/utils/app_util.dart';
import 'block_widget.dart' show BlockWidget;
import 'package:flutter/material.dart';

class BlockModel extends BaseModel {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatRoomsRecord? aaaCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatRoomsRecord? bbbCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatRoomsRecord? aaa;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatRoomsRecord? bbb;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
