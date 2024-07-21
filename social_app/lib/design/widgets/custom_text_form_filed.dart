import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.onSubmitted,
      required this.validator,
      this.suffixIcon,
      this.prefixIcon,
      required this.label,
      this.secure = false,
      this.onPressed});
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final String Function(String?) validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget label;
  final bool secure;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: secure,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        decoration: InputDecoration(
          label: label,
          suffixIcon: IconButton(onPressed: onPressed, icon: suffixIcon!),
          prefixIcon: prefixIcon,
        ));
  }
}
