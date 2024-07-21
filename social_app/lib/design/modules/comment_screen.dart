import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/helper/icon_broken.dart';
import 'package:social_app/core/helper/show_toast_state.dart';

import 'package:social_app/design/modules/commentItem.dart';
import 'package:social_app/design/widgets/custom_app_bar.dart';

import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    return BlocConsumer<MainSocialCubit, MainSocialStates>(
      listener: (context, state) {
        if (state is SocialGetPostCommentSucessState) {
          showToast(text: 'You commented', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        DateTime now = DateTime.now();
        var dateNow = DateFormat('yyyy-MM-dd kk:mm a').format(now);
        var commentImage =
            BlocProvider.of<MainSocialCubit>(context).commentImage;
        var index = ModalRoute.of(context)!.settings.arguments as int;
        return Scaffold(
          appBar: customAppBar(
            context: context,
            title: Row(
              children: [
                const Icon(
                  IconBroken.Heart,
                  size: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('0', style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            actions: [
              Row(
                children: [
                  Text(
                    ' ${BlocProvider.of<MainSocialCubit>(context).commentModel != null ? BlocProvider.of<MainSocialCubit>(context).commentModel!.length : 0}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'comments',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              if (state is SocialUploadCommentImageLoadingState)
                const LinearProgressIndicator(
                  color: Colors.blue,
                ),
              Expanded(
                  child: ListView.builder(
                itemCount: BlocProvider.of<MainSocialCubit>(context)
                    .commentModel!
                    .length,
                itemBuilder: (context, index) => CommentItem(
                  model: BlocProvider.of<MainSocialCubit>(context)
                      .commentModel![index],
                ),
              )),
              if (commentImage != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        image: DecorationImage(
                            image: FileImage(commentImage), fit: BoxFit.cover),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<MainSocialCubit>(context)
                              .removeCommentImage();
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                BlocProvider.of<MainSocialCubit>(context)
                                    .getCommentImage();
                              },
                              icon: const Icon(
                                IconBroken.Image,
                                color: Colors.blue,
                              )),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          hintText: 'Write a comment..',
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 22,
                      child: IconButton(
                          onPressed: () {
                            if (commentImage != null) {
                              BlocProvider.of<MainSocialCubit>(context)
                                  .uploadCommentImage(
                                commentText: commentController.text,
                                dateTime: dateNow,
                                postId:
                                    BlocProvider.of<MainSocialCubit>(context)
                                        .postId[index],
                              );
                            } else {
                              BlocProvider.of<MainSocialCubit>(context)
                                  .createComments(
                                      commentText: commentController.text,
                                      postId: BlocProvider.of<MainSocialCubit>(
                                              context)
                                          .postId[index],
                                      dateTime: dateNow);
                            }
                            commentController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
