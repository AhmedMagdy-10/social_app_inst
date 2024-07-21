import 'package:flutter/material.dart';
import 'package:social_app/logic/models/post_model.dart';

class ProfilePostCard extends StatelessWidget {
  const ProfilePostCard({
    super.key,
    this.userPost,
  });
  final List<PostModel>? userPost;

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> mediaItems = [
    //   {
    //     "id": "1",
    //     "imageUrl":
    //         "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG-20230809-WA0008.jpg?alt=media&token=f41dc92f-283e-4237-9ce6-bd7dbeca8fb6"
    //   },
    //   {
    //     "id": "2",
    //     "imageUrl":
    //         "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG_20211021_220311_001.jpg?alt=media&token=85a15d2f-3726-4e40-83eb-5a891aaa51fe"
    //   },
    //   {
    //     "id": "3",
    //     "imageUrl":
    //         "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG-20230809-WA0014.jpg?alt=media&token=3847e817-2e86-4c37-8bed-cfbe7d1042a9"
    //   },
    //   {
    //     "id": "4",
    //     "imageUrl":
    //         "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG-20230809-WA0008.jpg?alt=media&token=f41dc92f-283e-4237-9ce6-bd7dbeca8fb6"
    //   },
    //   {
    //     "id": "5",
    //     "imageUrl":
    //         "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG-20230809-WA0008.jpg?alt=media&token=63bc3b99-b599-4f1a-b3af-dbd1bb51f737"
    //   },
    //   {
    //     "id": "6",
    //     "imageUrl":
    //         "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG_20230422_205114_659.webp?alt=media&token=eba7d3a8-b5db-491d-87e4-b02ccf5457f2"
    //   },
    //   {
    //     "id": "7",
    //     "imageUrl":
    //         "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG_20211021_220311_001.jpg?alt=media&token=8150ad46-bd6d-415f-87ab-2c9561cc2d3a"
    //   },
    // ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemBuilder: (context, index) {
        var postImages = userPost![index];
        if (postImages.postImage != '') {
          return Image.network(
            postImages.postImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        } else {
          return const Text('No Post Image ');
        }
      },
      itemCount: userPost != null ? userPost!.length : 0,
    );
  }
}
