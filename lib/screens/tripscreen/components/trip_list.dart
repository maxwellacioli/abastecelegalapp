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
        userProv.selectedVehicle.id, userProv.user.token, userProv.tripNextPage);

    if (this.mounted) {
      setState(() {
        _loading = false;
        userProv.addTrips(trips);
        userProv.setTripNextPage(userProv.tripNextPage + 1);
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
                ],
              ),
            ),
          );
        }
      },
      controller: _controller,
    );
  }

  Widget selectedCarNotDefined() {
    return Center(
      //TODO Definir um texto melhor
      child: Text('Carro principal não definido.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProv = Provider.of<UserProvider>(context);

    if(userProv.selectedVehicle != null) {
      _getData();
    }

    return Scaffold(
      body: Container(
        child: userProv.selectedVehicle != null
            ? _buildList()
            : selectedCarNotDefined(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
