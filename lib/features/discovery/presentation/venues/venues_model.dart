import 'package:munday/core/state/base_model.dart';
import '/shared/widgets/layout/nav_bar_widget.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'venues_page.dart' show VenuesWidget;
import 'package:flutter/material.dart';
import '/shared/widgets/layout/nav_bar_model.dart';

class VenuesModel extends BaseModel {
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
    navBarModel = NavBarModel()..internalInit(context);
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
