import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class FavoriteRequestClass {
  static void sendMessag() async {
    // var params = {
    //   "to": "device token",
    //   "notification": {
    //     "title": "Notification Title",
    //     "body": "Notification Message",
    //     "sound": "default",
    //   },
    //   "data": {"customId": "01", "badge": 0, "alert": "Alert"}
    // };

    // var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    // var response = await http.post(url,
    //     headers: {
    //       "Authorization": "key=AIzaSyCDG54NSm_rQDqRtuNeTTMYSyx5n0RGhBY",
    //       "Content-Type": "application/json"
    //     },
    //     body: json.encode(params));

    // if (response.statusCode == 200) {
    //   Map<String, dynamic> map = json.decode(response.body);
    // } else {
    //   Map<String, dynamic> error = jsonDecode(response.body);
    // }
    print('Followed');
  }
}
