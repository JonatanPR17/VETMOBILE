import 'package:vetmobile/domain/auth/models/rol.dart';

class UserProfile {
  int? id;
  String? name;
  String? lastName;
  String? mail;
  Rol? rol;

  UserProfile({this.id, this.name, this.lastName, this.mail, this.rol});

  // Crear un objeto UserProfile a partir de un Map JSON
  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    mail = json['mail'];
    rol = json['rol'] != null ? Rol.fromJson(json['rol']) : null;
  }

  // Convertir el objeto UserProfile a un Map para enviarlo a la API
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['mail'] = this.mail;
    if (this.rol != null) {
      data['rol'] = this.rol!.toJson();
    }
    return data;
  }
}
