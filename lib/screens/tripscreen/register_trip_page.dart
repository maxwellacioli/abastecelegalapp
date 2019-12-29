import 'package:flutter/material.dart';
import 'components/register_trip_form.dart';

class TripRegisterPage extends StatefulWidget {
  @override
  _TripRegisterPageState createState() => _TripRegisterPageState();
}

class _TripRegisterPageState extends State<TripRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Abastecimento',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.blue,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: RegisterTripForm(),
        ),
      ),
    );
  }
}
