import 'package:flutter/material.dart';

import '../extension/screen_util.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarDefault(
  String text, {
  String? label,
  void Function()? onPressed,
}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).removeCurrentSnackBar();
  return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      action: label == null
          ? null
          : SnackBarAction(
              label: label,
              disabledTextColor: Colors.transparent,
              onPressed: onPressed ?? () {},
            ),
      content: Text(text),
    ),
  );
}
