import 'package:abastecelegalapp/models/trip.dart';
import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:abastecelegalapp/models/user.dart';

class UserProvider extends ChangeNotifier {
  User user;
  Vehicle selectedVehicle;
  List<Vehicle> vehicles;
  List<Trip> trips;
  int vehicleNextPage;
  int tripNextPage;

  void setVehicleNextPage(int nextPage) {
    this.vehicleNextPage = nextPage;
    notifyListeners();
  }

  void setVehiclePrincipalId(int id) {
    user.id = id;
    notifyListeners();
  }

  void setTripNextPage(int nextPage) {
    this.tripNextPage = nextPage;
    notifyListeners();
  }

  void resetTripList() {
    this.trips = [];
    notifyListeners();
  }

  void resetTripNextPage() {
    this.tripNextPage = 0;
    notifyListeners();
  }

  UserProvider()
      :
        tripNextPage = 0,
        vehicleNextPage = 0,
        user = null,
        selectedVehicle = null,
        vehicles = [],
        trips = [];

  void addVehicle(Vehicle vehicle) {
   this.vehicles.add(vehicle);
   notifyListeners();
  }

  void addVehicles(List<Vehicle> vehicles) {
    this.vehicles = List.from(this.vehicles)..addAll(vehicles);
    notifyListeners();
  }

  void addTrip(Trip trip) {
    this.trips.add(trip);
    notifyListeners();
  }

  void addTrips(List<Trip> trips) {
    this.trips = List.from(this.trips)..addAll(trips);
    notifyListeners();
  }

  void setSelectedVehicle(Vehicle vehicle) {
    this.selectedVehicle = vehicle;
    notifyListeners();
  }

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
