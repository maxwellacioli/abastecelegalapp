import 'package:abastecelegalapp/models/signup_data.dart';
import 'package:abastecelegalapp/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/screens/login/loginscreen.dart';
import 'package:flutter/services.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  String _name;
  String _email;
  String _username;
  String _password;

  bool _loading = false;

  Widget loadingData() {
    return Center(
      child: new CircularProgressIndicator(
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget signUpButton () {

    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        minWidth: 200.0,
                        onPressed: () async {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');

                          setState(() {
                            _loading = true;
                          });

                          bool success = await _submit();
                          if(success) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Cadastrar",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            onSaved: (value) => _name = value,
            decoration:
                const InputDecoration(labelText: 'Nome', hintText: 'Nome'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Name name is required';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _email = value,
            decoration: const InputDecoration(
                labelText: 'E-mail', hintText: 'examplo@email.com'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email is required';
              } else if (!validEmail(value)) {
                return 'Invalid e-mail format';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _username = value,
            decoration: const InputDecoration(
                labelText: 'Username', hintText: 'Username'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _password = value,
            decoration: const InputDecoration(
                labelText: 'Password', hintText: 'Password'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Password é necessário';
              }
            },
          ),
          const SizedBox(height: 40.0),
          _loading ? loadingData() : signUpButton(),
        ],
      ),
    );
  }

  Future<bool> _submit() async {
    _formKey.currentState.save();
    bool success = false;

    if(_formKey.currentState.validate()) {
      var signUpData = SignUpData(_name, _email, _username, _password);

      var response = await AuthAPI.signUp(signUpData);

      if(response.statusCode == 200) {
        success = true;
      }
    }

    return success;
  }

  bool validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
