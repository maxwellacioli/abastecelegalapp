import 'package:abastecelegalapp/screens/homescreen/components/body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('Veículos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            title: Text('Abastecimentos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Perfil'),
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
