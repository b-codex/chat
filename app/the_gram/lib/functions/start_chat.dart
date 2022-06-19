import 'dart:convert';
import 'package:http/http.dart' as http;

Future startChat({
  required String senderID,
  required String receiverID,
  required String token,
}) async {
  var body = {"senderId": senderID, "receiverId": receiverID};

  var response = await http.post(
      Uri.parse(
          "http://192.168.8.194:8000/microservice/chatService/users/conversation/create"),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return null;
  }
}
