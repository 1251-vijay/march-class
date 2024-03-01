class AuthModel {
  final String username;
  final String phonenumber;
  final String email;
  final String password;
  final String uid;

  const AuthModel({
    required this.username,
    required this.uid,
    required this.phonenumber,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> tojson() => {
        "username": username,
        "phonenumber": phonenumber,
        "email": email,
        "password": password,
        "uid": uid
      };
}
