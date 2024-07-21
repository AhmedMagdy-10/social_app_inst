import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/logic/cubits/bothCubit/both_states.dart';

class LoginSocialCubit extends Cubit<LoginSocialStates> {
  LoginSocialCubit() : super(LoginSocialInitailtate());

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginSocialLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                emit(
                  LoginSocialSucessState(value.user!.uid),
                ),
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginSocialErrorState(
            errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginSocialErrorState(
            errorMessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginSocialErrorState(errorMessage: e.toString()));
    }
  }

  bool secure = true;
  IconData suffix = Icons.visibility_outlined;
  void passwordVisibility() {
    secure = !secure;
    suffix = secure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordShowState());
  }
}
