import 'package:abastecelegalapp/screens/login/loginscreen.dart';
import 'package:abastecelegalapp/theme/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abastece Legal',
      theme: buildThemeData(),
      home: LoginPage(
          title: 'Abastece Legal',
      ),
    );
  }
}