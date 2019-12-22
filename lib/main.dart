import 'package:abastecelegalapp/provs/trip_provider.dart';
import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/screens/login/loginscreen.dart';
import 'package:abastecelegalapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light));

    return MultiProvider(
      providers: [
        // ignore: deprecated_member_use
        ChangeNotifierProvider(builder: (context) => UserProvider()),
        // ignore: deprecated_member_use
        ChangeNotifierProvider(builder: (context) => TripProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildThemeData(),
        home: LoginPage(
          title: 'Abastece Legal',
        ),
      ),
    );
  }
}
