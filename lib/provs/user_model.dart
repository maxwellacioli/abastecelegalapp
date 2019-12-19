import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/models/user.dart';

class UserModel extends ChangeNotifier {
  User user;
  Vehicle selectedVehicle;

  void setVehiclePrincipalId(int id) {
    user.id = id;
    notifyListeners();
  }

  UserModel()
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
