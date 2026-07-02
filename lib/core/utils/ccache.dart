// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/core/utils/app_util.dart';
import '/core/utils/index.dart'; // Imports other custom actions
import '/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:munday/core/theme/theme.dart';

Future ccache() async {
  // Add your function code here!
  var cacheManager = DefaultCacheManager();
  await cacheManager.emptyCache();
}
