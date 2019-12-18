class User {
  int id;
  String username;
  String name;
  String email;
  String password;
  String token;

  User.token(this.token);

  void setId(int id) {
    this.id = id;
  }

  void setName(String name) {
    this.name = name;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setUsername(String username) {
    this.username = username;
  }

  User(int id, String username, String name, String email, String password) {
    this.id = id;
    this.username = username;
    this.name = name;
    this.email = email;
    this.password = password;
  }

  User.fromJson(Map json)
    :
      this.id = json['id'],
      this.username = json['username'],
      this.name = json['name'],
      this.email = json['email'];

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