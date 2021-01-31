class LoginRequest {
  final String email;
  String password;

  LoginRequest(this.email, this.password);

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password, 'returnSecureToken': false};
  }
}
