import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Espera de 3 segundos antes de ir a la pantalla principal
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBFD2F8), // Aplica el color de fondo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/perros.gif',
              height: 200,
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/huellas.gif',
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
