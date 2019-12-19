import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/services/veihicle_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleList extends StatefulWidget {
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  bool _loading = true;

  ScrollController _controller;

  _getData() async {
    var userProv = Provider.of<UserProvider>(context);
    var vehicles = await VehicleService.getVehicles(
        userProv.user.id, userProv.user.token, userProv.nextPage);

    if (this.mounted) {
      setState(() {
        _loading = false;
        userProv.addVehicles(vehicles);
        userProv.setNextPage(userProv.nextPage + 1);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getData();
      }
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _loading ? 1.0 : 0.0,
          child: new CircularProgressIndicator(
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    var userProv = Provider.of<UserProvider>(context);

    return ListView.builder(
      itemCount: userProv.vehicles.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == userProv.vehicles.length) {
          return _buildProgressIndicator();
        } else {
          var vehicle = userProv.vehicles[index];

          return new GestureDetector(
            onTap: () {

              userProv.setSelectedVehicle(userProv.vehicles[index]);
              //TODO Set principal on database
              print(vehicle.id.toString());
            },
            child: Card(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Tipo: " + vehicle.vehicleType,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  new Text("Modelo: " + vehicle.model,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16)),
                  new Text("Placa: " + vehicle.licensePlate,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16)),
                  new Text("Km: " + vehicle.currentTotalDistance.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16)),
                ],
              ),
            ),
          );
        }
      },
      controller: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    _getData();

    return Scaffold(
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
