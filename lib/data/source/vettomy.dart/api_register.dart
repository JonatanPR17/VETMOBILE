//Future<User?> (Retorna un usuario si se registra correctamente, o null si hay error).
//Si data en la respuesta es un JSON válido, lo convierte en un User.
//Sí, porque espera recibir datos del usuario registrado.
//Puede fallar si data no es un JSON válido.
//Cuando necesitas acceder a los datos del usuario después del registro.

/*import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl =
      "https://www.veterinariatomyhyope.somee.com/api/auth/authentication/register";

  Future<User?> registerUser({
    required String name,
    required String lastName,
    required String mail,
    required String password,
    String type = "Cliente",
  }) async {
    final url = Uri.parse("$_baseUrl?Type=$type");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "lastName": lastName,
          "mail": mail,
          "password": password,
        }),
      );

      print("📡 URL: $url");
      print("📨 Datos enviados: ${jsonEncode({
        "name": name,
        "lastName": lastName,
        "mail": mail,
        "password": password
      })}");
      print("📩 Respuesta recibida: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Usuario registrado con éxito.");

        // ⚠️ Verificamos si data contiene un usuario válido antes de convertirlo
        if (responseData["data"] != null && responseData["data"] is Map) {
          return User.fromJson(responseData["data"]);
        } else {
          print("⚠️ El servidor respondió pero no devolvió datos de usuario.");
          return null;
        }
      } else {
        print("❌ Error al registrar usuario: ${response.body}");

        if (responseData.containsKey('errors')) {
          responseData['errors'].forEach((key, value) {
            print("⚠️ Error en '$key': ${value[0]}");
          });
        } else if (responseData.containsKey('message')) {
          print("⚠️ Mensaje de error: ${responseData['message']}");
        } else {
          print("⚠️ Error desconocido.");
        }

        return null;
      }
    } catch (e) {
      print("🚨 Excepción atrapada: $e");
      return null;
    }
  }
}*/

//Future<bool> (Retorna true si el usuario se registró, false si hubo error).
//Solo verifica si data es true, sin procesar más datos del usuario.
//No lo usa, porque solo necesita saber si el registro fue exitoso o no.
//No hay riesgo de fallo por data, ya que solo revisa si es true o false.
//Cuando solo quieres saber si el registro fue exitoso sin importar los detalles.

/*PRIMERA VERSION
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl =
      "https://www.veterinariatomyhyope.somee.com/api/auth/authentication/register";

  Future<bool> registerUser({
    required String name,
    required String lastName,
    required String mail,
    required String password,
    String type = "Cliente",
  }) async {
    final url = Uri.parse("$_baseUrl?Type=$type");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "lastName": lastName,
          "mail": mail,
          "password": password,
        }),
      );

      print("📡 URL: $url");
      print(
        "📨 Datos enviados: ${jsonEncode({"name": name, "lastName": lastName, "mail": mail, "password": password})}",
      );
      print("📩 Respuesta recibida: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData["data"] == true) {
          print("✅ Usuario registrado con éxito.");
          return true;
        } else {
          print(
            "⚠️ El servidor confirmó el registro pero no devolvió datos del usuario.",
          );
          return true; // El usuario se registró, aunque no se devolvieron datos
        }
      } else {
        print("❌ Error al registrar usuario: ${response.body}");

        if (responseData.containsKey('errors')) {
          responseData['errors'].forEach((key, value) {
            print("⚠️ Error en '$key': ${value[0]}");
          });
        } else if (responseData.containsKey('message')) {
          print("⚠️ Mensaje de error: ${responseData['message']}");
        } else {
          print("⚠️ Error desconocido.");
        }

        return false;
      }
    } catch (e) {
      print("🚨 Excepción atrapada: $e");
      return false;
    }
  }
}*/

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = "www.veterinariatomyhyope.somee.com";

  Future<bool> registerUser({
    required String name,
    required String lastName,
    required String mail,
    required String password,
    String type = "Cliente",
  }) async {
    final queryParameters = {
      'Type': type,
    };

    final uri = Uri.https(_baseUrl, '/api/auth/authentication/register', queryParameters);

    print('Request URL: $uri');

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "lastName": lastName,
          "mail": mail,
          "password": password,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse["data"] == true;
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
