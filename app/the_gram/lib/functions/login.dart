import 'dart:convert';

import 'package:http/http.dart' as http;

Future login({required String email, required String password}) async {
  var body = {"email": email, "password": password};

  var response = await http.post(
      Uri.parse(
          "http://192.168.8.194:8000/microservice/accountService/users/login"),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      });

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return null;
  }
}
