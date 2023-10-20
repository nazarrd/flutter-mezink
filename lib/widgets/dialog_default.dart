import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

void dialogDefault(BuildContext context,
    {required Widget child, bool barrierDismissible = true}) async {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => ChangeNotifierProvider.value(
      value: context.read<UserProvider>(),
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    ),
  );
}
