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

  SlidableController _slidableController;

  _getData() async {
    var userProv = Provider.of<UserProvider>(context, listen: false);
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
    _slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );

    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getData();
      }
    });

    _getData();
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
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
                  controller: _slidableController,
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
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: ListTile(
                        title: Text(vehicle.model),
                        subtitle: Text(vehicle.licensePlate),
                        leading: Icon(
                            Icons.directions_car
                            , size: 35.0),
                        isThreeLine: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70.0),
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

  Widget _buildPage() {
    var userProv = Provider.of<UserProvider>(context);

    if(userProv.vehicles.length == 0) {
      return Center(
        child: Text(
          'Não há veículos cadastrados.'
        ),
      );
    }
    
    return _buildList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: _buildPage(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
