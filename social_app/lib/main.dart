import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/cache.dart';
import 'package:social_app/constant/primary_color.dart';

import 'package:social_app/core/helper/cache_helper.dart';
import 'package:social_app/core/helper/observer.dart';
import 'package:social_app/core/helper/show_toast_state.dart';
import 'package:social_app/design/modules/comment_screen.dart';
import 'package:social_app/design/views/login_screen.dart';
import 'package:social_app/design/views/social_home.dart';

import 'package:social_app/firebase_options.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_cubit.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(text: 'Handling a background message ', state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  token = await FirebaseMessaging.instance.getToken();

  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message ', state: ToastStates.success);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message open app', state: ToastStates.success);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  Bloc.observer = Observer();
  uId = await CacheHelper.getSaveData(key: 'uId');

  bool? isDark = CacheHelper.getSaveData(key: 'isDark');

  runApp(MyApp(
    uId: uId,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.uId,
    required this.isDark,
  });
  final String? uId;

  final bool? isDark;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainSocialCubit()
        ..getUserData()
        ..getPosts()
        ..changeMode(model: isDark),
      child: BlocBuilder<MainSocialCubit, MainSocialStates>(
          builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: BlocProvider.of<MainSocialCubit>(context).isDark!
              ? lightTheme
              : darkTheme,
          routes: {
            'commentScreen': (context) => const CommentScreen(),
          },
          home: uId == null ? const LoginView() : const SocialHomePage(),
        );
      }),
    );
  }
}
