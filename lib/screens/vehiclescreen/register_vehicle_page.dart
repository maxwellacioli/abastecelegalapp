import 'package:abastecelegalapp/screens/vehiclescreen/components/register_vehicle_form.dart';
import 'package:flutter/material.dart';

class VehicleRegisterPage extends StatefulWidget {
  const VehicleRegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VehicleRegisterPageState createState() => _VehicleRegisterPageState();
}

class _VehicleRegisterPageState extends State<VehicleRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Cadastrar Veículo',
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