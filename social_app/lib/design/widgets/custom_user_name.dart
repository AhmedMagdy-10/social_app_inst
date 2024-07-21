import 'package:flutter/material.dart';

import 'package:social_app/logic/models/user_model.dart';

class Username extends StatelessWidget {
  const Username({super.key, required this.mainAxisAlignment, this.model});

  final MainAxisAlignment mainAxisAlignment;
  final UserModel? model;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          model!.name,
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
    );
  }
}
