import 'package:flutter/material.dart';
import 'custom_drawer.dart'; // Importa el CustomDrawer

class NotificacionesScreen extends StatefulWidget {
  @override
  _NotificacionesScreenState createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  // Estado de los switches
  Map<String, bool> _switchValues = {
    "Notificación General": true,
    "Sonido": true,
    "Vibrar": false,
    "Ofertas Especiales": false,
    "Pagos": true,
    "Promoción y descuento": false,
  };

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
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black, size: 30), // Icono del menú
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer(); // Abrir el CustomDrawer
                  },
                ),
                Spacer(),
                Text(
                  "Notificaciones",
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
          Expanded(
            child: ListView(
              children: _switchValues.keys.map((String key) {
                return _buildSwitchOption(key);
              }).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Color(0xFFD0E4FF),
            child: Center(
              child: Text(
                "Sistema Médico - Equipo 3",
                style: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'Comfortaa',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchOption(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Comfortaa',
            ),
          ),
          Switch(
            value: _switchValues[title]!,
            onChanged: (bool newValue) {
              setState(() {
                _switchValues[title] = newValue;
              });
            },
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
