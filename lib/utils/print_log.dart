import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

printLog(dynamic output) {
  if (kDebugMode) {
    try {
      log(jsonEncode(output));
    } catch (_) {
      final value = output.toString();
      int maxLogSize = 1000;
      for (int i = 0; i <= value.length / maxLogSize; i++) {
        int start = i * maxLogSize;
        int end = (i + 1) * maxLogSize;
        end = end > value.length ? value.length : end;
        print('\x1B[33m${value.substring(start, end)}\x1B[0m');
      }
    }
  }
}
