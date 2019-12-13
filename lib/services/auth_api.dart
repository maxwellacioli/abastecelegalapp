import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:abastecelegalapp/models/login_data.dart';
import 'package:http/http.dart' as http;
import 'package:abastecelegalapp/models/token_data.dart';

const baseUrl = 'https://abastecelegal.herokuapp.com/api/auth';

class AuthAPI {

  static Future<Token> signIn(LoginData loginData) async {
    var url = baseUrl + '/signin';

    var response =
        await http.post(url,
          headers: {HttpHeaders.CONTENT_TYPE : 'application/json'},
          body: jsonEncode(loginData));

    print("Status >>>> " + response.statusCode.toString());

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Token.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Username or password incorrect');
    }
  }
}