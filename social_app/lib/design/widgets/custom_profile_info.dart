import 'package:flutter/material.dart';
import 'package:social_app/logic/models/post_model.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.userPosts,
  });
  final List<PostModel>? userPosts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  if (userPosts!.isNotEmpty)
                    Text(
                      ' ${userPosts!.length}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  if (userPosts!.isEmpty)
                    Text(
                      '0',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  Text('Posts',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                          )),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text(
                    '274',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text('Photos',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                          )),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text(
                    '10M',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text('Followers',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                          )),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text(
                    '5',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text('Following',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                          )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
