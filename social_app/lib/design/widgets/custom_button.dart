import 'package:flutter/material.dart';

import '../../constant/primary_color.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final String text;

  const CustomButton(
      {super.key, required this.text, this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color ?? kprimaryColor),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        )),
      ),
    );
  }
}
