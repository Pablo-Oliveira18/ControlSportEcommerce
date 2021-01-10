import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());

  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Sports',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.green,
        child: Scaffold(
          appBar: AppBar(
            title: Text("s"),
          ),
        ),
      ),
    );
  }
}
