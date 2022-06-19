import 'dart:convert';
import 'package:http/http.dart' as http;

Future getPreviousConversations({required String cID, required String token}) async {
  var response = await http.get(
      Uri.parse(
          "http://192.168.8.194:8000/microservice/chatService/users/message/conversationId/$cID"),
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