import 'package:flutter/material.dart';

class CheckBoxDefault extends StatelessWidget {
  const CheckBoxDefault({super.key, this.selected = false});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Checkbox(
        value: selected,
        onChanged: (value) {},
        side: const BorderSide(width: 2),
      ),
    );
  }
}
