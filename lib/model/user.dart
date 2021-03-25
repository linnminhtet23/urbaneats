class User {
  String id;
  String displayName;
  String email;
  String password;

  User();

  User.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    displayName = data['username'];
    email = data['email'];
    password = data['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': displayName,
      'email': email,
      'password': password
    };
  }
}
