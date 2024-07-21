import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constant/cache.dart';
import 'package:social_app/core/helper/cache_helper.dart';
import 'package:social_app/core/helper/notification_api.dart';

import 'package:social_app/design/modules/add_post_screen.dart';
import 'package:social_app/design/modules/chats_screen.dart';
import 'package:social_app/design/modules/feeds_screen.dart';

import 'package:social_app/design/modules/setting_screen.dart';
import 'package:social_app/design/modules/users_screen.dart';
import 'package:social_app/logic/cubits/Main_cubits.dart/main_states.dart';
import 'package:social_app/logic/models/comments_model.dart';
import 'package:social_app/logic/models/message_model.dart';

import 'package:social_app/logic/models/post_model.dart';
import 'package:social_app/logic/models/user_model.dart';

class MainSocialCubit extends Cubit<MainSocialStates> {
  MainSocialCubit() : super(MainSocialLoadingState());
  BuildContext? context;

  UserModel? userModel;

  Future<void> getUserData() async {
    uId = CacheHelper.getSaveData(key: 'uId');
    emit(MainSocialLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(MainSocialSucessState());
    }).catchError((error) {
      emit(MainSocialErrorState(
        error.toString(),
      ));
      print(error.toString());
    });
  }

  int currentIndex = 0;
  List<String> title = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Profile',
  ];

  List<Widget> views = const [
    FeedsView(),
    ChatsView(),
    AddPostView(),
    UserView(),
    SettingView(),
  ];

  void changeViews(int index) {
    if (index == 1) {
      getAllUser();
    }

    if (index == 2) {
      emit(MainSocialAddPostState());
    } else {
      currentIndex = index;
      emit(MainSocialChangViewsState());
    }
  }

  //---------------------  Get profile Image --------------------------------//
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(MainSocialGetProfileImageSucessState());
      print(pickedFile.path);
    } else {
      print('No image selected');
    }
  }

//---------------------  Get Cover Image --------------------------------//
  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);

      emit(MainSocialGetCoverSucessState());
    } else {
      emit(MainSocialGetProfileImageErrorState('No image selected'));
      print('No image selected');
    }
  }

  //---------------------  upload profile Image --------------------------------//
  void uploadProfileImage({
    String? image,
  }) {
    emit(MainSocialUploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(image: value);
        emit(
          MainSocialUploadImageSucessState(),
        );
      }).catchError((error) {
        emit(MainSocialUploadImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(MainSocialUploadImageErrorState(error.toString()));
    });
  }

//---------------------  upload cover Image --------------------------------//
  void uploadCoverImage({
    String? cover,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          cover: value,
        );
        emit(MainSocialUploadCoverSucessState());
      }).catchError((error) {
        emit(MainSocialUploadCoverErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(MainSocialUploadCoverErrorState(error.toString()));
    });
  }

  //---------------------  update User Data (name,phone, Bio) --------------------------------//
  void updateUser({
    String? name,
    String? bio,
    String? phone,
    String? email,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
        name: name ?? userModel!.name,
        email: email ?? userModel!.email,
        phone: phone ?? userModel!.phone,
        uId: userModel!.uId,
        image: image ?? userModel!.image,
        bio: bio ?? userModel!.bio,
        cover: cover ?? userModel!.cover,
        token: token!);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(MainSocialUpdateUserErrorState(error.toString()));
    });
  }

