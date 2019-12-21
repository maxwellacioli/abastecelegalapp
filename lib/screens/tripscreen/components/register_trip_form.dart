import 'package:abastecelegalapp/models/trip.dart';
import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:abastecelegalapp/services/trip_service.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterTripForm extends StatefulWidget {
  const RegisterTripForm({Key key}) : super(key: key);

  @override
  _RegisterTripFormState createState() => _RegisterTripFormState();
}

class _RegisterTripFormState extends State<RegisterTripForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  final _city = ['MACEIO', 'PALMEIRA'];
  final _fuelType = ['GASOLINE', 'ALCOHOL', 'DIESEL'];

  int _selectedCity = 0;
  int _selectedFuelType = 0;

//  String _date;
  double _fuelQuantity;
  double _tripDistance;

  List<Widget> _buildFuelType() {
    return _fuelType
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  List<Widget> _buildCity() {
    return _city
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
            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Text(
              "Cidade",
              style: TextStyle(color: Colors.black),
            ),
          ),
          DirectSelect(
              itemExtent: 35.0,
              selectedIndex: _selectedCity,
              child: MySelectionItem(
                isForList: false,
                title: _city[_selectedCity],
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedCity = index;
                });
              },
              items: _buildCity()),
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Text(
              "Tipo de Combustível",
              style: TextStyle(color: Colors.black),
            ),
          ),
          DirectSelect(
              itemExtent: 35.0,
              selectedIndex: _selectedFuelType,
              child: MySelectionItem(
                isForList: false,
                title: _fuelType[_selectedFuelType],
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedFuelType = index;
                });
              },
              items: _buildFuelType()),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _tripDistance = double.parse(value),
            decoration:
                const InputDecoration(labelText: 'Distância', hintText: '0.0'),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Username is required';
              }
            },
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            onSaved: (value) => _fuelQuantity = double.parse(value),
            decoration:
                const InputDecoration(labelText: 'Quantidade', hintText: '0.0'),
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
      var trip = Trip(_city[_selectedCity], _fuelQuantity, _tripDistance,
          _fuelType[_selectedFuelType]);

      var response = await TripService.register(trip, 1, userProv.user.token);

      if(response.statusCode == 200) {
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
