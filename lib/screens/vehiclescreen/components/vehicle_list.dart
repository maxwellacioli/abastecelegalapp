import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/services/veihicle_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        userProv.user.id, userProv.user.token, userProv.vehicleNextPage);

    if (this.mounted) {
      setState(() {
        _loading = false;
        userProv.addVehicles(vehicles);
        userProv.setVehicleNextPage(userProv.vehicleNextPage + 1);
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

          return Container(
            child: Column(
              children: <Widget>[
                new Slidable(
                  key: ValueKey(index),
                  actionPane: SlidableDrawerActionPane(),
                  actions: <Widget>[
                    IconSlideAction(
                      onTap: () async {
                        var response = await VehicleService.setSelectedVehicle(
                            vehicle.id, userProv.user.token);

                        if (response.statusCode == 200) {
                          userProv.setSelectedVehicle(vehicle);
                          userProv.resetTripNextPage();
                          userProv.resetTripList();
                        }
                      },
                      caption: 'Favorito',
                      color: Colors.yellow,
                      icon: Icons.star_border,
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Mais',
                      color: Colors.grey.shade200,
                      icon: Icons.more_horiz,
                    ),
                    IconSlideAction(
                      caption: 'Excluir',
                      color: Colors.red,
                      icon: Icons.delete,
                    ),
                  ],
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(vehicle.model),
                          subtitle: Text(vehicle.licensePlate),
                          leading: Icon(
                            Icons.directions_car
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60.0, right: 60.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                )
              ],
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
