import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import '/core/utils/index.dart' as actions;
import '/shared/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'edit_image_modal_model.dart';
export 'edit_image_modal_model.dart';

class EditImageModalWidget extends ConsumerStatefulWidget {
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
  ConsumerState<EditImageModalWidget> createState() =>
      _EditImageModalWidgetState();
}

class _EditImageModalWidgetState extends ConsumerState<EditImageModalWidget> {
  late EditImageModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = EditImageModalModel()..internalInit(context);

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
            if (!mounted) {
              return;
            }
            if (!(_model.croppedImageUrl?.isNotEmpty ?? false)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'อัปโหลดรูปไม่สำเร็จ กรุณาตรวจสอบสิทธิ์ Storage แล้วลองใหม่',
                  ),
                ),
              );
              Navigator.pop(context);
              return;
            }
            Navigator.pop(context, _model.croppedImageUrl);

            safeSetState(() {});
          },
        ),
        Align(
          alignment: AlignmentDirectional(1.0, -1.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 30.0, 0.0),
            child: MundayIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(Icons.close_rounded, color: Colors.white, size: 30.0),
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
