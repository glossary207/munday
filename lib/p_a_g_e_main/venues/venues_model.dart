import '/components/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'venues_widget.dart' show VenuesWidget;
import 'package:flutter/material.dart';

class VenuesModel extends FlutterFlowModel<VenuesWidget> {
  ///  Local state fields for this page.

  int? filterlocation;

  LatLng? locationmark;

  bool? map;

  bool mapstatus = true;

  bool? slide = true;

  int? page = 1;

  bool lovefilter = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Column widget.
  ScrollController? columnController;
  // Model for navBar component.
  late NavBarModel navBarModel;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Row widget.
  ScrollController? rowController;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    navBarModel = createModel(context, () => NavBarModel());
    rowController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    navBarModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    rowController?.dispose();
  }
}
