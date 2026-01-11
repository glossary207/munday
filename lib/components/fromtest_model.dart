import '/components/table_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'fromtest_widget.dart' show FromtestWidget;
import 'package:flutter/material.dart';

class FromtestModel extends FlutterFlowModel<FromtestWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for table component.
  late TableModel tableModel1;
  // Model for table component.
  late TableModel tableModel2;
  // Model for table component.
  late TableModel tableModel3;
  // Model for table component.
  late TableModel tableModel4;
  // Model for table component.
  late TableModel tableModel5;
  // Model for table component.
  late TableModel tableModel6;
  // Model for table component.
  late TableModel tableModel7;
  // Model for table component.
  late TableModel tableModel8;

  @override
  void initState(BuildContext context) {
    tableModel1 = createModel(context, () => TableModel());
    tableModel2 = createModel(context, () => TableModel());
    tableModel3 = createModel(context, () => TableModel());
    tableModel4 = createModel(context, () => TableModel());
    tableModel5 = createModel(context, () => TableModel());
    tableModel6 = createModel(context, () => TableModel());
    tableModel7 = createModel(context, () => TableModel());
    tableModel8 = createModel(context, () => TableModel());
  }

  @override
  void dispose() {
    tableModel1.dispose();
    tableModel2.dispose();
    tableModel3.dispose();
    tableModel4.dispose();
    tableModel5.dispose();
    tableModel6.dispose();
    tableModel7.dispose();
    tableModel8.dispose();
  }
}
