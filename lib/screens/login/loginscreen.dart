import 'dart:convert';

import 'package:abastecelegalapp/models/login_data.dart';
import 'package:abastecelegalapp/models/token_data.dart';
import 'package:abastecelegalapp/models/user.dart';
import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/screens/homescreen/home_page.dart';
import 'package:abastecelegalapp/screens/registerform/register_page.dart';
import 'package:abastecelegalapp/services/auth_api.dart';
import 'package:abastecelegalapp/services/veihicle_service.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Token token;

  String _username;
  String _password;

  bool _loading = false;

  setToken(String token) {
    var userProv = Provider.of<UserProvider>(context);
    userProv.setUser(User.token(token));
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

    //Username Field
    final usernameField = TextFormField(
      onSaved: (value) => _username = value,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Usuário",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Nome do usuario obrigatorio';
        }
        return null;
      },
    );

    //Password Field
    final passwordField = TextFormField(
      onSaved: (value) => _password = value,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Senha do usuario obrigatorio';
        }
        return null;
      },
    );

    Future<bool> _login() async {
      bool success = false;

      final loginData = LoginData(_username.trim(), _password);
      var response = await AuthAPI.signIn(loginData);

      if (response.statusCode == 200) {
        setToken(Token.fromJson(json.decode(response.body)).getToken());

        var userProv = Provider.of<UserProvider>(context);
        var responseMe = await AuthAPI.me(userProv.user.token);

        if (responseMe.statusCode == 200) {
          User user = User.fromJson(json.decode(responseMe.body));
          userProv.user.setId(user.id);
          userProv.user.setEmail(user.email);
          userProv.user.setUsername(user.username);
          userProv.user.setName(user.name);

          if (user.principalId != null) {
            userProv.user.setPrincipalId(user.principalId);
            var vehicle = await VehicleService.getPrincipalVehicle(
                user.principalId, userProv.user.token);
            userProv.setSelectedVehicle(vehicle);
          }

          //Getting vehicle list
          var vehicles = await VehicleService.getVehicles(
              userProv.user.id, userProv.user.token, userProv.vehicleNextPage);
          userProv.addVehicles(vehicles);
          userProv.setVehicleNextPage(userProv.vehicleNextPage + 1);

          success = true;
        }
      }

      return success;
    }

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          _formKey.currentState.save();

          if (_formKey.currentState.validate()) {
            setState(() {
              _loading = true;
            });

            var success = await _login();

            if (success) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            }
          }
        },
        child: Text("Entrar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final _submitArea = Container(
        child: Column(
      children: <Widget>[
        loginButton,
        SizedBox(
          height: 15.0,
        ),
        signUp
      ],
    ));

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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        usernameField,
                        SizedBox(height: 25.0),
                        passwordField,
                        SizedBox(
                          height: 35.0,
                        )
                      ],
                    ),
                  ),
                  _loading
                      ? new Container(
                          color: Colors.white,
                          width: 70.0,
                          height: 70.0,
                          child: new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new Center(
                                  child: new CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              ))),
                        )
                      : _submitArea,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
