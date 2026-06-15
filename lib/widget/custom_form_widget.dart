import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:flutter/material.dart';

// Input Text Field
class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final int maxLines;
  final bool? readOnly;
  final bool alignLabelWithHint;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.readOnly = false,
    this.alignLabelWithHint = true,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly!,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(),
        alignLabelWithHint: alignLabelWithHint,
      ),
    );
  }
}
