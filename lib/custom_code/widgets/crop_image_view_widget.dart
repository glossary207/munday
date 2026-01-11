// Automatic FlutterFlow imports
import '/backend/backend.dart';
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;
import "package:f_f_story_view_live_zhm3f3/backend/schema/enums/enums.dart"
    as f_f_story_view_live_zhm3f3_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:munday/custom_code/actions/clear_cropp_image_share_cache.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:custom_image_crop/custom_image_crop.dart';

class CropImageViewWidget extends StatefulWidget {
  const CropImageViewWidget({
    Key? key,
    this.width,
    this.height,
    required this.originalImage,
    required this.cropShape,
    required this.cropPercentage,
    required this.resetText,
    required this.zoomText,
    required this.rotateText,
    required this.saveText,
    required this.cancelText,
    required this.onCancel,
    required this.onCrop,
  }) : super(key: key);

  final double? width;
  final double? height;
  final FFUploadedFile originalImage;
  final String cropShape;
  final double cropPercentage;
  final String resetText;
  final String zoomText;
  final String rotateText;
  final String saveText;
  final String cancelText;
  final Future<dynamic> Function() onCancel;
  final Future<dynamic> Function() onCrop;

  @override
  _CropImageViewWidgetState createState() => _CropImageViewWidgetState();
}

class _CropImageViewWidgetState extends State<CropImageViewWidget> {
  late GlobalKey _croperKey;
  late CustomImageCropController _croppController;
  late CropImageWidgetShareState _shareState;
  late CustomCropShape _customCropShape;

  @override
  void initState() {
    super.initState();
    _croperKey = GlobalKey(debugLabel: 'myCropImageWidget');
    _croppController = CustomImageCropController();
    _shareState = CropImageWidgetShareState();
    _customCropShape = widget.cropShape.toLowerCase() == 'circle'
        ? CustomCropShape.Circle
        : CustomCropShape.Square;
  }

  @override
  void dispose() {
    _croppController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: ClipRRect(
                child: CustomImageCrop(
                  canRotate: false,
                  key: _croperKey,
                  cropController: _croppController,
                  image: MemoryImage(widget.originalImage.bytes!),
                  shape: _customCropShape,
                  cropPercentage: _getCropPercentage(),
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () async {
                      await widget.onCancel.call();
                    },
                    text: widget.cancelText,
                    options: FFButtonOptions(
                      height: 44,
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                      color: Colors.transparent,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Inter',
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 32, 32, 32),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () async {
                      await _cropImage();
                    },
                    text: widget.saveText,
                    options: FFButtonOptions(
                      height: 44,
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                      color: const Color.fromARGB(255, 32, 32, 32),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Inter',
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getCropPercentage() {
    if (widget.cropPercentage < 0) return 0.1;
    if (widget.cropPercentage > 1) return 1.0;
    return widget.cropPercentage;
  }

  Future<void> _cropImage() async {
    final croppedImage = await _croppController.onCropImage();
    if (croppedImage == null) return;

    // ไม่ใส่ width/height (optional) เพื่อหลีกเลี่ยง error และไม่ต้องเดา
    _shareState.croppedImageData = FFUploadedFile(
      name: widget.originalImage.name,
      bytes: croppedImage.bytes,
    );

    await widget.onCrop.call();
  }
}
