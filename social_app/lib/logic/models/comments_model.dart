class CommentModel {
  late String name;
  late String uId;
  late dynamic date;
  late String? commentsImage;
  late String text;
  late String image;

  CommentModel({
    required this.name,
    required this.uId,
    required this.date,
    required this.commentsImage,
    required this.text,
    required this.image,
  });

  factory CommentModel.fromJson(Map<String, dynamic> jsonData) {
    return CommentModel(
      name: jsonData['name'],
      uId: jsonData['uId'],
      image: jsonData['image'],
      text: jsonData['text'],
      commentsImage: jsonData['commentImage'] ?? '',
      date: jsonData['dateTime'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': date,
      'uId': uId,
      'image': image,
      'commentImage': commentsImage,
      'text': text,
    };
  }
}
