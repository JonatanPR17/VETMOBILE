import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: Column(
        children: [
          SizedBox(height: 40), // Espacio superior
          Text(
            "Dr. Tomy",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
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
          Image.asset(
            'assets/images/perro_home.png',
            height: 300, // Imagen del perro
          ),
          Expanded(
              child: SizedBox()), // Empuja los botones más abajo sin romper
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/login'); // Acción de ingresar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                    ),
                    child: Text(
                      "Ingresar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit'),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }, // Acción de registrarse
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: EdgeInsets.symmetric(vertical: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                    child: Text(
                      "Registrarme",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 50), // Ajusta este valor para mover los botones más abajo
        ],
      ),
    );
  }
}
