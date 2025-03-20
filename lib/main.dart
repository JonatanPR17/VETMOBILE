import 'package:flutter/material.dart';
import './screen/splash_screen.dart'; // Importa la pantalla de carga
import './screen/home_screen.dart'; // Importa la pantalla principal
import './screen/login_screen.dart'; //Importa la pantalla de login
import './screen/welcome_screen.dart';
import './screen/new_account_screen.dart';
import './screen/my_account_screen.dart';
import './screen/notifications_screen.dart';
import './screen/configuration_screen.dart';
import 'package:localstorage/localstorage.dart';
import './screen/recover_account_screen.dart';
import './screen/verify_mail_screen.dart';
import './screen/create_new_password_screen.dart';
import './screen/my_pet_screen.dart';
import './screen/history_screen.dart';
import './screen/history_2_screen.dart';
import './screen/my_appointments_screen.dart';
import './screen/create_new_appointments_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veterinaria App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/register': (context) => NuevaCuentaScreen(),
        '/account': (context) => MiCuentaScreen(),
        '/notifications': (context) => NotificacionesScreen(),
        '/configuraciones': (context) => ConfiguracionesScreen(),
        '/recuperar': (context) => RecuperarCuentaScreen(),
        '/verificar': (context) => VerificarCorreoScreen(),
        '/crear': (context) => CrearNuevaContrasenaScreen(),
        '/mascota': (context) => MiMascotaScreen(),
        '/historial': (context) => HistorialScreen(),
        '/historial2': (context) => Historial2Screen(),
        '/citas': (context) => CitasScreen(),
        '/consulta': (context) => ConsultaScreen(),
      },
    );
  }
}
