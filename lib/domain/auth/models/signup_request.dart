class SignupRequest {
  String mail;
  String password;
  String name;
  String lastName;
  String documentType;
  String documentNumber;

  SignupRequest({
    required this.mail,
    required this.password,
    required this.name,
    required this.lastName,
    required this.documentType,
    required this.documentNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "mail": this.mail,
      "password": this.password,
      "name": this.name,
      "lastName": this.lastName,
      "documentType": this.documentType,
      "documentNumber": this.documentNumber,
    };
  }
}
