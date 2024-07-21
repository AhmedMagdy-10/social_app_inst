abstract class RegisterSocialStates {}

class RegisterSocialInitailState extends RegisterSocialStates {}

class RegisterSocialLoadingState extends RegisterSocialStates {}

class RegisterSocialSucessState extends RegisterSocialStates {}

class RegisterSocialErrorState extends RegisterSocialStates {
  String errorMessage;
  RegisterSocialErrorState({required this.errorMessage});
}

class RegisterChangePasswordShowState extends RegisterSocialStates {}

class RegisterCreateSocialSucessState extends RegisterSocialStates {}

class RegisterCreateSocialErrorState extends RegisterSocialStates {
  String errorMessage;
  RegisterCreateSocialErrorState({required this.errorMessage});
}
