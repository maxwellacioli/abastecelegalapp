import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://abastecelegal.herokuapp.com/api';

class VehicleService {
  static Future<http.Response> register(Vehicle vehicle, int userId,
      String token) async {
    var url = baseUrl + '/users/${userId.toString()}/vehicles';

    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        },
        body: jsonEncode(vehicle));

    return response;
  }

  static Future<List<Vehicle>> getVehicles(int userId, String token,
      int pageNumber) async {
    Dio dio = new Dio();

    var url = baseUrl + '/users/${userId.toString()}/vehicles';

    var response = await dio.get(url,
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        }),
        queryParameters: {"page": pageNumber});

    List<dynamic> content = response.data['content'];

    List<Vehicle> vehicles = content.map((v) => Vehicle.fromJson(v))
        .toList();

    return vehicles;
  }

  static Future<Response> findUserVehicles(int userId, String token,
      int pageNumber) async {
    Dio dio = new Dio();

    var url = baseUrl + '/users/${userId.toString()}/vehicles';

    var response = await dio.get(url,
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        }),
        queryParameters: {"page": pageNumber});

    return response;
  }

  static Future<Response> setSelectedVehicle(int vehicleId, String token) async {
    Dio dio = new Dio();

    var url = baseUrl + '/users/vehicles/${vehicleId.toString()}';

    var response = await dio.put(url,
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        }),
    );

    return response;
  }
}
