import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/helper/icon_broken.dart';
import 'package:social_app/design/modules/send_button.dart';
import 'package:social_app/design/widgets/custom_app_bar.dart';
import 'package:social_app/design/widgets/custom_circle_avatar.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';
import 'package:social_app/logic/models/message_model.dart';

import 'package:social_app/logic/models/user_model.dart';

class CahtMessage extends StatelessWidget {
  const CahtMessage({super.key, required this.model});
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    final controller = ScrollController(initialScrollOffset: 50);
    return Builder(
      builder: (context) {
        BlocProvider.of<MainSocialCubit>(context)
            .getMessage(receiverId: model.uId);

        return BlocConsumer<MainSocialCubit, MainSocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            DateTime now = DateTime.now();
            String dateNow = DateFormat('yyyy-MM-dd h:mm a').format(now);
            var messageImage =
                BlocProvider.of<MainSocialCubit>(context).messageImage;
            return Scaffold(
                appBar: customAppBar(
                  context: context,
                  title: Row(
                    children: [
                      customCircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(model.image),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  elevation: 2,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                          condition: BlocProvider.of<MainSocialCubit>(context)
                              .messages
                              .isNotEmpty,
                          builder: (context) => Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                        controller: controller,
                                        itemBuilder: (context, index) {
                                          var message =
                                              BlocProvider.of<MainSocialCubit>(
                                                      context)
                                                  .messages[index];
                                          if (BlocProvider.of<MainSocialCubit>(
                                                      context)
                                                  .userModel!
                                                  .uId ==
                                              message.senderId) {
                                            return ContentOfMessage(
                                              messageModel: message,
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              color:
                                                  Colors.blue.withOpacity(0.2),
                                              borderRaduis:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            );
                                          }
                                          return ContentOfMessage(
                                            messageModel: message,
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            color: Colors.grey[600],
                                            borderRaduis:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 10,
                                        ),
                                        itemCount:
                                            BlocProvider.of<MainSocialCubit>(
                                                    context)
                                                .messages
                                                .length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          fallback: (context) => const Center(
                                child: Text('No Message Start Chats'),
                              )),
                    ),
                    if (messageImage != null)
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
                                  image: FileImage(messageImage),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<MainSocialCubit>(context)
                                    .removeMessageImage();
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
                      padding: const EdgeInsets.all(10),
                      child: SendButton(
                        hintText: 'Write your message..',
                        controller: messageController,
                        imageOnPressed: () {
                          BlocProvider.of<MainSocialCubit>(context)
                              .getMessageImage();
                        },
                        sendOnPressed: () {
                          if (messageImage == null) {
                            BlocProvider.of<MainSocialCubit>(context)
                                .sendMessage(
                              dateTime: dateNow,
                              receiverId: model.uId,
                              text: messageController.text,
                            );
                          } else {
                            BlocProvider.of<MainSocialCubit>(context)
                                .uploadMessageImage(
                              dateTime: dateNow,
                              receiverId: model.uId,
                              text: messageController.text,
                            );
                          }
                          messageController.clear();
                          controller.animateTo(
                            controller.position.maxScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}

class ContentOfMessage extends StatelessWidget {
  const ContentOfMessage(
      {super.key,
      this.borderRaduis,
      this.color,
      required this.alignment,
      required this.messageModel});
  final BorderRadiusGeometry? borderRaduis;
  final Color? color;
  final AlignmentGeometry alignment;

  final MessageModel? messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRaduis,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              messageModel!.text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (messageModel!.messageImage != '')
              CachedNetworkImage(
                imageUrl: messageModel!.messageImage,
                height: 180,
                width: 200,
                fit: BoxFit.cover,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  messageModel!.dateTime,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
