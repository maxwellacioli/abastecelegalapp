import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://abastecelegal.herokuapp.com/api';

class VehicleService {
  static Future<http.Response> register(
      Vehicle vehicle, int userId, String token) async {
    var url = baseUrl + '/users/${userId.toString()}/vehicles';

    var response = await http.post(url,
        headers: {
          HttpHeaders.CONTENT_TYPE: 'application/json',
          HttpHeaders.AUTHORIZATION: token
        },
        body: jsonEncode(vehicle));

    return response;
  }

  static Future<http.Response> findUserVehicles(
      int userId, String token) async {

    var url = baseUrl + '/users/${userId.toString()}/vehicles';

    var response = await http.get(url,
        headers: {
          HttpHeaders.CONTENT_TYPE: 'application/json',
          HttpHeaders.AUTHORIZATION: token
        });

    return response;
  }
}
