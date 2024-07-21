abstract class LoginSocialStates {}

class LoginSocialInitailtate extends LoginSocialStates {}

class LoginSocialLoadingState extends LoginSocialStates {}

class LoginSocialSucessState extends LoginSocialStates {
  final String uId;

  LoginSocialSucessState(this.uId);
}

class LoginSocialErrorState extends LoginSocialStates {
  String errorMessage;
  LoginSocialErrorState({required this.errorMessage});
}

class LoginChangePasswordShowState extends LoginSocialStates {}
