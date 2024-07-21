import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/core/helper/icon_broken.dart';
import 'package:social_app/core/helper/navigator_to.dart';
import 'package:social_app/design/modules/add_post_screen.dart';

import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';

class SocialHomePage extends StatefulWidget {
  const SocialHomePage({super.key});

  @override
  State<SocialHomePage> createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainSocialCubit, MainSocialStates>(
      listener: (context, state) {
        if (state is MainSocialAddPostState) {
          navigatorPushTo(context, const AddPostView());
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text(BlocProvider.of<MainSocialCubit>(context).title[
                  BlocProvider.of<MainSocialCubit>(context).currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<MainSocialCubit>(context).changeMode();
                    },
                    icon: BlocProvider.of<MainSocialCubit>(context).isDark!
                        ? const Icon(
                            Icons.wb_sunny,
                            color: Colors.yellow,
                          )
                        : const Icon(Icons.nights_stay_outlined)),
                IconButton(
                    onPressed: () {},
                    icon: const Badge(
                        label: Text('7'),
                        child: Icon(
                          IconBroken.Notification,
                          size: 25,
                        ))),
                IconButton(
                    onPressed: () {}, icon: const Icon(IconBroken.Search)),
              ],
            ),
            body: BlocProvider.of<MainSocialCubit>(context)
                .views[BlocProvider.of<MainSocialCubit>(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  BlocProvider.of<MainSocialCubit>(context).changeViews(index);
                },
                currentIndex:
                    BlocProvider.of<MainSocialCubit>(context).currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Chat), label: 'Chat'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Location), label: 'User'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Profile), label: 'Profile'),
                ]),
          ),
        );
      },
    );
  }
}
