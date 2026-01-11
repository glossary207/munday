import '/backend/backend.dart';
import '/components/card33_user_grid_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'chats_widget.dart' show ChatsWidget;
import 'package:flutter/material.dart';

class ChatsModel extends FlutterFlowModel<ChatsWidget> {
  ///  Local state fields for this page.

  int? numtext = 0;

  List<SupabaseDocRef> pair = [];
  void addToPair(SupabaseDocRef item) => pair.add(item);
  void removeFromPair(SupabaseDocRef item) => pair.remove(item);
  void removeAtIndexFromPair(int index) => pair.removeAt(index);
  void insertAtIndexInPair(int index, SupabaseDocRef item) =>
      pair.insert(index, item);
  void updatePairAtIndex(int index, Function(SupabaseDocRef) updateFn) =>
      pair[index] = updateFn(pair[index]);

  bool timecheckread = false;

  bool lockchatt = false;

  String name = 'ไม่ระบุ';

  bool gift = false;

  ///  State fields for stateful widgets in this page.

  RoomRecord? stackPreviousSnapshot;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadData1ir = false;
  FFUploadedFile uploadedLocalFile_uploadData1ir =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadData1ir = '';

  // Model for Card33UserGrid component.
  late Card33UserGridModel card33UserGridModel;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    listViewController = ScrollController();
    card33UserGridModel = createModel(context, () => Card33UserGridModel());
  }

  @override
  void dispose() {
    columnController?.dispose();
    listViewController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    card33UserGridModel.dispose();
  }
}
