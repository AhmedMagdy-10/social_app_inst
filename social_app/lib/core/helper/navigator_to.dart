import 'package:flutter/material.dart';

void navigatorPushTo(BuildContext context, pageRoute) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageRoute,
      ));
}
