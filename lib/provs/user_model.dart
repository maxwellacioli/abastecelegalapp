import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/models/user.dart';

class UserModel extends ChangeNotifier {
  User user;
  List<Vehicle> vehicles;

  UserModel()
    : user = null,
      vehicles = [];

  void addVehicle(Vehicle vehicle) {
    vehicles.add(vehicle);
  }

  void setUser(User user) {
    this.user = user;

    notifyListeners();
  }
}