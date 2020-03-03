class User {
  final String id;
  final String email;

  User({this.id, this.email});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        email = data['email'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }
}
