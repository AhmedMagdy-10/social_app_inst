import 'package:flutter/material.dart';

class ProfilePostSevedItem extends StatelessWidget {
  const ProfilePostSevedItem({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> mediaItems = [
      {
        "id": "1",
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG-20230809-WA0008.jpg?alt=media&token=f41dc92f-283e-4237-9ce6-bd7dbeca8fb6"
      },
      {
        "id": "2",
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG_20211021_220311_001.jpg?alt=media&token=85a15d2f-3726-4e40-83eb-5a891aaa51fe"
      },
      {
        "id": "3",
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/social-app-a5feb.appspot.com/o/users%2FIMG-20230809-WA0014.jpg?alt=media&token=3847e817-2e86-4c37-8bed-cfbe7d1042a9"
      },
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemBuilder: (context, index) {
        var items = mediaItems[index];
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Image.network(
              '${items["imageUrl"]}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            const Icon(
              Icons.bookmark,
              color: Colors.red,
            ),
          ],
        );
      },
      itemCount: mediaItems.length,
    );
  }
}
