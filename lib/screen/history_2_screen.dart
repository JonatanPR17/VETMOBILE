import 'package:flutter/material.dart';

class Historial2Screen extends StatelessWidget {
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
            
            // Próximas Vacunas
            _buildSection('Próximas Vacunas', [
              _buildCard('Vacuna contra la rabia', '24 Jan 2025', 'Dr. Tomy Perez'),
              _buildCard('Calicivirus', '12 Feb 2025', 'Dr. Tomy Perez'),
            ]),
            
            // Próximos Tratamientos
            _buildSectionWithBorder('Próximos Tratamientos', [
              _buildCard('Alergia en la piel', '24 Jan 2025', 'Dr. Tomy Perez'),
              _buildCard('Alergia en la piel', '12 Feb 2025', 'Dr. Tomy Perez'),
              _buildCard('Alergia en la piel', '24 Jan 2025', 'Dr. Tomy Perez'),
              _buildCard('Alergia en la piel', '12 Feb 2025', 'Dr. Tomy Perez'),
            ]),
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

  Widget _buildSectionWithBorder(String title, List<Widget> cards) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: cards),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Text('Ver más', style: TextStyle(color: Colors.blue)),
                    Icon(Icons.keyboard_arrow_down, color: Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
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
}
