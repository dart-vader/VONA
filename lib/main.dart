import 'package:flutter/material.dart';
import 'package:vonaapp/MyVoice.dart';
import 'package:vonaapp/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.amber,
        canvasColor: Color.fromRGBO(255, 188, 62, 1),
        //canvasColor: Colors.amber,
      ),
      home: new Login(),
    );
  }
}

