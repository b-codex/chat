import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_gram/functions/login.dart';
import 'package:the_gram/screens/chat_page.dart';
import 'package:the_gram/socket.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //init state
  @override
  void initState() {
    List names = <String>["123", "456"];

    final String currentUser = names[Random().nextInt(names.length)];

    ChatPage.setCurrentUser(currentUser);

    Socket.setSender(ChatPage.getCurrentUser());
    Socket.connectSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loginScreen(context),
    );
  }
}

Widget loginScreen(context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  return Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 11),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      debugPrint('logging in');
                      login(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ).then((value) {
                        debugPrint('logged in');

                        final token = value['token'];
                        final user = value['id'];

                        ChatPage.setCurrentUser(user);
                        ChatPage.setToken(token);
                        ChatPage.setId(user);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage.returnWidget(),
                          ),
                        );
                      });
                    } else {
                      Builder(
                        builder: (context) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          return const Text("data");
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
