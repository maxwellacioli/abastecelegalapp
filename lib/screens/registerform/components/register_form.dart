import 'package:abastecelegalapp/models/signup_data.dart';
import 'package:abastecelegalapp/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/screens/login/loginscreen.dart';

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
          const SizedBox(height: 16.0),
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
          const SizedBox(height: 16.0),
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
          const SizedBox(height: 16.0),
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
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                onPressed: () {

                  Navigator.pop(context);
                },
                child: Text("Voltar",
                    textAlign: TextAlign.center,
                    style: style.copyWith(color: Colors.white)),
              ),
              const Spacer(),
              MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  bool success = await _submit();
                  if(success) {
                      Navigator.pop(context);
                    }
                  },
                child: Text("Cadastrar",
                    textAlign: TextAlign.center,
                    style: style.copyWith(color: Colors.white)),
              ),
            ],
          ),
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
