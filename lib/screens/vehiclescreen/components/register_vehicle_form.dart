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

  String _fuelType;
  String _vehicleType;
  String _model;
  String _licensePlate;
  double _currentTotalDistance;

  Widget registerButton () {

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
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue,
                    child: MaterialButton(
                      minWidth: 200.0,
                      onPressed: () async {
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
            onSaved: (value) => _fuelType = value,
            decoration:
            const InputDecoration(labelText: 'Combustível', hintText: 'Gasolina'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Name name is required';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _vehicleType = value,
            decoration: const InputDecoration(
                labelText: 'Tipo', hintText: 'Carro'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email is required';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _model = value,
            decoration: const InputDecoration(
                labelText: 'Modelo', hintText: 'Ford Ka'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _licensePlate = value,
            decoration: const InputDecoration(
                labelText: 'Placa', hintText: 'ABC1234'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Password é necessário';
              }
            },
          ),
          const SizedBox(height: 40.0),
          registerButton(),
        ],
      ),
    );
  }

  Future<bool> _submit() async {
    _formKey.currentState.save();
    bool success = false;

//    if(_formKey.currentState.validate()) {
//      var signUpData = SignUpData(_name, _email, _username, _password);
//
//      var response = await AuthAPI.signUp(signUpData);
//
//      if(response.statusCode == 200) {
//        success = true;
//      }
//    }

    return success;
  }

  bool validEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
