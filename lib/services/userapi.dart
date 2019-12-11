import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://localhost:8080/api/";

class API {
  static Future getUsers() {
    var url = baseUrl + "/users";
    return http.get(url);
  }

  static Future loginUser() {

  }
}