import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vetmobile/domain/auth/models/user_profile.dart';

class EditProfileService {
  final String baseUrl = 'https://www.veterinariatomyhyope.somee.com/api/person/person/';

  // Método para actualizar el nombre y apellido del usuario en la API
  Future<bool> updateUserProfile(UserProfile userProfile) async {
    final url = Uri.parse('$baseUrl${userProfile.id}'); // Construir la URL con el ID del usuario
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'name': userProfile.name,
      'lastName': userProfile.lastName,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return true; // Actualización exitosa
      } else {
        print('Error al actualizar perfil: ${response.statusCode}');
        return false; // Error en la actualización
      }
    } catch (e) {
      print('Error al hacer la solicitud: $e');
      return false; // Error al hacer la solicitud
    }
  }
}
