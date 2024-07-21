import 'package:flutter/material.dart';
import 'package:social_app/core/helper/icon_broken.dart';

PreferredSizeWidget? customAppBar({
  required BuildContext context,
  Widget? title,
  final List<Widget>? actions,
  final double? elevation,
}) =>
    AppBar(
      title: title,
      elevation: elevation,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left_2)),
      actions: actions,
    );
