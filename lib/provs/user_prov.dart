import 'package:abastecelegalapp/models/trip.dart';
import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/models/user.dart';

class UserProvider extends ChangeNotifier {
  User user;
  Vehicle selectedVehicle;
  List<Vehicle> vehicles;
  List<Trip> trips;
  int nextPage;

  void setNextPage(int nextPage) {
    this.nextPage = nextPage;
    notifyListeners();
  }

  void setVehiclePrincipalId(int id) {
    user.id = id;
    notifyListeners();
  }

  UserProvider()
      :
        nextPage = 0,
        user = null,
        selectedVehicle = null,
        vehicles = [],
        trips = [];

  void addVehicle(Vehicle vehicle) {
   this.vehicles.add(vehicle);
   notifyListeners();
  }

  void addVehicles(List<Vehicle> vehicles) {
    this.vehicles = List.from(this.vehicles)..addAll(vehicles);
    notifyListeners();
  }

  void setSelectedVehicle(Vehicle vehicle) {
    this.selectedVehicle = vehicle;
    notifyListeners();
  }

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
