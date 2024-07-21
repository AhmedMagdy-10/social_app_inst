// import 'dart:math';

// String getTimeFromNow(dynamic timesTimp) {
//   DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timesTimp);
//   DateTime now = DateTime.now();

//   int differenceInSeconds = max(0, now.difference(dateTime).inSeconds);

//   if (differenceInSeconds < 60) {
//     return "$differenceInSeconds seconds ago";
//   } else {
//     int differenceInMinuts = differenceInSeconds ~/ 60;

//     if (differenceInMinuts < 60) {
//       return "$differenceInMinuts minuts ago";
//     } else {
//       int differenceInHours = differenceInMinuts ~/ 60;

//       if (differenceInHours < 24) {
//         return "$differenceInHours hours ago";
//       } else {
//         int differenceInDays = differenceInHours ~/ 60;

//         return "$differenceInDays days ago";
//       }
//     }
//   }
// }
import 'dart:math';

String getTimeFromNow(int timestamp) {
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
  DateTime now = DateTime.now();

  int differenceInSeconds =
      max(0, (now.difference(dateTime).inMilliseconds / 1000).round());
  // int differenceInSeconds = max(0, now.difference(dateTime).inSeconds);

  if (differenceInSeconds < 60) {
    return "$differenceInSeconds seconds ago";
  } else {
    int differenceInMinutes = differenceInSeconds ~/ 60;

    if (differenceInMinutes < 60) {
      return "$differenceInMinutes minutes ago";
    } else {
      int differenceInHours = differenceInMinutes ~/ 60;

      if (differenceInHours < 24) {
        return "$differenceInHours hours ago";
      } else {
        int differenceInDays = differenceInHours ~/ 24;
        return "$differenceInDays days ago";
      }
    }
  }
}
