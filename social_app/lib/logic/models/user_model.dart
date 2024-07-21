class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String cover;
  late String bio;
  late String token;
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.bio,
    required this.cover,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      uId: jsonData['uId'],
      image: jsonData['image'],
      cover: jsonData['cover'],
      bio: jsonData['bio'],
      token: jsonData['token'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
      'token': token,
    };
  }
}
