import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helper/icon_broken.dart';
import 'package:social_app/core/helper/navigator_to.dart';
import 'package:social_app/design/modules/edite_profile.dart';
import 'package:social_app/design/modules/profile_post_card.dart';
import 'package:social_app/design/modules/profile_seved_item.dart';
import 'package:social_app/design/widgets/custom_circle_avatar.dart';
import 'package:social_app/design/widgets/custom_profile_info.dart';
import 'package:social_app/design/widgets/custom_user_name.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainSocialCubit, MainSocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = BlocProvider.of<MainSocialCubit>(context).userModel;
          late var postModel =
              BlocProvider.of<MainSocialCubit>(context).userPosts;
          return NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          height: 250,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          userModel!.cover,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 64,
                                child: customCircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    userModel.image,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Username(
                          mainAxisAlignment: MainAxisAlignment.center,
                          model: userModel,
                        ),
                        Text(
                          userModel.bio,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        ProfileInfo(
                          userPosts: postModel,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  navigatorPushTo(
                                      context, const EditeProfile());
                                },
                                child: const Text(
                                  'Edite Profile',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                navigatorPushTo(context, const EditeProfile());
                              },
                              child: const Icon(
                                IconBroken.Edit,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ])),
                )
              ];
            },
            body: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        IconBroken.Image,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        IconBroken.Play,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        IconBroken.Bookmark,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ProfilePostCard(
                        userPost: postModel,
                      ),
                      const Center(child: Text('No Reels')),
                      const ProfilePostSevedItem()
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
