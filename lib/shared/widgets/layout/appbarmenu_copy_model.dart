import 'package:munday/core/state/base_model.dart';
import '/shared/widgets/layout/header_appbar_menu_widget.dart';
import '/shared/widgets/layout/header_appbar_menu_model.dart';
import '/core/utils/app_util.dart';
import 'appbarmenu_copy_widget.dart' show AppbarmenuCopyWidget;
import 'package:flutter/material.dart';

class AppbarmenuCopyModel extends BaseModel {
  ///  State fields for stateful widgets in this component.

  // Model for headerAppbarMenu component.
  late HeaderAppbarMenuModel headerAppbarMenuModel;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    headerAppbarMenuModel = HeaderAppbarMenuModel()..internalInit(context);
  }

  @override
  void dispose() {
    headerAppbarMenuModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
