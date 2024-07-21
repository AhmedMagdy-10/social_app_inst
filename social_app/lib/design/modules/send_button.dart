import 'package:flutter/material.dart';
import 'package:social_app/core/helper/icon_broken.dart';

class SendButton extends StatelessWidget {
  const SendButton(
      {super.key,
      this.controller,
      this.imageOnPressed,
      this.sendOnPressed,
      this.hintText});
  final TextEditingController? controller;
  final void Function()? imageOnPressed;
  final void Function()? sendOnPressed;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            cursorColor: Colors.blue,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: imageOnPressed,
                  icon: const Icon(
                    IconBroken.Image,
                    color: Colors.blue,
                  )),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              hintText: hintText,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 22,
          child: IconButton(
              onPressed: sendOnPressed,
              icon: const Icon(
                IconBroken.Send,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
