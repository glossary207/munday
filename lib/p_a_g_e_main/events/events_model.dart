import '/components/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'events_widget.dart' show EventsWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EventsModel extends FlutterFlowModel<EventsWidget> {
  ///  Local state fields for this page.

  List<String> stylemusic = [];
  void addToStylemusic(String item) => stylemusic.add(item);
  void removeFromStylemusic(String item) => stylemusic.remove(item);
  void removeAtIndexFromStylemusic(int index) => stylemusic.removeAt(index);
  void insertAtIndexInStylemusic(int index, String item) =>
      stylemusic.insert(index, item);
  void updateStylemusicAtIndex(int index, Function(String) updateFn) =>
      stylemusic[index] = updateFn(stylemusic[index]);

  bool mapOn = false;

  bool slide = true;

  int? page = 1;

  bool selectdate = true;

  double? wide;

  bool textinput = false;

  bool lovefilter = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // Model for navBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    rowController = ScrollController();
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    columnController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    rowController?.dispose();
    navBarModel.dispose();
  }
}
