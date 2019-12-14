
class Vehicle {
  int id;
  String fuelType;
  String vehicleType;
  String model;
  String licensePlate;
  double currentTotalDistance;

  Vehicle(this.fuelType, this.vehicleType, this.model, this.licensePlate,
            this.currentTotalDistance);

  Vehicle.fromJson(Map json) :
        this.id = json['id'],
        this.fuelType = json['fuelType'],
        this.vehicleType = json['vehicleType'],
        this.model = json['model'],
        this.licensePlate = json['licensePlate'],
        this.currentTotalDistance = json['currentTotalDistance'];

  Map toJson() {
    return {
      'fuelType' : fuelType,
      'vehicleType' : vehicleType,
      'model' : model,
      'licensePlate' : licensePlate,
      'currentTotalDistance' : currentTotalDistance
    };
  }

  void increaseDistance(double distance) {
    this.currentTotalDistance += distance;
  }

}