import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/services/trip_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripListPage extends StatefulWidget {
  @override
  _TripListPageState createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  bool _loading = true;

  SlidableController _slidableController;

  ScrollController _controller;

  _getData() async {
    var userProv = Provider.of<UserProvider>(context);
    var trips = await TripService.getTrips(userProv.selectedVehicle.id,
        userProv.user.token, userProv.tripNextPage);

    if (this.mounted) {
      setState(() {
        _loading = false;
        userProv.addTrips(trips);
        userProv.setTripNextPage(userProv.tripNextPage + 1);
      });
    }
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

          return Container(
            child: Column(
              children: <Widget>[
                new Slidable(
                  key: ValueKey(index),
                  controller: _slidableController,
                  actionPane: SlidableDrawerActionPane(),
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
                        title: Text(trip.city),
                        subtitle: Text(trip.fuelType),
                        leading: Icon(Icons.local_gas_station, size: 35.0),
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

  Widget emptyTrips() {
    return Center(
      child: Text('Não abastecimentos cadastrados.'),
    );
  }

  Widget selectedCarNotDefined() {
    return Center(
      child: Text('Não há um veículo preferido definido.'),
    );
  }

  Widget buildPage() {
    var userProv = Provider.of<UserProvider>(context);

    if (userProv.selectedVehicle != null) {
      if (userProv.trips.length == 0) {
        return emptyTrips();
      } else {
        if (userProv.selectedVehicle != null) {
          _getData();
        }
        return  _buildList();
      }
    } else {
      return selectedCarNotDefined();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: buildPage(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
