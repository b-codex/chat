// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

Future getName({required String receiverID, required String token}) async {
  var body = {"user": receiverID};
  var response = await http.post(
      Uri.parse(
          "http://192.168.8.194:8000/microservice/accountService/users/singleUser"),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
  if (response.statusCode == 200) {
    final body = json.decode(response.body);
    final String name = body['others']['fullName'];
    return name;
  } else {
    return null;
  }
}
