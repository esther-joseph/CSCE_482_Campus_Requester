class User {
  final int id;
  final String username;
  final String password;
  final String jwtToken;
  final String email;

  User({this.username, this.password, this.jwtToken, this.id, this.email});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        password = data['password'],
        email = data['email'],
        jwtToken = data['jwtToken'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'jwtToken': jwtToken
    };
  }
}
