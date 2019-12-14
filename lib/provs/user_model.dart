import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/models/user.dart';

class UserModel extends ChangeNotifier {
  User user;
  Vehicle selectedVehicle;
  List<Vehicle> vehicles;

  UserModel()
    : user = null,
      selectedVehicle = null,
      vehicles = [];

  void addVehicle(Vehicle vehicle) {
    vehicles.add(vehicle);
    notifyListeners();
  }

  void setSelectedVehicle(Vehicle vehicle) {
    this.vehicles = vehicles;
    notifyListeners();
  }

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}