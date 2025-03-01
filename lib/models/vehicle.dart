
class Vehicle {

  int id;
  String vehicleType;
  String model;
  String licensePlate;
  double totalDistance;

  Vehicle(String vehicleType, String model, String licensePlate) {
    this.vehicleType = vehicleType;
    this.model = model;
    this.licensePlate = licensePlate;
    this.totalDistance = 0;
  }

  Vehicle.fromJson(Map json) :
        this.id = json['id'],
        this.vehicleType = _vehicleTypeFromJson(json['vehicleType']),
        this.model = json['model'],
        this.licensePlate = json['licensePlate'],
        this.totalDistance = json['totalDistance'];

  Map toJson() {
    return {
      'vehicleType' : _vehicleTypeToJson(vehicleType),
      'model' : model,
      'licensePlate' : licensePlate,
      'totalDistance' : totalDistance
    };
  }

  _vehicleTypeToJson(String type) {
    switch (type) {
      case "CARRO":
        return "CAR";
      case "ÔNIBUS":
        return "BUS";
      case "CAMINHÃO":
        return "TRUCK";
      case "MOTO":
        return "MOTORCYCLE";
      default:
        return null;
    }
  }

  static _vehicleTypeFromJson(String type) {
    switch (type) {
      case "CAR":
        return "CARRO";
      case "BUS":
        return "ÔNIBUS";
      case "TRUCK":
        return "CAMINHÃO";
      case "MOTORCYCLE":
        return "MOTO";
      default:
        return null;
    }
  }
}

