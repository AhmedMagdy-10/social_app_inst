import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helper/cache_helper.dart';
import 'package:social_app/core/helper/icon_broken.dart';
import 'package:social_app/design/widgets/custom_app_bar.dart';
import 'package:social_app/design/widgets/custom_circle_avatar.dart';
import 'package:social_app/design/widgets/reused_form_field.dart';

import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';

class EditeProfile extends StatelessWidget {
  const EditeProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var bioController = TextEditingController();

    return BlocConsumer<MainSocialCubit, MainSocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = BlocProvider.of<MainSocialCubit>(context).userModel;
          var profileImage =
              BlocProvider.of<MainSocialCubit>(context).profileImage;
          var coverImage = BlocProvider.of<MainSocialCubit>(context).coverImage;

          nameController.text = userModel!.name;
          bioController.text = userModel.bio;
          phoneController.text = userModel.phone;

          return Scaffold(
              appBar: customAppBar(
                context: context,
                title: const Text(
                  'Edite Profile',
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<MainSocialCubit>(context).updateUser(
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text,
                        );
                        if (coverImage != null) {
                          BlocProvider.of<MainSocialCubit>(context)
                              .uploadCoverImage();
                        }
                        if (profileImage != null) {
                          BlocProvider.of<MainSocialCubit>(context)
                              .uploadProfileImage();
                        }
                      },
                      child: const Text('UpDate',
                          style: TextStyle(
                            fontSize: 18,
                          ))),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    if (state is MainSocialUploadCoverLoadingState)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 300,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: 250,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(
                                                userModel.cover,
                                              )
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<MainSocialCubit>(context)
                                          .getCoverImage();
                                    },
                                    icon: const CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 20,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 64,
                                child: customCircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          userModel.image,
                                        )
                                      : FileImage(profileImage),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<MainSocialCubit>(context)
                                        .getProfileImage();
                                  },
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    reusedTextField(
                      label: const Text('Name'),
                      controller: nameController,
                      prefix: const Icon(IconBroken.User),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    reusedTextField(
                      label: const Text('Bio'),
                      controller: bioController,
                      prefix: const Icon(IconBroken.Bookmark),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    reusedTextField(
                      label: const Text('Phone'),
                      controller: phoneController,
                      prefix: const Icon(Icons.phone),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Log Out',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              CacheHelper.removeData(key: 'uId');
                              CacheHelper.removeData(key: 'isDark');
                              BlocProvider.of<MainSocialCubit>(context).isDark =
                                  null;

                              print('deleted');
                            },
                            icon: const Icon(IconBroken.Logout))
                      ],
                    )
                  ]),
                ),
              ));
        });
  }
}
