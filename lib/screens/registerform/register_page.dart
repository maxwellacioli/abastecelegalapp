import 'package:flutter/material.dart';
import 'package:abastecelegalapp/screens/registerform/components/register_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.0,
        brightness: Brightness.dark,
        backgroundColor: Colors.blue,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: RegisterForm(),
        ),
      ),
    );
  }
}