class PostModel {
  late String name;

  late String uId;
  late String image;
  late dynamic dateTime;
  late String tags;
  late String postImage;
  late String text;
  late String postid;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.tags,
    required this.postImage,
    required this.text,
  });

  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
      name: jsonData['name'],
      tags: jsonData['tags'],
      uId: jsonData['uId'],
      text: jsonData['text'],
      image: jsonData['image'],
      postImage: jsonData['postImage'],
      dateTime: jsonData['dateTime'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'tags': tags,
      'text': text,
    };
  }
}
