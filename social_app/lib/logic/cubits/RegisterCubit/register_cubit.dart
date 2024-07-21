import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/cache.dart';

import 'package:social_app/logic/cubits/RegisterCubit/register_states.dart';
import 'package:social_app/logic/models/user_model.dart';

class RegisterSocialCubit extends Cubit<RegisterSocialStates> {
  RegisterSocialCubit(context) : super(RegisterSocialInitailState());

  Future<void> userRegister({
    required String email,
    required String password,
    required String phone,
    required String userName,
  }) async {
    emit(RegisterSocialLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userCreate(
          name: userName,
          phone: phone,
          email: email,
          uId: value.user!.uid,
        );
      }).catchError((error) {
        emit(RegisterCreateSocialErrorState(errorMessage: error.toString()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterSocialErrorState(errorMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterSocialErrorState(
            errorMessage: 'The account already exists for that email'));
      }
    } catch (ex) {
      emit(RegisterSocialErrorState(errorMessage: ex.toString()));
    }
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image:
            'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=740&t=st=1693278335~exp=1693278935~hmac=dcea9bda729c85a772b06fed4ab4ff44e4a3567c34ee201989bfd1cde87a8fa0',
        bio: 'Write your bio.. ',
        cover:
            'https://img.freepik.com/free-photo/illuminated-minaret-symbolizes-spirituality-famous-blue-mosque-generated-by-ai_188544-35440.jpg?t=st=1693155158~exp=1693158758~hmac=314341af2cdd672b12455d80001255911694b3f09973dc0e72a0382d98c3970b&w=826',
        token: token!

        //
        );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateSocialSucessState());
    }).catchError((error) {
      emit(RegisterCreateSocialErrorState(errorMessage: error.toString()));
    });
  }

  bool secure = true;
  IconData suffix = Icons.visibility_outlined;
  void passwordVisibility() {
    secure = !secure;
    suffix = secure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordShowState());
  }
}
