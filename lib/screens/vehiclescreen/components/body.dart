import 'package:abastecelegalapp/models/user.dart';
import 'package:abastecelegalapp/provs/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {

  Widget buildList(UserModel userModel) {
    var user = userModel.user;

    if(user.vehicles.isEmpty) {
      return Text('Lista vazia');
    } else {
      return Text('Lista não vazia');
    }
  }

  @override
  Widget build(BuildContext context) {

    var userModel = Provider.of<UserModel>(context);

    return Center(
        child: Container(
          child: buildList(userModel),
        )
    );
  }
}