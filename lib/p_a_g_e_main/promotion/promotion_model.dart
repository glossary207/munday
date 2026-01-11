import '/components/nav_bar_widget.dart';
import '/components/rowpromotion_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'promotion_widget.dart' show PromotionWidget;
import 'package:flutter/material.dart';

class PromotionModel extends FlutterFlowModel<PromotionWidget> {
  ///  Local state fields for this page.

  int? page = 1;

  bool? selectdate = true;

  bool? mapon = false;

  bool? slide = true;

  bool lovefilter = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // Model for navBar component.
  late NavBarModel navBarModel;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // Model for rowpromotion component.
  late RowpromotionModel rowpromotionModel2;

  @override
  void initState(BuildContext context) {
    rowController = ScrollController();
    columnController = ScrollController();
    navBarModel = createModel(context, () => NavBarModel());
    rowpromotionModel2 = createModel(context, () => RowpromotionModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    rowController?.dispose();
    columnController?.dispose();
    navBarModel.dispose();
    rowpromotionModel2.dispose();
  }
}
