import 'package:flutter/material.dart';
import '../screen/create_new_appointments_screen.dart';
import 'custom_drawer.dart'; // Importa el CustomDrawer

class CitasScreen extends StatefulWidget {
  @override
  _CitasScreenState createState() => _CitasScreenState();
}

class _CitasScreenState extends State<CitasScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Almacena las citas
  Map<DateTime, List<String>> appointments = {
    _normalizeDate(DateTime(2025, 3, 18)): ["Consulta con Dr. Olivia Turner", "Chequeo anual"],
    _normalizeDate(DateTime(2025, 3, 20)): ["Vacunación de mascotas"],
  };

  DateTime selectedDay = DateTime.now(); // Día seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.black, size: 30),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  Spacer(),
                  Text(
                    "Mis Citas",
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
            _buildCalendar(),
            _buildAppointmentInfo(),
            _buildVeterinariosSection(),
            _buildDoctorsList(),
            _buildAddAppointmentButton(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    DateTime now = DateTime.now(); // Fecha actual
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Inicio de la semana

    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          DateTime day = startOfWeek.add(Duration(days: index)); // Días consecutivos
          bool isToday = _normalizeDate(day) == _normalizeDate(DateTime.now());
          bool isSelected = _normalizeDate(day) == _normalizeDate(selectedDay);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = day;
              });
            },
            child: _buildCalendarDay(
              '${day.day}', // Día del mes
              ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB'][index], // Etiquetas que comienzan con lunes
              isToday,
              isSelected,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCalendarDay(String day, String label, bool isToday, bool isSelected) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue
                : isToday
                    ? Colors.blue.shade200
                    : Colors.white,
            shape: BoxShape.circle,
          ),
          child: Text(
            day,
            style: TextStyle(
              color: isSelected || isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildAppointmentInfo() {
    DateTime normalizedSelectedDay = _normalizeDate(selectedDay); // Normaliza la fecha seleccionada
    List<String> dayAppointments = appointments[normalizedSelectedDay] ?? ["No hay citas para este día"];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centra el contenido
        children: [
          Text(
            "Citas para el ${normalizedSelectedDay.day}/${normalizedSelectedDay.month}/${normalizedSelectedDay.year}",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ...dayAppointments.map((appointment) => Card(
                child: ListTile(
                  title: Text(
                    appointment,
                    textAlign: TextAlign.center, // Centra el texto
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildVeterinariosSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        "Nuestros Veterinarios",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        textAlign: TextAlign.center, // Centra el texto
      ),
    );
  }

  Widget _buildDoctorsList() {
    List<Map<String, dynamic>> doctors = [
      {'name': 'Dr. Tomy Perez Huamani', 'rating': '5', 'reviews': '60'},
      {'name': 'Dr. Alexander Bennett', 'rating': '4.5', 'reviews': '40'},
      {'name': 'Dr. Sophia Martinez', 'rating': '5', 'reviews': '150'},
      {'name': 'Dr. Michael Davidson', 'rating': '4.8', 'reviews': '90'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: doctors.map((doctor) => _buildDoctorCard(doctor)).toList(),
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/doctor.jpg'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Veterinario', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text('${doctor['rating']}  (${doctor['reviews']})'),
                SizedBox(width: 10),
                Icon(Icons.favorite_border, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddAppointmentButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConsultaScreen()),
            );
          },
          child: Text(
            'Agregar Nueva Cita',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day); // Normaliza la fecha
  }
}
