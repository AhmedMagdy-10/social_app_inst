import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helper/navigator_to.dart';
import 'package:social_app/design/modules/add_post_screen.dart';

import 'package:social_app/design/widgets/custom_post_item.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainSocialCubit, MainSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              BlocProvider.of<MainSocialCubit>(context).userPosts!.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        // customCircleAvatar(
                        //   radius: 25,
                        //   backgroundImage:
                        //    CachedNetworkImage(
                        //     imageUrl: BlocProvider.of<MainSocialCubit>(context)
                        //         .userModel!
                        //         .image,
                        //     placeholder: (context, url) => const Center(
                        //       child: CircularProgressIndicator(),
                        //     ),
                        //   )
                        // ),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                              BlocProvider.of<MainSocialCubit>(context)
                                  .userModel!
                                  .image),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            onTap: () {
                              navigatorPushTo(context, const AddPostView());
                            },
                            style: const TextStyle(height: 0.5),
                            decoration: InputDecoration(
                              // contentPadding: const EdgeInsets.all(15),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'What\'s on your mind..?',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.image,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                            imageUrl:
                                'https://img.freepik.com/free-photo/social-media-concept-composition_23-2150169159.jpg?w=740&t=st=1693182519~exp=1693183119~hmac=224f6e56e7d28091d7d1fd0e6f59ca2aa01e3762e180acb84dca187fffe41410',
                            height: MediaQuery.of(context).size.height * .27,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.wifi_lock_sharp)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with the friends',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PostItem(
                        index: index,
                        postModel: BlocProvider.of<MainSocialCubit>(context)
                            .userPosts![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: BlocProvider.of<MainSocialCubit>(context)
                        .userPosts!
                        .length,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
