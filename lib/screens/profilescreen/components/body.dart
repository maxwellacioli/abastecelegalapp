import 'package:abastecelegalapp/models/user.dart';
import 'package:abastecelegalapp/provs/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Center(
      child: Container(
        child: Text(userModel.getUser().username),
      )
    );
  }
}