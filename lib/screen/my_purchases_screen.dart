import 'package:flutter/material.dart';
import '../data/source/vettomy.dart/api_appointments.dart';
import '../domain/auth/models/appointments_model.dart';

class MisComprasScreen extends StatefulWidget {
  @override
  _MisComprasScreenState createState() => _MisComprasScreenState();
}

class _MisComprasScreenState extends State<MisComprasScreen> {
  late Future<List<Appointment>> _appointments;

  final ApiAppointments _apiService = ApiAppointments();

  @override
  void initState() {
    super.initState();
    _appointments = _apiService.fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Appointment>>(
              future: _appointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No appointments available.'));
                } else {
                  final appointments = snapshot.data!;
                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];
                      return ListTile(
                        title: Text('Appointment #${appointment.appointmentNumber}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${appointment.date}'),
                            Text('Time: ${appointment.time}'),
                            Text('Type: ${appointment.type}'),
                            Text('Reason: ${appointment.reason}'),
                            Text('State: ${(appointment.state ?? false) ? "Active" : "Inactive"}'),
                            Text('Branch ID: ${appointment.branchId}'),
                            Text('Pet ID: ${appointment.petId}'),
                            Text('Employee ID: ${appointment.employeeId}'),
                            Text('Service ID: ${appointment.serviceId}'),
                            Text('Schedule ID: ${appointment.scheduleId}'),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
