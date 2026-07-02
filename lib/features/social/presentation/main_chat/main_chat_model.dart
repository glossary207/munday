import 'package:munday/core/state/base_model.dart';
import '/shared/widgets/cards/card33_user_grid_widget.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'main_chat_page.dart' show MainChatWidget;
import 'package:flutter/material.dart';
import '/shared/widgets/cards/card33_user_grid_model.dart';

class MainChatModel extends BaseModel {
  ///  Local state fields for this page.

  List<SupabaseDocRef> roomrefer = [];
  void addToRoomrefer(SupabaseDocRef item) => roomrefer.add(item);
  void removeFromRoomrefer(SupabaseDocRef item) => roomrefer.remove(item);
  void removeAtIndexFromRoomrefer(int index) => roomrefer.removeAt(index);
  void insertAtIndexInRoomrefer(int index, SupabaseDocRef item) =>
      roomrefer.insert(index, item);
  void updateRoomreferAtIndex(int index, Function(SupabaseDocRef) updateFn) =>
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
    card33UserGridModel = Card33UserGridModel()..internalInit(context);
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    card33UserGridModel.dispose();
  }
}
