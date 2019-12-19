import 'package:abastecelegalapp/screens/tripscreen/components/body.dart';
import 'package:abastecelegalapp/screens/tripscreen/register_trip_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => TripRegisterPage()));
        },
        tooltip: 'Adicionar veículo',
        child: Icon(Icons.add),
      ),
    );
  }
}