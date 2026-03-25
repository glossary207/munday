import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'reviewgive_widget.dart' show ReviewgiveWidget;
import 'package:flutter/material.dart';

class ReviewgiveModel extends FlutterFlowModel<ReviewgiveWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  VenuesRecord? dataread;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
