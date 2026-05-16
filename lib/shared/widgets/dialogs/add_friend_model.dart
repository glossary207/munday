import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_friend_widget.dart' show AddFriendWidget;
import 'package:flutter/material.dart';

class AddFriendModel extends FlutterFlowModel<AddFriendWidget> {
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
