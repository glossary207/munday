import 'package:flutter/material.dart';

abstract class BaseModel extends ChangeNotifier {
  bool _isInitialized = false;

  void initState(BuildContext context);

  void internalInit(BuildContext context) {
    if (!_isInitialized) {
      initState(context);
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void maybeDispose() {
    dispose();
  }

  bool updateOnChange = false;
  VoidCallback _updateCallback = () {};

  void onUpdate() {
    if (updateOnChange) {
      _updateCallback();
    }
  }

  BaseModel setOnUpdate({
    bool updateOnChange = false,
    required VoidCallback onUpdate,
  }) {
    _updateCallback = onUpdate;
    this.updateOnChange = updateOnChange;
    return this;
  }

  void updatePage(VoidCallback callback) {
    callback();
    _updateCallback();
    notifyListeners();
  }
}

extension TextValidationExtensions on String? Function(BuildContext, String?)? {
  String? Function(String?)? asValidator(BuildContext context) =>
      this != null ? (val) => this!(context, val) : null;
}
