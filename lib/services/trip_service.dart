import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:abastecelegalapp/models/trip.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://abastecelegal.herokuapp.com/api';

class TripService {
  static Future<http.Response> register(
      Trip trip, int vehicleId, String token) async {
    var url = baseUrl + '/vehicles/${vehicleId.toString()}/trips';

    var response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        },
        body: jsonEncode(trip));

    return response;
  }

  static Future<List<Trip>> getTrips(
      int vehicleId, String token, int pageNumber) async {
    Dio dio = new Dio();

    var url = baseUrl + '/vehicles/${vehicleId.toString()}/trips';

    var response = await dio.get(url,
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        }),
        queryParameters: {"page": pageNumber});

    List<dynamic> content = response.data['content'];

    List<Trip> vehicles = content.map((v) => Trip.fromJson(v))
        .toList();

    return vehicles;
  }
}
