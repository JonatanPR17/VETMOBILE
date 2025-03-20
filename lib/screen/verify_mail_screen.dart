import 'package:flutter/material.dart';
import '../screen/create_new_password_screen.dart';

class VerificarCorreoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60), // Espaciado para evitar notch

          // Título "Dr. Tomy"
          Text(
            "Dr. Tomy",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comfortaa',
            ),
          ),

          SizedBox(height: 10),

          Stack(
            alignment: Alignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xFF159EEC),
                    Colors.transparent
                  ],
                  stops: [0.0, 0.5, 1.0],
                ).createShader(bounds),
                child: Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Color(0xFF159EEC),
                        Colors.transparent
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/logo_company.jpg'),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Mensaje principal
          Text(
            "¡Listo! Revisa tu correo.",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comfortaa',
            ),
          ),

          SizedBox(height: 10),

          // Descripción
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Esta acción requiere una verificación de correo. Por favor revisa tu buzón de correo y sigue las instrucciones enviadas.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
            ),
          ),

          SizedBox(height: 30),

          // Imagen del sobre
          Image.asset(
            'assets/images/logo_company.jpg', // Asegúrate de agregar esta imagen en tu proyecto
            width: 120,
            height: 120,
          ),

          SizedBox(height: 30),

          // Botón "Ingresar"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Acción de ingresar
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrearNuevaContrasenaScreen()),
                );
                },
                child: Text(
                  "Ingresar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Opción de reenviar correo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No has recibido el mensaje? "),
              GestureDetector(
                onTap: () {
                  // Acción de reenviar
                },
                child: Text(
                  "Reenviar",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
