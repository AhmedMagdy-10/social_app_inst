class MessageModel {
  late String receiverId;
  late String senderId;
  late String dateTime;
  late String text;
  late String messageImage;

  MessageModel({
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
    required this.text,
    required this.messageImage,
  });

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      receiverId: jsonData['receiverId'],
      text: jsonData['text'],
      senderId: jsonData['senderId'],
      dateTime: jsonData['dateTime'],
      messageImage: jsonData['messageImage'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'receiverId': receiverId,
      'senderId': senderId,
      'text': text,
      'messageImage': messageImage,
    };
  }
}
