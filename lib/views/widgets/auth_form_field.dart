import 'package:flutter/material.dart';
import 'package:yumm/views/widgets/app_text_field.dart';

class AuthFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const AuthFormField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      controller: controller,
      hint: hint,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      suffixIcon: suffixIcon,
      labelColor: Colors.white,
    );
  }
}
