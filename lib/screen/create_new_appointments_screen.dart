import 'package:flutter/material.dart';
import '../data/source/vettomy.dart/api_appointments.dart';
import '../domain/auth/models/appointments_model.dart';
import 'custom_drawer.dart';

class ConsultaScreen extends StatefulWidget {
  @override
  _ConsultaScreenState createState() => _ConsultaScreenState();
}

class _ConsultaScreenState extends State<ConsultaScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  final TextEditingController _petIdController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _serviceIdController = TextEditingController();
  final TextEditingController _scheduleIdController = TextEditingController();

  final ApiAppointments _apiService = ApiAppointments();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 14)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";
      });
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) => value!.isEmpty ? 'Por favor ingrese $label' : null,
      ),
    );
  }

  Widget _buildTextFieldWithIconInside({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    VoidCallback? onIconPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
          suffixIcon: IconButton(
            icon: Icon(icon, color: Colors.blue),
            onPressed: onIconPressed,
          ),
        ),
        validator: (value) => value!.isEmpty ? 'Por favor ingrese $label' : null,
      ),
    );
  }

  Future<void> _createAppointment() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final appointment = Appointment(
          appointmentNumber: 0,
          date: _dateController.text,
          time: _timeController.text,
          type: _typeController.text,
          reason: _reasonController.text,
          state: true,
          branchId: int.parse(_branchIdController.text),
          petId: int.parse(_petIdController.text),
          employeeId: int.parse(_employeeIdController.text),
          serviceId: int.parse(_serviceIdController.text),
          scheduleId: int.parse(_scheduleIdController.text),
        );

        final success = await _apiService.createAppointment(appointment);

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cita creada exitosamente')));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hubo un error al crear la cita')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

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
                  Text(
                    "Consulta",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/logo_company.jpg'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('1/1', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.grey[300],
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextFieldWithIconInside(
                          controller: _dateController,
                          label: "Fecha",
                          icon: Icons.calendar_today,
                          onIconPressed: _selectDate,
                        ),
                        _buildTextFieldWithIconInside(
                          controller: _timeController,
                          label: "Hora",
                          icon: Icons.access_time,
                          onIconPressed: _selectTime,
                        ),
                        _buildTextField(_typeController, "Tipo"),
                        _buildTextField(_reasonController, "Razón"),
                        _buildTextField(_branchIdController, "Branch ID", isNumber: true),
                        _buildTextField(_petIdController, "Pet ID", isNumber: true),
                        _buildTextField(_employeeIdController, "Employee ID", isNumber: true),
                        _buildTextField(_serviceIdController, "Service ID", isNumber: true),
                        _buildTextField(_scheduleIdController, "Schedule ID", isNumber: true),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: _createAppointment,
                            child: Text(
                              'Crear Cita',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}