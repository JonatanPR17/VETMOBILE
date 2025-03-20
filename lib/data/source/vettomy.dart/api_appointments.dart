import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vetmobile/domain/auth/models/appointments_model.dart';

class ApiAppointments {
  final String baseUrl = 'https://www.veterinariatomyhyope.somee.com/api/pet/appointments';

  // Función para obtener citas (GET)
  Future<List<Appointment>> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => Appointment.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Función para crear una cita (POST)
  Future<bool> createAppointment(Appointment appointment) async {
    final Map<String, dynamic> appointmentData = {
      'appointmentNumber': appointment.appointmentNumber,
      'date': appointment.date,
      'time': appointment.time,
      'type': appointment.type,
      'reason': appointment.reason,
      'state': appointment.state,
      'branchId': appointment.branchId,
      'petId': appointment.petId,
      'employeeId': appointment.employeeId,
      'serviceId': appointment.serviceId,
      'scheduleId': appointment.scheduleId,
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(appointmentData),
      );

      if (response.statusCode == 200) {
        return true; // Cita creada con éxito
      } else {
        throw Exception('Failed to create appointment');
      }
    } catch (e) {
      print('Error creating appointment: $e');
      return false; // Si ocurre un error, retornamos false
    }
  }
}
