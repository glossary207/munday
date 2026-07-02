import 'package:munday/core/state/base_model.dart';
import '/core/utils/app_util.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'ticket_page.dart' show TicketWidget;
import 'package:flutter/material.dart';

class TicketModel extends BaseModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
