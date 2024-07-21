import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/primary_color.dart';
import 'package:social_app/core/helper/cache_helper.dart';
import 'package:social_app/core/helper/navigator_to.dart';
import 'package:social_app/core/helper/show_toast_state.dart';
import 'package:social_app/design/views/register_screen.dart';
import 'package:social_app/design/views/social_home.dart';
import 'package:social_app/design/widgets/custom_button.dart';

import 'package:social_app/design/widgets/reused_form_field.dart';
import 'package:social_app/logic/cubits/bothCubit/both_cubit.dart';
import 'package:social_app/logic/cubits/bothCubit/both_states.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

    return BlocProvider(
      create: (context) => LoginSocialCubit(),
      child: BlocConsumer<LoginSocialCubit, LoginSocialStates>(
          listener: (context, state) {
        if (state is LoginSocialErrorState) {
          return showToast(text: state.errorMessage, state: ToastStates.error);
        } else if (state is LoginSocialSucessState) {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) => {
                navigatorPushTo(context, const SocialHomePage()),
              });
          return showToast(text: 'Success', state: ToastStates.success);
        }
      }, builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kprimaryColor,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Welcome to',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                '  BE BO',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'GT Sectra Fine',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(65),
                            topRight: Radius.circular(65),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              reusedTextField(
                                  label: const Text('Email'),
                                  text: "فين البريد يغالي",
                                  controller: emailController,
                                  prefix: const Icon(Icons.email_outlined)),
                              const SizedBox(
                                height: 10,
                              ),
                              reusedTextField(
                                label: const Text('Password'),
                                text: "فين كلمه السر يغالي",
                                controller: passwordController,
                                prefix: const Icon(Icons.lock),
                                secure:
                                    BlocProvider.of<LoginSocialCubit>(context)
                                        .secure,
                                suffixIcon:
                                    BlocProvider.of<LoginSocialCubit>(context)
                                        .suffix,
                                suffixPressed: () {
                                  BlocProvider.of<LoginSocialCubit>(context)
                                      .passwordVisibility();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginSocialLoadingState,
                                builder: (context) {
                                  return CustomButton(
                                      text: 'LOGIN',
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<LoginSocialCubit>(
                                                  context)
                                              .userLogin(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                        }
                                      });
                                },
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator(
                                  color: kprimaryColor,
                                )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterView(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'REGISTER',
                                      style: TextStyle(
                                        color: kprimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
