import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final IconData? suffixIconButton;
  final VoidCallback? suffixFunctionButton;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextStyle? hintStyle;
  final String? hint;
  final String? helperText;
  final bool isEnabled;
  final bool obscureText;
  final bool autoCorrect;
  final List<String>? autoFillHints;

  const CustomInput({
    super.key,
    this.onTap,
    this.onChanged,
    this.validator,
    this.controller,
    this.suffixIconButton,
    this.suffixFunctionButton,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.hintStyle,
    this.hint,
    this.helperText,
    this.isEnabled = true,
    this.obscureText = false,
    this.autoCorrect = true,
    this.autoFillHints,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() => _isFocused = _focusNode.hasFocus);
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget? _buildSuffixIcon(Color iconColor) {
    return widget.suffixIconButton != null
        ? IconButton(
            onPressed: widget.suffixFunctionButton,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide.none,
                ),
              ),
            ),
            icon: Icon(widget.suffixIconButton, color: iconColor),
          )
        : widget.suffixIcon != null
            ? Icon(widget.suffixIcon, color: iconColor)
            : null;
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        _isFocused ? context.colors.primary : context.colors.outline;

    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      validator: widget.isEnabled ? widget.validator : null,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      autocorrect: widget.autoCorrect,
      enabled: widget.isEnabled,
      autofillHints: widget.autoFillHints,
      cursorColor: context.colors.onSurface,
      cursorHeight: 24,
      decoration: InputDecoration(
        filled: true,
        fillColor: _isFocused
            ? context.colors.primaryContainer
            : context.colors.surface,
        hintText: widget.hint,
        hintStyle: widget.isEnabled
            ? widget.hintStyle
            : context.textTheme.bodyMedium?.copyWith(
                color: context.colors.outline,
              ),
        helperText: widget.helperText,
        suffixIcon: _buildSuffixIcon(iconColor),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: iconColor)
            : null,
        border: InputBorder.none,
      ),
    );
  }
}