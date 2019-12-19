import 'dart:convert';

import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/services/veihicle_service.dart';
import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  var _licensePlateController = new MaskedTextController(mask: 'AAA0000');

  final _vehicleTypes = ['CARRO', 'MOTO', 'ÔNIBUS', 'CAMINHÃO'];

  int _selectedVehicleType = 0;

  String _model;
  String _licensePlate;

  List<Widget> _buildVehicleType() {
    return _vehicleTypes
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  Widget registerButton() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0),
          ),
          Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue,
                    child: MaterialButton(
                      minWidth: 200.0,
                      onPressed: () async {
                        bool success = await _submit();
                        if (success) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Cadastrar",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Tipo de Veículo",
              style: TextStyle(color: Colors.black),
            ),
          ),
          DirectSelect(
              itemExtent: 35.0,
              selectedIndex: _selectedVehicleType,
              child: MySelectionItem(
                isForList: false,
                title: _vehicleTypes[_selectedVehicleType],
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedVehicleType = index;
                });
              },
              items: _buildVehicleType()),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _model = value,
            decoration:
                const InputDecoration(labelText: 'Modelo', hintText: 'Ford Ka'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _licensePlate = value,
            controller: _licensePlateController,
            decoration:
                const InputDecoration(labelText: 'Placa', hintText: 'ABC1234'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Password é necessário';
              }
            },
          ),
          const SizedBox(height: 40.0),
          registerButton(),
        ],
      ),
    );
  }

  Future<bool> _submit() async {
    var userProv = Provider.of<UserProvider>(context);

    _formKey.currentState.save();
    bool success = false;

    if (_formKey.currentState.validate()) {
      var vehicle = Vehicle(_vehicleTypes[_selectedVehicleType], _model,
          _licensePlate.toUpperCase());

      var response = await VehicleService.register(
          vehicle, userProv.user.id, userProv.user.token);

      if (response.statusCode == 200) {
        success = true;
      }
    }

    return success;
  }

  bool validEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
