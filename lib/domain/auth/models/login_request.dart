class LoginRequest {
  String mail;
  String password;
  LoginRequest({
    required this.mail,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "mail": this.mail,
      "password": this.password,
    };
  }
}
