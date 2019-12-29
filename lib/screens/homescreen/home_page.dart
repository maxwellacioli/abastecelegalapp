import 'package:abastecelegalapp/screens/profilescreen/profile_page.dart';
import 'package:abastecelegalapp/screens/tripscreen/trip_page.dart';
import 'package:abastecelegalapp/screens/vehiclescreen/vehicle_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Widget> _children = [
    VehiclePage(),
    TripPage(),
    ProfilePage()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: _children[_selectedIndex],
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
