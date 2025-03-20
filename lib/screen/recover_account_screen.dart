import 'package:flutter/material.dart';
import '../screen/verify_mail_screen.dart';

class RecuperarCuentaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 60), // Espaciado para evitar notch en dispositivos

          // Título "Dr. Tomy"
          Text(
            "Dr. Tomy",
            style: TextStyle(
              fontSize: 60,
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

          // Subtítulo "Recupera tu cuenta"
          Text(
            "Recupera tu cuenta",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comfortaa',
            ),
          ),

          SizedBox(height: 10),

          // Texto descriptivo
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Introduzca su cuenta de correo electrónico y nosotros enviaremos un enlace para restablecer su contraseña.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
            ),
          ),

          SizedBox(height: 30),

          // Campo de correo electrónico
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Correo electrónico",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Botón "Enviar"
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
                  // Acción de enviar enlace de recuperación
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerificarCorreoScreen()),
                  );
                },
                child: Text(
                  "Enviar",
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

          // Botón "Volver a Inicio"
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Volver a Inicio",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
