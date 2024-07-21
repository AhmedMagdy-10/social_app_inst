import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/helper/icon_broken.dart';
import 'package:social_app/core/helper/show_toast_state.dart';
import 'package:social_app/design/widgets/custom_user_info.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocConsumer<MainSocialCubit, MainSocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSucessState) {
          showToast(text: 'puplishing now ', state: ToastStates.success);
          Navigator.pop(context);
        } else if (state is SocialCreatePostErrorState) {
          showToast(text: state.error, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        DateTime now = DateTime.now();
        String dateNow = DateFormat('yyyy-MM-dd  kk:mm a').format(now);

        var dateTime = DateTime.now().microsecondsSinceEpoch;

        var userModel = BlocProvider.of<MainSocialCubit>(context).userModel;

        var profileImage =
            BlocProvider.of<MainSocialCubit>(context).profileImage;
        var postImage = BlocProvider.of<MainSocialCubit>(context).postImage;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2)),
            title: const Text('Add post'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (postImage == null) {
                      BlocProvider.of<MainSocialCubit>(context).createPost(
                        dateTime: dateTime,
                        text: textController.text,
                      );
                    } else {
                      BlocProvider.of<MainSocialCubit>(context).uploadPostImage(
                        dateTime: dateTime,
                        text: textController.text,
                      );
                    }
                  },
                  child: const Text(
                    'POST',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    const SizedBox(
                      height: 20,
                    ),
                  UserWhoCreatPost(
                    model: userModel!,
                    image: profileImage,
                    networkImage: userModel.image,
                    bottomLabelText: dateNow,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind..?',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  if (postImage != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            image: DecorationImage(
                                image: FileImage(postImage), fit: BoxFit.cover),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<MainSocialCubit>(context)
                                  .removePostImage();
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20,
                              child: Icon(
                                IconBroken.Close_Square,
                                size: 20,
                              ),
                            )),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<MainSocialCubit>(context)
                                .getPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add Photo',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '# tags',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
