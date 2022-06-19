// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_gram/functions/get_name.dart';

Future getConversation({required String token, required String id}) async {
  var response = await http.get(
      Uri.parse(
          "http://192.168.8.194:8000/microservice/chatService/users/conversation/$id"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
  if (response.statusCode == 200) {
    var rIDs = [];
    var body = json.decode(response.body);

    for (var conversations in body) {
      if (conversations['members'][1] != id) {
        rIDs.add(conversations['members'][1]);
      } else {
        rIDs.add(conversations['members'][0]);
      }

      // rIDs.add(conversations['members'][1]);
      // print(conversations['members']);
    }
    var rNames = [];

    for (var rID in rIDs) {
      var name = await getName(token: token, receiverID: rID);
      rNames.add(name);
    }

    return {
      'body': body,
      'rNames': rNames,
    };
  } else {
    return null;
  }
}
