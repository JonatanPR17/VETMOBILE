import 'package:flutter/material.dart';
import '../screen/welcome_screen.dart';
import '../screen/recover_account_screen.dart';
import 'custom_drawer.dart'; // Importa el CustomDrawer

class CambiarContrasenaScreen extends StatefulWidget {
  @override
  _CambiarContrasenaScreenState createState() => _CambiarContrasenaScreenState();
}

class _CambiarContrasenaScreenState extends State<CambiarContrasenaScreen> {
  bool _verActual = false;
  bool _verNueva = false;
  bool _verConfirmar = false;
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey para el Scaffold

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la GlobalKey al Scaffold
      backgroundColor: Colors.white,
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey), // Añade el CustomDrawer
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black, size: 30), // Icono del menú
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer(); // Abrir el CustomDrawer
                  },
                ),
                Spacer(),
                Text(
                  "Contraseña",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          _buildPasswordField("Contraseña Actual", _verActual, () {
            setState(() {
              _verActual = !_verActual;
            });
          }),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecuperarCuentaScreen()),
                );
                },
                child: Text(
                  "Olvidé mi contraseña",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
          _buildPasswordField("Nueva Contraseña", _verNueva, () {
            setState(() {
              _verNueva = !_verNueva;
            });
          }),
          _buildPasswordField("Confirmar Nueva Contraseña", _verConfirmar, () {
            setState(() {
              _verConfirmar = !_verConfirmar;
            });
          }),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                child: Text(
                  "Actualizar Cambios",
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
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, bool isVisible, VoidCallback toggle) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          TextField(
            obscureText: !isVisible,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200], // Color de fondo predeterminado (gris)
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2), // Color de enfoque predeterminado
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              suffixIcon: IconButton(
                icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: toggle,
              ),
              labelText: label, // Label siempre visible
            ),
          ),
        ],
      ),
    );
  }
}
