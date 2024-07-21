import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app/design/widgets/custom_circle_avatar.dart';

import 'package:social_app/logic/models/user_model.dart';

class UserWhoCreatPost extends StatelessWidget {
  const UserWhoCreatPost(
      {super.key,
      this.bottomLabelText,
      this.image,
      this.networkImage,
      this.radiusOfCircle,
      required this.model});
  final String? bottomLabelText;
  final File? image;
  final String? networkImage;
  final double? radiusOfCircle;
  final UserModel model;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      customCircleAvatar(
        radius: radiusOfCircle ?? 28,
        backgroundImage: image == null
            ? NetworkImage(
                networkImage!,
              )
            : FileImage(image!),
      ),
      const SizedBox(
        width: 15,
      ),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                width: 5,
              ),
              const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 8,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ],
          ),
          Text(bottomLabelText ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 14, height: 1.1)),
        ],
      )),
    ]);
  }
}
