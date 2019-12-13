import 'package:abastecelegalapp/models/login_data.dart';
import 'package:abastecelegalapp/models/token_data.dart';
import 'package:abastecelegalapp/models/user.dart';
import 'package:abastecelegalapp/provs/user_model.dart';
import 'package:abastecelegalapp/screens/homescreen/home_page.dart';
import 'package:abastecelegalapp/screens/registerform/register_page.dart';
import 'package:abastecelegalapp/services/auth_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final FocusNode _passwordFocus = FocusNode();

  _login(String username, String password) {
    final loginData = LoginData(username, password);
    var token = AuthAPI.signIn(loginData);

    token.then((t) {
      print('Token >>>> ' + t.getToken());
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      User user = new User(1, 'maxwell', 'Maxwell', 'maxwell.acioli@gmail.com', '');
      final userModel = Provider.of<UserModel>(context, listen: false);
      userModel.setUser(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final newUserText = Text('Novo Usuário? ',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ));

    final signUpText = GestureDetector(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => RegisterPage()));
      },
      child: Text("Cadastrar",
          style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: Colors.blue)),
    );

    final signUp = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[newUserText, signUpText],
    );

    //Username Fiel
    final usernameField = TextField(
      obscureText: false,
      style: style,
      onSubmitted: (v) {
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    //Password Field
    final passwordField = TextField(
      obscureText: true,
      style: style,
      focusNode: _passwordFocus,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _login("admin", "password");
//          Navigator.pushReplacement(
//              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text("Entrar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the LoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/gas-station.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                  SizedBox(height: 45.0),
                  usernameField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButton,
                  SizedBox(
                    height: 15.0,
                  ),
                  signUp,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