//---------------------  Create New Post  --------------------------------//
  File? postImage;
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);

      emit(SocialGetPostImageSucessState());
    } else {
      emit(SocialGetPostImageErrorState('No image selected'));
      print('No image selected');
    }
  }

  void uploadPostImage({
    dynamic dateTime,
    String? text,
  }) {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          postImage: value,
          text: text,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  dynamic postid;

  void createPost({
    String? name,
    String? uId,
    @required dynamic dateTime,
    String? email,
    String? tags,
    String? image,
    String? postImage,
    required String? text,
  }) {
    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime!,
      tags: tags ?? '',
      postImage: postImage ?? '',
      text: text!,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSucessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  List<PostModel>? userPosts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<CommentModel>? commentModel = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((value) {
      userPosts = [];
      postId = [];
      for (int i = 0; i < value.docs.length; i++) {
        bool isPostAlreadyAdded = false;
        value.docs[i].reference.collection('likes').snapshots().listen((event) {
          likes.add(event.docs.length);

          if (!isPostAlreadyAdded) {
            userPosts!.add(PostModel.fromJson(value.docs[i].data()));
            isPostAlreadyAdded = true;
          }

          postId.add(value.docs[i].id);

          print(value.docs[i].data());
          emit(SocialGetPostSucessState());
        });

        value.docs[i].reference
            .collection('comments')
            .orderBy('dateTime', descending: true)
            .snapshots()
            .listen((event) {
          commentModel = [];

          if (!isPostAlreadyAdded) {
            userPosts!.add(PostModel.fromJson(value.docs[i].data()));
            isPostAlreadyAdded = true;
          }

          for (var doc in event.docs) {
            commentModel!.add(CommentModel.fromJson(doc.data()));
          }
          // commentModel!.add(CommentModel.fromJson(event.docs[i].data()));

          if (i < value.docs.length) {
            postId.add(value.docs[i].id);

            emit(SocialGetPostSucessState());
          }
        });
      }
    });
  }

//---------------------   Post likes --------------------------------//

  void getLikes({
    required String postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialGetPostLikesSucessState());
    }).catchError((error) {
      emit(SocialGetPostLikesErrorState(error.toString()));
    });
  }

  Stream<QuerySnapshot> streamLike({
    String? postId,
  }) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .snapshots();
  }

  //---------------------   gets posts comment --------------------------------//

  Stream<QuerySnapshot> streamComment({
    String? postId,
  }) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots();
  }

  File? commentImage;
  void removeCommentImage() {
    commentImage = null;
    emit(SocialRemovePostImageState());
  }

  Future<void> getCommentImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      commentImage = File(pickedFile.path);

      emit(SocialGetPostCommentImageSucessState());
    } else {
      emit(SocialGetPostCommentImageErrorState('No image selected'));
      print('No image selected');
    }
  }

  void uploadCommentImage({
    dynamic dateTime,
    String? text,
    String? commentText,
    String? name,
    String? commentsImage,
    String? postId,
  }) {
    emit(SocialUploadCommentImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('comments/${Uri.file(commentImage!.path).pathSegments.last}')
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createComments(
            postId: postId!,
            commentText: commentText,
            commentsImage: value,
            dateTime: dateTime);
        SocialGetPostCommentSucessState();
      }).catchError((error) {
        emit(SocialCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  void createComments({
    required String? commentText,
    required dynamic dateTime,
    required String? postId,
    String? commentsImage,
  }) {
    CommentModel commentModel = CommentModel(
        name: userModel!.name,
        uId: userModel!.uId,
        date: dateTime!,
        commentsImage: commentsImage ?? '',
        text: commentText!,
        image: userModel!.image);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(SocialGetPostCommentSucessState());
    }).catchError((error) {
      emit(SocialGetPostCommentErrorState(error.toString()));
    });
  }

  List<UserModel> user = [];

  void getAllUser() {
    if (user.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          if (value.docs[i].data()['uId'] != userModel!.uId) {
            user.add(UserModel.fromJson(value.docs[i].data()));
          }
        }
        emit(SocialGetAllUserSucessState());
      }).catchError((erorr) {
        emit(SocialGetAllUserErrorState(erorr.toString()));
      });
    }
  }

  File? messageImage;

  void removeMessageImage() {
    messageImage = null;
    emit(SocialRemoveMessageImageState());
  }

  Future<void> getMessageImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);

      emit(SocialGetMessageImageSucessState());
    } else {
      emit(SocialGetMessageImageErrorState('No image selected'));
      print('No image selected');
    }
  }

  void uploadMessageImage({
    String? dateTime,
    String? receiverId,
    String? text,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
            dateTime: dateTime!,
            receiverId: receiverId!,
            text: text!,
            messageImage: value);

        emit(SocialSendMessageSucessState());
      }).catchError((error) {
        emit(SocialSendMessageErrorState());
      });
    }).catchError((error) {});
  }

  void sendMessage({
    required String dateTime,
    required String receiverId,
    required String text,
    String? messageImage,
  }) {
    MessageModel model = MessageModel(
        dateTime: dateTime,
        receiverId: dateTime,
        senderId: userModel!.uId,
        text: text,
        messageImage: messageImage ?? '');

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      sendPushNotification(userModel!, 'From Chats', model.text);

      emit(SocialSendMessageSucessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      sendPushNotification(userModel!, userModel!.name, model.text);
      emit(SocialSendMessageSucessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessage({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }

//---------------------   gets posts comment --------------------------------//

  var isLike = false;

  like({
    String? postId,
  }) {
    isLike = !isLike;

    emit(SocialLikePostState());
  }

  Future<void> deleteLike({
    String? postId,
  }) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete();
  }

  bool? isDark = false;
  void changeMode({
    bool? model,
  }) {
    if (model != null) {
      isDark = model;
      emit(SocialChangeModeStates());
    } else {
      isDark = !isDark!;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(SocialChangeModeStates());
      });
    }

    // void changeMode() {
    //   isDark = !isDark;
    //   emit(SocialChangeModeStates());
    // }

    // if (BlocProvider.of<MainSocialCubit>(context).isLike == false) {
    //   BlocProvider.of<MainSocialCubit>(context).deleteLike(
    //       postId:
    //           BlocProvider.of<MainSocialCubit>(context).postId[index!]);
    // }
  }
}
