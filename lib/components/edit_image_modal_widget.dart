import '/auth/supabase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'edit_image_modal_model.dart';
export 'edit_image_modal_model.dart';

class EditImageModalWidget extends StatefulWidget {
  const EditImageModalWidget({
    super.key,
    this.croppShape,
    required this.cropPercentage,
    this.selectedImage,
    required this.direct,
  });

  final String? croppShape;
  final double? cropPercentage;
  final FFUploadedFile? selectedImage;
  final int? direct;

  @override
  State<EditImageModalWidget> createState() => _EditImageModalWidgetState();
}

class _EditImageModalWidgetState extends State<EditImageModalWidget> {
  late EditImageModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditImageModalModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        custom_widgets.CropImageViewWidget(
          width: double.infinity,
          height: double.infinity,
          cropShape: widget.croppShape!,
          cropPercentage: widget.cropPercentage!,
          resetText: 'Reset',
          zoomText: 'Zoom',
          rotateText: 'Rotate',
          saveText: 'Save  Image',
          cancelText: 'Cancel',
          originalImage: widget.selectedImage!,
          onCancel: () async {
            await actions.clearCroppImageShareCache();
            Navigator.pop(context);
          },
          onCrop: () async {
            _model.croppedImageUrl = await actions.uploadCropperImageToSupabase(
              currentUserUid,
            );
            await actions.clearCroppImageShareCache();
            Navigator.pop(context, _model.croppedImageUrl);

            safeSetState(() {});
          },
        ),
        Align(
          alignment: AlignmentDirectional(1.0, -1.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 30.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () async {
                await actions.clearCroppImageShareCache();
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
