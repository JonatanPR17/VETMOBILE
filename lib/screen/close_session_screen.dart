import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';  // Importa tu pantalla de inicio o login

// Función para cerrar sesión
Future<void> cerrarSesion(BuildContext context) async {
  // Obtén las preferencias compartidas
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Elimina cualquier dato guardado de la sesión (ejemplo: token de acceso)
  await prefs.remove('userToken');  // Aquí eliminas los datos relevantes de tu sesión

  // Redirige al usuario a la pantalla de inicio de sesión
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()), // Cambia según tu lógica
  );
}
