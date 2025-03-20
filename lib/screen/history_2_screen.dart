import 'package:flutter/material.dart';
import 'custom_drawer.dart';  // Asegúrate de tener esta clase para el drawer
import '../screen/history_screen.dart';

class Historial2Screen extends StatefulWidget {
  @override
  _Historial2ScreenState createState() => _Historial2ScreenState();
}

class _Historial2ScreenState extends State<Historial2Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey), // Custom Drawer
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              // Row para el icono del menú y el título centrado
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.black, size: 30),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  Spacer(),
                  Text(
                    "Historial",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                    onPressed: () {
                      Navigator.pop(context); // Retroceder a la pantalla anterior
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Tabs de "Actual" y "Recordatorios"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HistorialScreen()),
                      );
                    },
                    child: Text(
                      'Actual',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Recordatorios',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Sección de Próximas Vacunas envuelta en tarjeta
              _buildSectionCard('Próximas Vacunas', [
                _buildCard('Vacuna contra la rabia', '24 Jan 2025', 'Dr. Tomy Perez'),
                _buildCard('Calicivirus', '12 Feb 2025', 'Dr. Tomy Perez'),
              ]),

              // Sección de Próximos Tratamientos envuelta en tarjeta
              _buildSectionCard('Próximos Tratamientos', [
                _buildCard('Alergia en la piel', '24 Jan 2025', 'Dr. Tomy Perez'),
                _buildCard('Alergia en la piel', '12 Feb 2025', 'Dr. Tomy Perez'),
                _buildCard('Alergia en la piel', '24 Jan 2025', 'Dr. Tomy Perez'),
                _buildCard('Alergia en la piel', '12 Feb 2025', 'Dr. Tomy Perez'),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // Sección envuelta en tarjeta, similar a HistorialScreen
  Widget _buildSectionCard(String title, List<Widget> cards) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),  // Reducido el espacio entre secciones
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 6, spreadRadius: 2),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver más >', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            Column(
              children: cards,
            ),
          ],
        ),
      ),
    );
  }

  // Card individual, se mantiene igual a HistorialScreen
  Widget _buildCard(String title, String subtitle, String doctor) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 2),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(subtitle, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5),
          Text(doctor, style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}
