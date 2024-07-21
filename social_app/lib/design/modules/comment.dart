import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/design/widgets/custom_circle_avatar.dart';

class Comments extends StatelessWidget {
  const Comments({super.key, this.index});

  final int? index;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customCircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(''),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '',
                    maxLines: 7,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 17),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                        bottom: 15,
                        top: 5,
                      ),
                      child: SizedBox(
                        height: 120,
                        width: 190,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: '',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              fit: BoxFit.cover,
                            )),
                      )),
                  Text(
                    '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 14, height: 1.1),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
