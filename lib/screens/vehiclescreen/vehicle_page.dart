import 'package:abastecelegalapp/screens/vehiclescreen/components/body.dart';
import 'package:flutter/material.dart';

class VehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){},
        tooltip: 'Adicionar veículo',
        child: Icon(Icons.add),
      ),
    );
  }
}