import 'package:abastecelegalapp/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:abastecelegalapp/theme/theme.dart';
import 'package:abastecelegalapp/blocprovs/example-bloc-prov.dart';
import 'package:abastecelegalapp/blocs/example-bloc.dart';
import 'package:abastecelegalapp/theme/style.dart';
import 'package:abastecelegalapp/screens/example1/examplescreen1.dart';
import 'package:abastecelegalapp/screens/example2/examplescreen2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: buildThemeData(),
      home: LoginPage(title: 'Abastece Legal'),
    );
  }
}