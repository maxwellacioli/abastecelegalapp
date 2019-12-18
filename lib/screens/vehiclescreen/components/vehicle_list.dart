import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:abastecelegalapp/provs/user_model.dart';
import 'package:abastecelegalapp/services/veihicle_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleList extends StatefulWidget {
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  bool _loading = false;

  int nextPage = 0;

  ScrollController _controller;

  _getData() async {
    if (!_loading) {
      setState(() {
        _loading = true;
      });

      var userModel = Provider.of<UserModel>(context);
      var vehicles = await VehicleService.getVehicles(
          userModel.user.id, userModel.user.token, nextPage);

      setState(() {
        _loading = false;
        userModel.vehicles.addAll(vehicles);
        nextPage = nextPage + 1;
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _loading ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    var userModel = Provider.of<UserModel>(context);
    var vehicles = userModel.vehicles;

    return ListView.builder(
      itemCount: vehicles.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == vehicles.length) {
          return _buildProgressIndicator();
        } else {
          return new ListTile(
            title: Text((vehicles[index].licensePlate)),
            onTap: () {
              print(vehicles[index].id);
            },
          );
        }
      },
      controller: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _getData();
    });

    return Scaffold(
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
