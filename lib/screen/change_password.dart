import 'package:flutter/material.dart';
import '../screen/welcome_screen.dart';
import '../screen/recover_account_screen.dart';
import 'custom_drawer.dart'; // Importa el CustomDrawer

class CambiarContrasenaScreen extends StatefulWidget {
  @override
  _CambiarContrasenaScreenState createState() =>
      _CambiarContrasenaScreenState();
}

class _CambiarContrasenaScreenState extends State<CambiarContrasenaScreen> {
  bool _verActual = false;
  bool _verNueva = false;
  bool _verConfirmar = false;

  bool _isLoading = false;  // Variable para controlar el estado de carga

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario

  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey para el Scaffold

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la GlobalKey al Scaffold
      backgroundColor: Colors.white,
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey), // Añade el CustomDrawer
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey, // Asigna la GlobalKey al formulario
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.black, size: 30), // Icono del menú
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer(); // Abrir el CustomDrawer
                    },
                  ),
                  Spacer(),
                  Text(
                    "Contraseña",
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
              SizedBox(height: 30),
              _buildPasswordField("Contraseña Actual", _verActual, _currentPasswordController, (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa tu contraseña actual';
                }
                return null;
              }, () {
                setState(() {
                  _verActual = !_verActual;
                });
              }),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecuperarCuentaScreen()),
                      );
                    },
                    child: Text(
                      "Olvidé mi contraseña",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              _buildPasswordField("Nueva Contraseña", _verNueva, _newPasswordController, (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa una nueva contraseña';
                }
                return null;
              }, () {
                setState(() {
                  _verNueva = !_verNueva;
                });
              }),
              _buildPasswordField("Confirmar Nueva Contraseña", _verConfirmar, _confirmPasswordController, (value) {
                if (value!.isEmpty) {
                  return 'Por favor confirma tu nueva contraseña';
                }
                if (value != _newPasswordController.text) {
                  return 'Las contraseñas no coinciden';
                }
                return null;
              }, () {
                setState(() {
                  _verConfirmar = !_verConfirmar;
                });
              }),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true; // Activamos el estado de carga
                              });

                              // Simula un retraso de actualización, puedes reemplazarlo con una llamada real a un servicio
                              Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                  _isLoading = false; // Desactivamos el estado de carga
                                });

                                // Si todo es válido, vamos al welcome screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                );
                              });
                            }
                          },
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ) // Mostrar indicador de carga
                        : Text(
                            "Actualizar Cambios",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, bool isVisible, TextEditingController controller, FormFieldValidator<String>? validator, VoidCallback toggle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: !isVisible,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200], // Color de fondo predeterminado (gris)
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2), // Color de enfoque predeterminado
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              suffixIcon: IconButton(
                icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: toggle,
              ),
              labelText: label, // Label que se moverá cuando el campo esté enfocado
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
