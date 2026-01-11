import '/components/card33_user_grid_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  Local state fields for this page.

  bool editcaption = false;

  bool editname = false;

  bool editphoto = true;

  bool datachange = false;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataMainEditpopup = false;
  FFUploadedFile uploadedLocalFile_uploadDataMainEditpopup =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Bottom Sheet - EditImageModal] action in Container widget.
  String? singleCroppedImage1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  bool isDataUploading_uploadData1popup = false;
  FFUploadedFile uploadedLocalFile_uploadData1popup =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Bottom Sheet - EditImageModal] action in Container widget.
  String? singleCroppedImage2;
  bool isDataUploading_uploadData2popup = false;
  FFUploadedFile uploadedLocalFile_uploadData2popup =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Bottom Sheet - EditImageModal] action in Container widget.
  String? singleCroppedImage3;
  bool isDataUploading_uploadData3popup = false;
  FFUploadedFile uploadedLocalFile_uploadData3popup =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Bottom Sheet - EditImageModal] action in Container widget.
  String? singleCroppedImage4;
  bool isDataUploading_uploadData4popup = false;
  FFUploadedFile uploadedLocalFile_uploadData4popup =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Bottom Sheet - EditImageModal] action in Container widget.
  String? singleCroppedImage5;
  bool isDataUploading_uploadData5popup = false;
  FFUploadedFile uploadedLocalFile_uploadData5popup =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Bottom Sheet - EditImageModal] action in Container widget.
  String? singleCroppedImage6;
  bool isDataUploading_uploadData6popup = false;
  FFUploadedFile uploadedLocalFile_uploadData6popup =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Bottom Sheet - EditImageModal] action in Container widget.
  String? singleCroppedImage7;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // Model for Card33UserGrid component.
  late Card33UserGridModel card33UserGridModel;

  @override
  void initState(BuildContext context) {
    card33UserGridModel = createModel(context, () => Card33UserGridModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    card33UserGridModel.dispose();
  }
}
