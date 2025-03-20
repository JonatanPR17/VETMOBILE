import 'package:flutter/material.dart';
import 'custom_drawer.dart';  // Importa la clase CustomDrawer

class MiMascotaScreen extends StatelessWidget {
  // Creamos la GlobalKey para el Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  // Asigna la GlobalKey al Scaffold
      backgroundColor: Colors.white,
      // Agregamos el CustomDrawer al Scaffold
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección de imagen de la mascota con el ícono del menú encima
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/perro.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,  // Ajusta la posición del ícono 
                  left: 20,  // Espacio de 20 pixeles a la izquierda
                  child: IconButton(
                    icon: Icon(Icons.menu, size: 30, color: Colors.black87), // Tamaño 30 y color igual al primer código
                    onPressed: () {
                      // Usamos la GlobalKey para abrir el Drawer
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
              ],
            ),

            // Contenedor con nombre, raza y los iconos alineados a la derecha
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  // Nombre y raza alineados a la izquierda
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bella',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Border Collie',
                        style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                      ),
                    ],
                  ),
                  Spacer(),  // Esto empuja los iconos hacia la derecha

                  // Íconos de editar y género alineados a la derecha
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                      SizedBox(height: 10),  // Espacio entre los íconos
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.female, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sección de detalles
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Acerca de Bella
                  Row(
                    children: [
                      Icon(Icons.pets, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Acerca de Bella',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Centrado de la sección de chips (Edad, Peso, Altura, Color)
                  Center(
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        _buildInfoChip('Edad', '1y 4m 11d'),
                        _buildInfoChip('Peso', '7.5 kg'),
                        _buildInfoChip('Altura', '54 cm'),
                        _buildInfoChip('Color', 'Negro'),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),
                  Text(
                    'Mi primer perro, que me regaló mi madre cuando cumplí 20 años.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),

                  // Estado de Bella
                  Row(
                    children: [
                      Icon(Icons.health_and_safety, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Estado de Bella',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  _buildEstadoItem(
                      Icons.favorite, 'Salud', 'Anormal', 'Contactar Vet'),
                  _buildEstadoItem(Icons.fastfood, 'Alimentación', 'Hambrienta',
                      'Ir a la tienda'),
                  _buildEstadoItem(Icons.history, 'Historial', '', 'Ver historial'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      width: 100, // Tamaño fijo para todos los chips
      padding: EdgeInsets.all(8), // Relleno dentro del contenedor
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2), // Color de fondo con opacidad
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Estilo del texto para el label
          ),
          SizedBox(height: 4), // Espacio entre el label y el valor
          Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.black87), // Estilo del texto para el valor
          ),
        ],
      ),
    );
  }

  Widget _buildEstadoItem(
      IconData icon, String title, String subtitle, String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          Spacer(),
          _buildActionButton(buttonText, Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8),
        minimumSize: Size(150, 40), // Tamaño fijo para el botón (ancho, altura)
      ),
      onPressed: () {},
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}
