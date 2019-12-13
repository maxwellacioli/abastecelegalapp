
class LoginData {
  String username;
  String password;

  LoginData(String username, String password) {
    this.username = username;
    this.password = password;
  }

  Map toJson() {
    return {
      'username' : username,
      'password' : password
    };
  }
}