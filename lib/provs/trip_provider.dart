
import 'package:abastecelegalapp/models/trip.dart';
import 'package:flutter/cupertino.dart';

class TripProvider extends ChangeNotifier {
  Trip trip;

  TripProvider() :
      trip = null;

  void setTrip(Trip trip) {
    this.trip = trip;
    notifyListeners();
  }
  
}