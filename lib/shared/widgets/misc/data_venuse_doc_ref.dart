// Automatic FlutterFlow imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart'; // Imports other custom widgets
import '/core/utils/index.dart'; // Imports custom actions
import '/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
import 'package:munday/core/theme/theme.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class DataVenuseDocRef extends ConsumerStatefulWidget {
  const DataVenuseDocRef({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  ConsumerState<DataVenuseDocRef> createState() => _DataVenuseDocRefState();
}

class _DataVenuseDocRefState extends ConsumerState<DataVenuseDocRef> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
