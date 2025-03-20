import 'package:flutter/material.dart';

class HistorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Historial',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs
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
                  onPressed: () {},
                  child: Text(
                    'Recordatorios',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            
            // Vacunas
            _buildSection('Vacunas', [
              _buildCard('Vacuna contra la rabia', '24 Jan 2025', 'Dr. Tomy Perez'),
              _buildCard('Calicivirus', '12 Feb 2025', 'Dr. Tomy Perez'),
            ]),
            
            // Alergias
            _buildSection('Alergias', [
              _buildCard('Alergia en la piel', 'Puede ir acompañado de síntomas gastrointestinales.', 'Dr. Tomy'),
              _buildCard('Alergia Alimentaria', 'Vómitos y diarrea o signos dermatológicos', 'Dr. Tomy'),
            ]),
            
            // Citas
            _buildCitasSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> cards) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Ver más >', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          Wrap(spacing: 8, runSpacing: 8, children: cards),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, String doctor) {
    return Container(
      padding: EdgeInsets.all(12),
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1),
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
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Citas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Cuando programes una cita lo verás aquí. Vamos a configurar tu primera cita.',
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Agregar Cita',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
