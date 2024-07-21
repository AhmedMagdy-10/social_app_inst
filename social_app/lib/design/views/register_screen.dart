import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/primary_color.dart';
import 'package:social_app/core/helper/navigator_to.dart';
import 'package:social_app/design/views/login_screen.dart';
import 'package:social_app/design/views/social_home.dart';
import 'package:social_app/design/widgets/custom_button.dart';
import 'package:social_app/design/widgets/custom_show_snack_bar.dart';

import 'package:social_app/design/widgets/reused_form_field.dart';
import 'package:social_app/logic/cubits/RegisterCubit/register_cubit.dart';
import 'package:social_app/logic/cubits/RegisterCubit/register_states.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController userController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();
    return BlocProvider(
      create: (context) => RegisterSocialCubit(context),
      child: BlocConsumer<RegisterSocialCubit, RegisterSocialStates>(
          listener: (context, state) {
        if (state is RegisterCreateSocialSucessState) {
          navigatorPushTo(context, const SocialHomePage());
        } else if (state is RegisterSocialErrorState) {
          return showSnackBar(context, state.errorMessage);
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
                            'Register',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Welcome to BEsocial',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
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
                              height: 50,
                            ),
                            reusedTextField(
                                label: const Text('UserName'),
                                controller: userController,
                                prefix: const Icon(Icons.person)),
                            const SizedBox(
                              height: 10,
                            ),
                            reusedTextField(
                                label: const Text('Email'),
                                controller: emailController,
                                prefix: const Icon(Icons.email_outlined)),
                            const SizedBox(
                              height: 10,
                            ),
                            reusedTextField(
                              label: const Text('Password'),
                              controller: passwordController,
                              prefix: const Icon(Icons.lock),
                              secure:
                                  BlocProvider.of<RegisterSocialCubit>(context)
                                      .secure,
                              suffixIcon:
                                  BlocProvider.of<RegisterSocialCubit>(context)
                                      .suffix,
                              suffixPressed: () {
                                BlocProvider.of<RegisterSocialCubit>(context)
                                    .passwordVisibility();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            reusedTextField(
                                label: const Text('phone'),
                                controller: phoneController,
                                prefix: const Icon(Icons.phone)),
                            const SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                              condition: state is! RegisterSocialLoadingState,
                              builder: (context) {
                                return CustomButton(
                                    text: 'REGISTER',
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<RegisterSocialCubit>(
                                                context)
                                            .userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          userName: userController.text,
                                          phone: phoneController.text,
                                        );
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
                                  'Al ready have an account',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginView(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'LOGIN',
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
