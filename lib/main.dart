import 'package:ayudafinal/principal.dart';
import 'package:flutter/material.dart';
//import 'package:ayudafinal/pages/root_page.dart';
//import 'package:ayudafinal/services/authentication.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'SPORTS TRAINING',
        theme: new ThemeData(
          brightness: Brightness.dark,
        ),
        home: new comenzar());
  }
}
