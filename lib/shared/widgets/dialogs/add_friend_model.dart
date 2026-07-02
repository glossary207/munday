import 'package:munday/core/state/base_model.dart';
import '/backend/backend.dart';
import '/core/utils/app_util.dart';
import 'add_friend_widget.dart' show AddFriendWidget;
import 'package:flutter/material.dart';

class AddFriendModel extends BaseModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
