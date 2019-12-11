import 'package:flutter/material.dart';
import 'package:abastecelegalapp/models/user.dart';

class UserModel extends ChangeNotifier {
  User user;

  getUser() => user;

  void setUser(User user) {
    this.user = user;

    notifyListeners();
  }
}