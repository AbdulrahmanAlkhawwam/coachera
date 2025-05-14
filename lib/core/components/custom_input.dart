import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

import '../utils/app_image.dart';

class CustomInput extends StatefulWidget {
  final Function()? onTap;
  final Function(dynamic)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final IconButton? suffixIconButton;
  final String? suffixIcon;
  final String? prefixIcon;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final String? hint;
  final String? helperText;
  final bool? isEnabled;
  final bool? isAppear;
  final bool? autoCorrect;

  const CustomInput({
    super.key,
    this.isEnabled,
    this.controller,
    this.hint,
    this.hintStyle,
    this.suffixIconButton,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.helperText,
    this.validator,
    this.autoCorrect,
    this.isAppear = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor;

    iconColor = _isFocused ? context.colors.primary : context.colors.outline;

    return TextFormField(
      cursorHeight: 24,
      focusNode: _focusNode,
      obscureText: widget.isAppear ?? true,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      validator: widget.isEnabled ?? true ? widget.validator : null,
      autocorrect: true,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      enabled: widget.isEnabled,
      cursorColor: context.colors.onSurface,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: _focusNode.hasFocus
            ? context.colors.primaryContainer
            : context.colors.surface,
        hintText: widget.hint,
        hintStyle: !(widget.isEnabled ?? true)
            ? context.textTheme.bodyMedium
                ?.copyWith(color: context.colors.outline)
            : null,
        suffixIcon: widget.suffixIconButton ??
            (widget.suffixIcon == null
                ? null
                : AppImage(
                    widget.suffixIcon,
                    color: iconColor,
                  )),
        prefixIcon: widget.prefixIcon == null
            ? null
            : SizedBox(
                child: widget.prefixIcon == null
                    ? null
                    : AppImage(
                        widget.prefixIcon,
                        color: iconColor,
                      )),
        border: InputBorder.none,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
