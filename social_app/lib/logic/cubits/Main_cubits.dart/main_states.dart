abstract class MainSocialStates {}

class MainSocialInitailState extends MainSocialStates {}

class MainSocialLoadingState extends MainSocialStates {}

class MainSocialSucessState extends MainSocialStates {}

class MainSocialErrorState extends MainSocialStates {
  final String errorMassage;

  MainSocialErrorState(
    this.errorMassage,
  );
}

class SocialGetAllUserSucessState extends MainSocialStates {}

class SocialGetAllUserErrorState extends MainSocialStates {
  final String errorMassage;

  SocialGetAllUserErrorState(
    this.errorMassage,
  );
}

class MainSocialChangViewsState extends MainSocialStates {}

class MainSocialAddPostState extends MainSocialStates {}

class MainSocialUpdateUserLoadingState extends MainSocialStates {}

class MainSocialUpdateUserSucessState extends MainSocialStates {}

class MainSocialUpdateUserErrorState extends MainSocialStates {
  final String errorMassage;

  MainSocialUpdateUserErrorState(
    this.errorMassage,
  );
}

class MainSocialGetCoverSucessState extends MainSocialStates {}

class MainSocialGetCoverErrorState extends MainSocialStates {
  final String errorMassage;

  MainSocialGetCoverErrorState(
    this.errorMassage,
  );
}

class MainSocialGetProfileImageSucessState extends MainSocialStates {}

class MainSocialGetProfileImageErrorState extends MainSocialStates {
  final String errorMassage;

  MainSocialGetProfileImageErrorState(
    this.errorMassage,
  );
}

class MainSocialUploadImageLoadingState extends MainSocialStates {}

class MainSocialUploadImageSucessState extends MainSocialStates {}

class MainSocialUploadImageErrorState extends MainSocialStates {
  final String error;

  MainSocialUploadImageErrorState(
    this.error,
  );
}

class MainSocialUploadCoverLoadingState extends MainSocialStates {}

class MainSocialUploadCoverSucessState extends MainSocialStates {}

class MainSocialUploadCoverErrorState extends MainSocialStates {
  final String error;

  MainSocialUploadCoverErrorState(
    this.error,
  );
}

//*********************************** Add Post states  ************************************//
class SocialCreatePostLoadingState extends MainSocialStates {}

class SocialCreatePostSucessState extends MainSocialStates {}

class SocialCreatePostErrorState extends MainSocialStates {
  final String error;

  SocialCreatePostErrorState(
    this.error,
  );
}

class SocialRemovePostImageState extends MainSocialStates {}

class SocialGetPostImageSucessState extends MainSocialStates {}

class SocialGetPostImageErrorState extends MainSocialStates {
  final String error;

  SocialGetPostImageErrorState(
    this.error,
  );
}
//*********************************** get posts states  ************************************//

class SocialGetPostSucessState extends MainSocialStates {}

class SocialGetPostErrorState extends MainSocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

//*********************************** get posts likes  ************************************//
class SocialGetPostLikesSucessState extends MainSocialStates {}

class SocialGetPostLikesErrorState extends MainSocialStates {
  final String error;

  SocialGetPostLikesErrorState(this.error);
}

//*********************************** get posts Comment  ************************************//
class SocialGetPostCommentSucessState extends MainSocialStates {}

class SocialUploadCommentImageLoadingState extends MainSocialStates {}

class SocialGetPostCommentErrorState extends MainSocialStates {
  final String error;

  SocialGetPostCommentErrorState(this.error);
}

class SocialGetPostCommentImageSucessState extends MainSocialStates {}

class SocialGetPostCommentImageErrorState extends MainSocialStates {
  final String error;

  SocialGetPostCommentImageErrorState(this.error);
}

class SocialSendMessageSucessState extends MainSocialStates {}

class SocialSendMessageErrorState extends MainSocialStates {}

class SocialGetMessageSuccessState extends MainSocialStates {}

class SocialGetSearchSuccessState extends MainSocialStates {}

class SocialLikePostState extends MainSocialStates {}

class SocialDeleteLikePostState extends MainSocialStates {}

class SocialRemoveMessageImageState extends MainSocialStates {}

class SocialGetMessageImageSucessState extends MainSocialStates {}

class SocialGetMessageImageErrorState extends MainSocialStates {
  final String error;

  SocialGetMessageImageErrorState(this.error);
}

class SocialChangeModeStates extends MainSocialStates {}
