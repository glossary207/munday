import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'map_pin2_model.dart';
export 'map_pin2_model.dart';

class MapPin2Widget extends StatefulWidget {
  const MapPin2Widget({
    super.key,
    required this.post,
  });

  final VenuesRecord? post;

  @override
  State<MapPin2Widget> createState() => _MapPin2WidgetState();
}

class _MapPin2WidgetState extends State<MapPin2Widget> {
  late MapPin2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapPin2Model());

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
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(
            widget.post!.logo,
          ).image,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
