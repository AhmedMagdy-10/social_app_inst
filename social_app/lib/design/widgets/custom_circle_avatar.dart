import 'package:flutter/material.dart';

Widget customCircleAvatar({
  required double radius,
  required var backgroundImage,
}) =>
    Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: backgroundImage,
        ),
      ],
    );
