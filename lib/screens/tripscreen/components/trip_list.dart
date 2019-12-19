import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/services/trip_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripListPage extends StatefulWidget {
  @override
  _TripListPageState createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  bool _loading = true;

  ScrollController _controller;

  _getData() async {
    var userProv = Provider.of<UserProvider>(context);
    var trips = await TripService.getTrips(
        userProv.selectedVehicle.id, userProv.user.token, userProv.nextPage);

    if (this.mounted) {
      setState(() {
        _loading = false;
//        userProv.addVehicles(vehicles);
//        userProv.setNextPage(userProv.nextPage + 1);
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
      itemCount: userProv.trips.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == userProv.trips.length) {
          return _buildProgressIndicator();
        } else {
          var trip = userProv.trips[index];

          return new GestureDetector(
            onTap: () {
              print(trip.id.toString());
            },
            child: Card(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Id: " + trip.id.toString(),
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//                  new Text("Modelo: " + vehicle.model,
//                      style: TextStyle(
//                          fontWeight: FontWeight.normal, fontSize: 16)),
//                  new Text("Placa: " + vehicle.licensePlate,
//                      style: TextStyle(
//                          fontWeight: FontWeight.normal, fontSize: 16)),
//                  new Text("Km: " + vehicle.currentTotalDistance.toString(),
//                      style: TextStyle(
//                          fontWeight: FontWeight.normal, fontSize: 16)),
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
