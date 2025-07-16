import 'package:flutter/material.dart';
import 'package:work_out_app/config/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry contentPadding;
  final Color? hintTextColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? fillColor;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.hintTextColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    const Color defaultFocusedBorderColor = AppColors.greyColor;
    final Color defaultEnabledBorderColor = Colors.grey.shade400;
    final Color defaultHintColor = Theme.of(context).hintColor;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: onTap,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor ?? defaultHintColor),
        labelText: labelText,
        counterText: "",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? Theme.of(context).scaffoldBackgroundColor,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: enabledBorderColor ?? defaultEnabledBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusedBorderColor ?? defaultFocusedBorderColor, width: 2),
        ),
      ),
    );
  }
}
