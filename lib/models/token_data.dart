
class Token {
  String type;
  String token;
  
  Token(String type, String token) {
    this.type = type;
    this.token = token;
  }
  
  String getToken() {
    return type + " " + token;
  }

  Token.fromJson(Map<String, dynamic> json)
      :
        type = json['type'],
        token = json['token'];

}