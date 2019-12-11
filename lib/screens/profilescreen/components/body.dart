import 'package:abastecelegalapp/models/user.dart';
import 'package:abastecelegalapp/provs/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = new User(1, 'maxwell', 'Maxwell', 'maxwell.acioli@gmail.com', '');

    final userModel = Provider.of<UserModel>(context);
    userModel.setUser(user);
    
    return Center(
      child: Container(
        child: Text(userModel.getUser().username),
      )
    );
  }
}