import 'package:munday/core/state/base_model.dart';
import '/core/utils/app_util.dart';
import 'edit_image_modal_widget.dart' show EditImageModalWidget;
import 'package:flutter/material.dart';

class EditImageModalModel extends BaseModel {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - uploadCropperImageToSupabase] action in CropImageViewWidget widget.
  String? croppedImageUrl;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
