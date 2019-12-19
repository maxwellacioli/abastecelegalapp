import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/screens/login/loginscreen.dart';
import 'package:abastecelegalapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [ChangeNotifierProvider(builder: (context) => UserProvider())],
      child:
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildThemeData(),
        home: LoginPage(
          title: 'Abastece Legal',
        ),
      ),
    );
  }
}
