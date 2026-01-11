import '/backend/api_requests/api_calls.dart';
import '/components/card33_user_grid_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  int? textnonread;

  List<SupabaseDocRef> search = [];
  void addToSearch(SupabaseDocRef item) => search.add(item);
  void removeFromSearch(SupabaseDocRef item) => search.remove(item);
  void removeAtIndexFromSearch(int index) => search.removeAt(index);
  void insertAtIndexInSearch(int index, SupabaseDocRef item) =>
      search.insert(index, item);
  void updateSearchAtIndex(int index, Function(SupabaseDocRef) updateFn) =>
      search[index] = updateFn(search[index]);

  bool showAd = true;

  bool showEnd = false;

  List<String> namesearch = [''];
  void addToNamesearch(String item) => namesearch.add(item);
  void removeFromNamesearch(String item) => namesearch.remove(item);
  void removeAtIndexFromNamesearch(int index) => namesearch.removeAt(index);
  void insertAtIndexInNamesearch(int index, String item) =>
      namesearch.insert(index, item);
  void updateNamesearchAtIndex(int index, Function(String) updateFn) =>
      namesearch[index] = updateFn(namesearch[index]);

  bool searchsow = false;

  List<SupabaseDocRef> cheersshow = [];
  void addToCheersshow(SupabaseDocRef item) => cheersshow.add(item);
  void removeFromCheersshow(SupabaseDocRef item) => cheersshow.remove(item);
  void removeAtIndexFromCheersshow(int index) => cheersshow.removeAt(index);
  void insertAtIndexInCheersshow(int index, SupabaseDocRef item) =>
      cheersshow.insert(index, item);
  void updateCheersshowAtIndex(
          int index, Function(SupabaseDocRef) updateFn) =>
      cheersshow[index] = updateFn(cheersshow[index]);

  int? numshow;

  List<bool> openroom = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  void addToOpenroom(bool item) => openroom.add(item);
  void removeFromOpenroom(bool item) => openroom.remove(item);
  void removeAtIndexFromOpenroom(int index) => openroom.removeAt(index);
  void insertAtIndexInOpenroom(int index, bool item) =>
      openroom.insert(index, item);
  void updateOpenroomAtIndex(int index, Function(bool) updateFn) =>
      openroom[index] = updateFn(openroom[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (createcheckoutone)] action in home widget.
  ApiCallResponse? apiResult3xtone;
  // Stores action output result for [Backend Call - API (createcheckouttwo)] action in home widget.
  ApiCallResponse? apiResult3xttwo;
  // Stores action output result for [Backend Call - API (createcheckoutthree)] action in home widget.
  ApiCallResponse? apiResult3xtthree;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for CountController widget.
  int? countControllerValue;
  // Model for Card33UserGrid component.
  late Card33UserGridModel card33UserGridModel;

  @override
  void initState(BuildContext context) {
    card33UserGridModel = createModel(context, () => Card33UserGridModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    card33UserGridModel.dispose();
  }
}
