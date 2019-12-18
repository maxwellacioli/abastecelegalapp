import 'package:abastecelegalapp/models/vehicle.dart';

class VehicleList {
  List<Vehicle> vehicles;
  int totalPages;
  int totalVehicles;
  int numberOfVehicles;
  int pageSize;
  int pageNumber;
  bool emptyPage;
  bool firstPage;
  bool lastPage;

  VehicleList(
      this.vehicles,
      this.totalPages,
      this.totalVehicles,
      this.numberOfVehicles,
      this.pageSize,
      this.pageNumber,
      this.emptyPage,
      this.firstPage,
      this.lastPage);

  VehicleList.fromJson(Map<String, dynamic> json) {
    var vehicleList = json['content'] as List;

    this.vehicles = vehicleList.map((v) => Vehicle.fromJson(v)).toList();
    this.totalPages = json['totalPages'];
    this.totalVehicles = json['totalElements'];
    this.numberOfVehicles = json['numberOfElements'];
    this.pageSize = json['size'];
    this.pageNumber = json['number'];
    this.emptyPage = json['empty'];
    this.firstPage = json['first'];
    this.lastPage = json['last'];
  }

//  VehicleList.fromJson(Map<String, dynamic> json) :
//    this.vehicles = json['content'],
//    this.totalPages = json['totalPages'],
//    this.totalVehicles = json['totalElements'],
//    this.numberOfVehicles = json['numberOfElements'],
//    this.pageSize = json['size'],
//    this.pageNumber = json['number'],
//    this.emptyPage = json['empty'],
//    this.firstPage = json['first'],
//    this.lastPage = json['last'];

}
