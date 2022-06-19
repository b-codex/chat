import 'dart:convert';
import 'package:http/http.dart' as http;

Future sendMessage({
  required String message,
  required String cID,
  required String token,
  required String senderID,
}) async {
  var body = {"conversation": cID, "text": message, "sender": senderID};
  var response = await http.post(
      Uri.parse(
          "http://192.168.8.194:8000/microservice/chatService/users/message/create"),
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
