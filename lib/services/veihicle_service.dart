import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:abastecelegalapp/models/vehicle.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://abastecelegal.herokuapp.com/api';

class VehicleService {
  static Future<http.Response> register(
      Vehicle vehicle, int userId, String token) async {
    var url = baseUrl + '/users/${userId.toString()}/vehicles';

    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        },
        body: jsonEncode(vehicle));

    return response;
  }

  static Future<Response> findUserVehicles(
      int userId, String token) async {
    Dio dio = new Dio();

    var url = baseUrl + '/users/${userId.toString()}/vehicles';

    var response = await dio.get(url,
        options: Options(
          headers: {
            Headers.contentTypeHeader : 'application/json',
            HttpHeaders.authorizationHeader : token
          }
        ),
        queryParameters: {"page": 0});

    return response;
  }
}
