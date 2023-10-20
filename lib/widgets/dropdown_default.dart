import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class DropdownDefault extends StatelessWidget {
  const DropdownDefault({
    super.key,
    required this.data,
    required this.hintText,
    this.selected,
    this.onChanged,
    this.label,
    this.width,
    this.margin = EdgeInsets.zero,
    this.isRequired = true,
    this.hintStyle,
  });

  final List<String> data;
  final String hintText;
  final String? selected;
  final String? label;
  final double? width;
  final EdgeInsetsGeometry margin;
  final void Function(String?)? onChanged;
  final bool isRequired;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Row(children: [
              Text(
                label!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Visibility(
                visible: isRequired,
                child: const Text('*', style: TextStyle(color: Colors.red)),
              ),
            ]),
          Container(
            height: 40,
            width: width,
            margin: EdgeInsets.only(top: label != null ? 4 : 0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                padding: const EdgeInsets.only(left: 10, right: 6),
                value: selected,
                icon: const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(Icons.arrow_drop_down),
                ),
                hint: Text(
                  hintText,
                  style: hintStyle ??
                      const TextStyle(
                        fontSize: 14,
                        height: 1.75,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                onChanged: onChanged,
                items: data.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.75,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
