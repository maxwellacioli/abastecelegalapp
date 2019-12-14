import 'package:abastecelegalapp/models/user.dart';
import 'package:abastecelegalapp/provs/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget buildList() {
      var userModel = Provider.of<UserModel>(context);

      if(userModel.vehicles.isEmpty) {
        return Text('Lista vazia');
      } else {
        return Text('Lista não vazia');
      }
    }


    return Center(
        child: Container(
          child: buildList(),
        )
    );
  }
}