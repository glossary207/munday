import 'package:munday/core/state/base_model.dart';
import '/shared/widgets/layout/nav_bar_widget.dart';
import '/shared/widgets/misc/rowpromotion_widget.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'promotion_page.dart' show PromotionWidget;
import 'package:flutter/material.dart';
import '/shared/widgets/layout/nav_bar_model.dart';
import '/shared/widgets/misc/rowpromotion_model.dart';

class PromotionModel extends BaseModel {
  ///  Local state fields for this page.

  int? page = 1;

  bool? selectdate = false;

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
    navBarModel = NavBarModel()..internalInit(context);
    rowpromotionModel2 = RowpromotionModel()..internalInit(context);
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
