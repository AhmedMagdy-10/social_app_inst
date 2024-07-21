import 'package:flutter/material.dart';

Widget reusedTextField({
  required Widget? label,
  required TextEditingController? controller,
  bool secure = false,
  IconData? suffixIcon,
  Widget? prefix,
  Function(String)? onChanged,
  Function()? suffixPressed,
  Function(String)? onSubmitted,
  String? text,
}) =>
    TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmitted,
        validator: (data) {
          if (data!.isEmpty) {
            return text ?? 'feild is required';
          } else {
            return null;
          }
        },
        obscureText: secure,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixPressed,
          ),
          label: label,
          prefixIcon: prefix,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(12)),
        ));
