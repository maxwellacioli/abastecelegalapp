

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

  Trip.fromJson(Map<String, dynamic> json) :
      this.id = json['id'],
//      this.date = json['date'],
      this.tripDistance = json['tripDistance'],
      this.fuelQuantity = json['fuelQuantity'],
      this.fuelConsumption = json['fuelConsumption'],
      this.fuelType = json['fuelType'],
      this.city = json['city'],
      this.description = json['description'];


}