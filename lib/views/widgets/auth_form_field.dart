import 'package:flutter/material.dart';
import 'package:yumm/views/widgets/app_text_field.dart';
import 'package:yumm/constants.dart';

class AuthFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const AuthFormField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label.toUpperCase(),
      controller: controller,
      hint: hint,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.6),
      labelColor: AppColors.primary,
      filled: true,
      fillColor: const Color(0xFFF5DFAE),
    );
  }
}
