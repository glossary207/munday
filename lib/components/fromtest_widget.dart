import '/components/table_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'fromtest_model.dart';
export 'fromtest_model.dart';

class FromtestWidget extends StatefulWidget {
  const FromtestWidget({super.key});

  @override
  State<FromtestWidget> createState() => _FromtestWidgetState();
}

class _FromtestWidgetState extends State<FromtestWidget> {
  late FromtestModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FromtestModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.55, 0.09),
            child: wrapWithModel(
              model: _model.tableModel1,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: false,
                codename: 'B1',
                tagcolor: Color(0xFF9416CB),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.52, -0.08),
            child: wrapWithModel(
              model: _model.tableModel2,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: true,
                codename: 'A1',
                tagcolor: Color(0xFFFA9207),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.49, 0.35),
            child: wrapWithModel(
              model: _model.tableModel3,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: false,
                codename: 'A3',
                tagcolor: Color(0xFF0171BC),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.51, 0.13),
            child: wrapWithModel(
              model: _model.tableModel4,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: false,
                codename: 'A2',
                tagcolor: Color(0xFF58BB2F),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.35),
            child: wrapWithModel(
              model: _model.tableModel5,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: false,
                codename: 'B3',
                tagcolor: Color(0xFFE42F7D),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.14),
            child: wrapWithModel(
              model: _model.tableModel6,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: false,
                codename: 'B2',
                tagcolor: Color(0xFFFFF600),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.54, -0.09),
            child: wrapWithModel(
              model: _model.tableModel7,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: false,
                codename: 'B1',
                tagcolor: Color(0xFF2929FF),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.02, -0.09),
            child: wrapWithModel(
              model: _model.tableModel8,
              updateCallback: () => safeSetState(() {}),
              child: TableWidget(
                offon: false,
                codename: 'B1',
                tagcolor: Color(0xFFFF0000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
