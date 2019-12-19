import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:abastecelegalapp/models/login_data.dart';
import 'package:abastecelegalapp/models/signup_data.dart';
import 'package:abastecelegalapp/models/user.dart';
import 'package:abastecelegalapp/provs/user_prov.dart';
import 'package:http/http.dart' as http;
import 'package:abastecelegalapp/models/token_data.dart';
import 'package:provider/provider.dart';

const baseUrl = 'https://abastecelegal.herokuapp.com/api/auth';

class AuthAPI {

  static Future<http.Response> signIn(LoginData loginData) async {
    var url = '$baseUrl/signin';
    
    var response =
        await http.post(url,
          headers: {HttpHeaders.CONTENT_TYPE : 'application/json'},
          body: jsonEncode(loginData));

    return response;
  }

  static Future<http.Response> signUp(SignUpData signUpData) async {
    var url = '$baseUrl/signup';

    var response =
    await http.post(url,
        headers: {HttpHeaders.CONTENT_TYPE : 'application/json'},
        body: jsonEncode(signUpData));

    return response;
  }

  static Future<http.Response> me(String token) async {
    var url = '$baseUrl/me';

    var response =
    await http.get(url,
        headers: {HttpHeaders.CONTENT_TYPE : 'application/json',
                HttpHeaders.AUTHORIZATION : token});

    return response;
  }
}