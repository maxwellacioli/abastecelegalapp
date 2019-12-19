

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

  Map toJson() {
    return {
      'date' : this.date.toIso8601String(),
      'fuelType' : this.fuelType,
      'city' : this.city,
      'tripDistance' : this.tripDistance,
      'fuelQuantity' : this.fuelQuantity
    };
  }

}