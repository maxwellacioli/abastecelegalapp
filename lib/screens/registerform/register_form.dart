import 'package:flutter/material.dart';

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
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Name name is required';
              }
            },
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  print('I was registered!');
                },
                child: Text("Cadastrar",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white)),
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
}