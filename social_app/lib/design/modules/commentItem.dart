import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:social_app/design/widgets/custom_circle_avatar.dart';
import 'package:social_app/logic/models/comments_model.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    this.postId,
    this.model,
  });
  final String? postId;
  final CommentModel? model;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customCircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(model!.image),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 0,
                          )),
                      Text(
                        model!.text,
                        maxLines: 7,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 0,
                        ),
                      ),
                      if (model!.commentsImage != '')
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                            left: 5,
                            bottom: 5,
                          ),
                          child: SizedBox(
                            height: 150,
                            width: 190,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: model!.commentsImage!,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      Text(
                        model!.date,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[300],
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
   
 

// StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance
    //       .collection('posts')
    //       .doc(postId)
    //       .collection('comments')
    //       .orderBy('date', descending: true)
    //       .snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<CommentModel>? commentModel = [];

    //       for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //         commentModel.add(CommentModel.fromJson(snapshot.data!.docs[i]));
    //       }