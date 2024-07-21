import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helper/collect_time.dart';

import 'package:social_app/core/helper/icon_broken.dart';

import 'package:social_app/design/widgets/custom_circle_avatar.dart';
import 'package:social_app/design/widgets/custom_linear.dart';

import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';
import 'package:social_app/logic/models/post_model.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.postModel,
    required this.index,
  });

  final PostModel? postModel;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream =
        BlocProvider.of<MainSocialCubit>(context).streamLike(
            postId: BlocProvider.of<MainSocialCubit>(context).postId[index!]);

    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (context, snapshot) {
          Widget iconLike() {
            if (snapshot.hasData) {
              if (index != null && index! < snapshot.data!.docs.length) {
                if (snapshot.data!.docs[index!].id ==
                    BlocProvider.of<MainSocialCubit>(context).userModel!.uId) {
                  BlocProvider.of<MainSocialCubit>(context).isLike = true;
                  const Icon(Icons.favorite, color: Colors.red);
                }
              }
            }

            return Icon(
              BlocProvider.of<MainSocialCubit>(context).isLike
                  ? Icons.favorite
                  : IconBroken.Heart,
              color: Colors.red,
            );
          }

          // if (BlocProvider.of<MainSocialCubit>(context).isLike == false) {
          //   BlocProvider.of<MainSocialCubit>(context).deleteLike(
          //       postId:
          //           BlocProvider.of<MainSocialCubit>(context).postId[index!]);
          // }

          if (snapshot.hasData) {
            return BlocConsumer<MainSocialCubit, MainSocialStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            customCircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage(postModel!.image)),
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
                                      postModel!.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 7,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(getTimeFromNow(postModel!.dateTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 14, height: 1.1)),
                              ],
                            )),
                          ]),

                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: customLinear()),
                          Text(
                            postModel!.text,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 15),
                          ),

                          // SizedBox(
                          //   width: double.infinity,
                          //   child: Wrap(
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 5),
                          //         child: SizedBox(
                          //           height: 25,
                          //           child: MaterialButton(
                          //             onPressed: () {},
                          //             minWidth: 1,
                          //             padding: EdgeInsets.zero,
                          //             child: const Text(
                          //               '#Software',
                          //               style: TextStyle(
                          //                 color: Colors.blue,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 5),
                          //         child: SizedBox(
                          //           height: 25,
                          //           child: MaterialButton(
                          //             onPressed: () {},
                          //             minWidth: 1,
                          //             padding: EdgeInsets.zero,
                          //             child: const Text(
                          //               '#Software-developer',
                          //               style: TextStyle(
                          //                 color: Colors.blue,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          if (postModel!.postImage != '')
                            Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  height: 300,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: postModel!.postImage,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              BlocProvider.of<MainSocialCubit>(
                                                      context)
                                                  .like();

                                              BlocProvider.of<MainSocialCubit>(
                                                      context)
                                                  .getLikes(
                                                      postId: BlocProvider.of<
                                                                  MainSocialCubit>(
                                                              context)
                                                          .postId[index!]);
                                            },
                                            child: iconLike()),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        if (BlocProvider.of<MainSocialCubit>(
                                                context)
                                            .isLike)
                                          if (snapshot.hasData)
                                            Text(
                                                '${snapshot.data!.docs.length}'),
                                        if (!snapshot.hasData) const Text(''),
                                      ],
                                    ),
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: BlocProvider.of<MainSocialCubit>(
                                            context)
                                        .streamComment(
                                            postId: BlocProvider.of<
                                                    MainSocialCubit>(context)
                                                .postId[index!]),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, 'commentScreen',
                                                  arguments: index);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  IconBroken.Chat,
                                                  color: Colors.amber,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                if (snapshot.hasData)
                                                  Text(
                                                      '${snapshot.data!.docs.length}'),
                                                if (snapshot.data!.docs.isEmpty)
                                                  const Text(''),
                                              ],
                                            ),
                                          ),
                                        );
                                        //
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                          customLinear(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'commentScreen',
                                        arguments: index);
                                  },
                                  child: Row(
                                    children: [
                                      customCircleAvatar(
                                          backgroundImage:
                                              NetworkImage(postModel!.image),
                                          radius: 24),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text('write comment...',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize: 15, height: 1.1)),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Icon(
                                      IconBroken.Heart,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Like',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
