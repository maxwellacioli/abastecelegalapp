

class SignUpData {
  String name;
  String email;
  String username;
  String password;

  SignUpData(this.name, this.email, this.username, this.password);

  Map toJson() {
    return {
      'name' : name,
      'email' : email,
      'username' : username,
      'password' : password
    };
  }
}