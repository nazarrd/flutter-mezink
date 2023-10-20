import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ButtonDefault extends StatelessWidget {
  const ButtonDefault(
    this.text, {
    super.key,
    this.onPressed,
    this.fillColor = Colors.transparent,
    this.textColor = AppColors.primary,
  });

  final void Function()? onPressed;
  final String text;
  final Color fillColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: fillColor,
        side: const BorderSide(color: AppColors.primary),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
