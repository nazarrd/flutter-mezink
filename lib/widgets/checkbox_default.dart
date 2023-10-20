import 'package:flutter/material.dart';

class CheckBoxDefault extends StatelessWidget {
  const CheckBoxDefault({super.key, this.selected = false, this.onChanged});

  final bool selected;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Checkbox(
        value: selected,
        onChanged: onChanged,
        side: const BorderSide(width: 2),
      ),
    );
  }
}
