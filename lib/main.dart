import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String api = 'https://platform.clickatell.com/messages';
  String authToken = 'vuj9e6AsRDu20efeWGotNg==';
  Future sendMsg() async {
    final http.Response response;
    response = await http.post(Uri.parse(api),
        headers: <String, String>{
          'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "content": "This msg is from app",
            "to": ["8801839692611"]
          },
        ));
    if (response.statusCode == 202) {
      print('Success');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clickatell'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            sendMsg();
            print('clicked');
          },
          child: Text('Send Message'),
        ),
      ),
    );
  }
}
