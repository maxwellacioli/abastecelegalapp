import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:abastecelegalapp/models/trip.dart';
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
}
