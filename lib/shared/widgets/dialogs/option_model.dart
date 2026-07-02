import 'package:munday/core/state/base_model.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import '/core/utils/app_util.dart';
import 'option_widget.dart' show OptionWidget;
import 'package:flutter/material.dart';

class OptionModel extends BaseModel {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (createcheckoutone)] action in Container widget.
  ApiCallResponse? re1;
  // Stores action output result for [Backend Call - API (createcheckoutone)] action in Container widget.
  ApiCallResponse? re11;
  // Stores action output result for [Backend Call - API (createcheckoutone)] action in Container widget.
  ApiCallResponse? re2;
  // Stores action output result for [Backend Call - API (createcheckoutone)] action in Container widget.
  ApiCallResponse? re22;
  // Stores action output result for [Backend Call - API (createcheckoutone)] action in Container widget.
  ApiCallResponse? re3;
  // Stores action output result for [Backend Call - API (createcheckoutone)] action in Container widget.
  ApiCallResponse? re33;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
