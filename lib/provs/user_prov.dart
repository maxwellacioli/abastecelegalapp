import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/models/user.dart';

class UserProvider extends ChangeNotifier {
  User user;
  Vehicle selectedVehicle;

  void setVehiclePrincipalId(int id) {
    user.id = id;
    notifyListeners();
  }

  UserProvider()
      : user = null,
        selectedVehicle = null;

  void setSelectedVehicle(Vehicle vehicle) {
    this.selectedVehicle = vehicle;
    notifyListeners();
  }

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
