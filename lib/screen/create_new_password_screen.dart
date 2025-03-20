import 'package:flutter/material.dart';
import '../screen/login_screen.dart';

class CrearNuevaContrasenaScreen extends StatefulWidget {
  @override
  _CrearNuevaContrasenaScreenState createState() =>
      _CrearNuevaContrasenaScreenState();
}

class _CrearNuevaContrasenaScreenState
    extends State<CrearNuevaContrasenaScreen> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80), // Espaciado superior para evitar el notch

            // Imagen superior
            Image.asset(
              'assets/images/logo_company.jpg', // Asegúrate de agregar esta imagen a tu proyecto
              width: 180,
              height: 120,
            ),

            SizedBox(height: 30),

            // Título
            Text(
              "Crea tu nueva contraseña",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),

            SizedBox(height: 10),

            // Subtítulo
            Text(
              "Escribe una nueva contraseña para iniciar sesión.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
            ),

            SizedBox(height: 30),

            // Campo de contraseña
            TextField(
              obscureText: _obscureText1,
              decoration: InputDecoration(
                hintText: "Contraseña",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText1 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            // Campo de confirmar contraseña
            TextField(
              obscureText: _obscureText2,
              decoration: InputDecoration(
                hintText: "Confirmar contraseña",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 30),

            // Botón "Crear"
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Acción de crear nueva contraseña
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                },
                child: Text(
                  "Crear",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
