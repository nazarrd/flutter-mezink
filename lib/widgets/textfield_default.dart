import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class TextFieldDefault extends StatelessWidget {
  const TextFieldDefault({
    Key? key,
    this.label,
    this.hintText,
    this.isPassword = false,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.validator,
    this.suffixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    this.infoLabel = const SizedBox(),
    this.isLast = false,
    this.maxLength,
    this.radius,
    this.contentPadding,
    this.hideLabel = false,
    this.fontSize = 14,
    this.readOnly = false,
    this.isRequired = true,
    this.inputFormatters,
    this.minLines,
    this.showCounter,
    this.hintMaxLines = 2,
    this.autofocus = false,
    this.margin = EdgeInsets.zero,
    this.textInputAction = TextInputAction.next,
    this.onTap,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final bool isPassword;
  final bool isLast;
  final bool hideLabel;
  final bool readOnly;
  final bool isRequired;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Widget infoLabel;
  final int? maxLength;
  final int? minLines;
  final int? hintMaxLines;
  final double? radius;
  final double fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool? showCounter;
  final bool autofocus;
  final EdgeInsetsGeometry margin;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(children: [
                Text(
                  label!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Visibility(
                  visible: isRequired,
                  child: const Text('*', style: TextStyle(color: Colors.red)),
                ),
                const Spacer(),
                infoLabel,
              ]),
            ),
          TextFormField(
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            autofocus: autofocus,
            minLines: 1,
            initialValue: initialValue,
            onTap: onTap,
            maxLines: keyboardType == TextInputType.multiline ? null : 1,
            readOnly: readOnly || onTap != null,
            obscureText: isPassword,
            controller: controller,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: keyboardType,
            validator: validator,
            inputFormatters: inputFormatters,
            autovalidateMode: autovalidateMode,
            textInputAction: textInputAction,
            style: TextStyle(fontSize: fontSize),
            maxLength: maxLength,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              counterText: showCounter == true ? null : '',
              hintText: hintText,
              hintMaxLines: hintMaxLines,
              hintStyle: TextStyle(
                fontSize: fontSize,
                color: const Color(0XFF999999),
              ),
              contentPadding:
                  contentPadding ?? const EdgeInsets.fromLTRB(0, 14, 16, 12),
              fillColor: Colors.white,
              border: _textFieldBorder(),
              enabledBorder: _textFieldBorder(),
              focusedBorder: _textFieldBorder(color: AppColors.border),
              prefixIcon: prefixIcon,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: suffixIcon,
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 16),
              suffixIconConstraints: const BoxConstraints(minWidth: 16),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _textFieldBorder({Color color = AppColors.border}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
      borderSide: BorderSide(color: color),
    );
  }
}

class VisibilityWidget extends StatelessWidget {
  const VisibilityWidget(this.hidePass, {super.key});

  final bool hidePass;

  @override
  Widget build(BuildContext context) {
    return Icon(
      hidePass ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
      size: 24,
    );
  }
}
