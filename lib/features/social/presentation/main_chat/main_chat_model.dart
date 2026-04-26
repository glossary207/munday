import '/shared/widgets/cards/card33_user_grid_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'main_chat_widget.dart' show MainChatWidget;
import 'package:flutter/material.dart';

class MainChatModel extends FlutterFlowModel<MainChatWidget> {
  ///  Local state fields for this page.

  List<SupabaseDocRef> roomrefer = [];
  void addToRoomrefer(SupabaseDocRef item) => roomrefer.add(item);
  void removeFromRoomrefer(SupabaseDocRef item) => roomrefer.remove(item);
  void removeAtIndexFromRoomrefer(int index) => roomrefer.removeAt(index);
  void insertAtIndexInRoomrefer(int index, SupabaseDocRef item) =>
      roomrefer.insert(index, item);
  void updateRoomreferAtIndex(
          int index, Function(SupabaseDocRef) updateFn) =>
      roomrefer[index] = updateFn(roomrefer[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for Card33UserGrid component.
  late Card33UserGridModel card33UserGridModel;

  @override
  void initState(BuildContext context) {
    card33UserGridModel = createModel(context, () => Card33UserGridModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    card33UserGridModel.dispose();
  }
}
