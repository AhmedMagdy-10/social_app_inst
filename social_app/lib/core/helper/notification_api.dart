import 'package:http/http.dart' as http;
import 'package:social_app/core/helper/show_toast_state.dart';
import 'dart:convert';

import 'package:social_app/logic/models/user_model.dart';

var serverKey =
    'AAAAxyYjdeU:APA91bHy1oo01-EHBgEdv1CY2mAE0urGPYkdvpF_BsaWdX58vmtWhlkTiKDFRUCrVSBEa_CENYDBuE3CHJLp_1ZI3izyTODdICqStVSPMEaQHB_fceLAzu9YHH3VwVM3wZ_B3gszMs_q';

Future<void> sendPushNotification(
    UserModel userModel, String title, String body) async {
  const url = 'https://fcm.googleapis.com/fcm/send';

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final payload = {
    'notification': {
      'title': title,
      'body': body,
    },
    'to': userModel.token,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(payload),
  );

  try {
    if (response.statusCode == 200) {
      // Notification sent successfully
      showToast(
          text: 'Notification sent successfully', state: ToastStates.success);
    }
  } on Exception catch (e) {
    print(e.toString());

    showToast(text: e.toString(), state: ToastStates.error);
  }
}
