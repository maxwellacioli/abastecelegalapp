import 'package:meta/meta.dart';

class User {
  int id;
  String username;
  String name;
  String email;
  String password;

  User(int id, String username, String name, String email, String password) {
    this.id = id;
    this.username = username;
    this.name = name;
    this.email = email;
    this.password = password;
  }

  User.fromJson(Map json)
    :
      id = json['id'],
      username = json['username'],
      name = json['name'],
      email = json['email'];

  Map toJson() {
    return {
      'id' : id,
      'username' : username,
      'name' : name,
      'email' : email,
      'password' : password
    };
  }
}