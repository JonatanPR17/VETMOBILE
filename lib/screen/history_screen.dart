import 'package:flutter/material.dart';
import 'custom_drawer.dart';  // Asegúrate de tener esta clase para el drawer
import '../screen/history_2_screen.dart';
import '../screen/create_new_appointments_screen.dart'; // Importa la pantalla de Crear Nueva Cita

class HistorialScreen extends StatefulWidget {
  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
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
                    onPressed: () {},
                    child: Text(
                      'Actual',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Historial2Screen()),
                      );
                    },
                    child: Text(
                      'Recordatorios',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Sección de Vacunas envuelta en tarjeta
              _buildSectionCard('Vacunas', [
                _buildCard('Vacuna contra la rabia', '24 Jan 2025', 'Dr. Tomy Perez'),
                _buildCard('Calicivirus', '12 Feb 2025', 'Dr. Tomy Perez'),
              ]),

              // Sección de Alergias envuelta en tarjeta
              _buildSectionCard('Alergias', [
                _buildCard('Alergia en la piel', 'Puede ir acompañado de síntomas gastrointestinales.', 'Dr. Tomy'),
                _buildCard('Alergia Alimentaria', 'Vómitos y diarrea o signos dermatológicos', 'Dr. Tomy'),
              ]),

              // Sección de Citas envuelta en tarjeta
              _buildCitasSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Sección envolvente con tarjeta
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

  Widget _buildCitasSection() {
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
            Text(
              'Citas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Cuando programes una cita lo verás aquí. Vamos a configurar tu primera cita.',
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 10),
            // Aquí se hace el cambio para que el botón se vea igual que en CitasScreen
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConsultaScreen()),  // Asegúrate de tener esta pantalla
                    );
                  },
                  child: Text(
                    'Agregar Cita',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
