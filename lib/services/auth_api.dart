import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://localhost:8080/api/auth";

class API {
  static Future signin() {
    var url = baseUrl + "/signin";
    return http.get(url);
  }

  static Future signup() {
    var url = baseUrl + "/signup";
    return http.get(url);
  }
}