

class Trip {

  int id;
  DateTime date;
  double tripDistance;
  double fuelQuantity;
  double fuelConsumption;
  String fuelType;
  String city;
  String description;

  Trip(this.city, this.fuelQuantity, this.tripDistance, this.fuelType) {
    this.date = DateTime.now();
  }

}