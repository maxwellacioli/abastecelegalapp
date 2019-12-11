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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            autofocus: true,
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
            decoration: const InputDecoration(
                labelText: 'Sobrenome', hintText: 'Sobrenome'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Surname is required';
              }
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'E-mail', hintText: 'examplo@email.com'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Email is required';
              } else if (!validEmail(value)) {
                return 'Invalid e-mail format';
              }
              print(value);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
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
            decoration: const InputDecoration(
                labelText: 'Password', hintText: 'Password'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Password is required';
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
                onPressed: _submit,
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

  void _submit() {
    _formKey.currentState.validate();
    print('Form submitted');
  }

  bool validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
