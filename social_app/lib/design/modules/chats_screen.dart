import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helper/my_divider.dart';
import 'package:social_app/core/helper/navigator_to.dart';
import 'package:social_app/design/widgets/custom_chet_message_item.dart';

import 'package:social_app/design/widgets/custom_user_info.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';
import 'package:social_app/logic/models/user_model.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainSocialCubit, MainSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: BlocProvider.of<MainSocialCubit>(context).user.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => ChatUser(
              model: BlocProvider.of<MainSocialCubit>(context).user[index],
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: BlocProvider.of<MainSocialCubit>(context).user.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class ChatUser extends StatelessWidget {
  const ChatUser({super.key, this.model});

  final UserModel? model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigatorPushTo(context, CahtMessage(model: model!));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: UserWhoCreatPost(
          model: model!,
          networkImage: model!.image,
        ),
      ),
    );
  }
}
