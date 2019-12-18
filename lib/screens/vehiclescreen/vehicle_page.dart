import 'package:abastecelegalapp/screens/vehiclescreen/register_vehicle_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/vehicle_list.dart';

class VehiclePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VehicleList(),
      //foot
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => VehicleRegisterPage()));
        },
        tooltip: 'Adicionar veículo',
        child: Icon(Icons.add),
      ),
    );
  }
}