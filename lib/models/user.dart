class User {
  int id;
  String username;
  String name;
  String email;
  String password;
  int principalId;
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

  void setPrincipalId(int id) {
    this.principalId = id;
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
      this.email = json['email'],
      this.principalId = json['principalId'];

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