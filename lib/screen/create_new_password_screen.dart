import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa la pantalla de login

class CrearNuevaContrasenaScreen extends StatefulWidget {
  @override
  _CrearNuevaContrasenaScreenState createState() =>
      _CrearNuevaContrasenaScreenState();
}

class _CrearNuevaContrasenaScreenState
    extends State<CrearNuevaContrasenaScreen> {
  bool _verPassword = false;  // Controla la visibilidad de la contraseña
  bool _verConfirmarPassword = false;  // Controla la visibilidad de la confirmación de la contraseña

  bool _isLoading = false;  // Variable para controlar el estado de carga

  // Controladores de los campos
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Para la validación del formulario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80), // Espaciado superior para evitar el notch

              // Imagen superior dentro de un CircleAvatar con sombra
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60, // Mantén el tamaño original que desees
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/logo_company.jpg'),
                ),
              ),

              SizedBox(height: 30),

              // Título
              Text(
                "Crea tu nueva contraseña",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                ),
              ),

              SizedBox(height: 10),

              // Subtítulo
              Text(
                "Escribe una nueva contraseña para iniciar sesión.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
              ),

              SizedBox(height: 30),

              // Formulario
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo de contraseña
                    _buildPasswordField("Contraseña", _passwordController, _verPassword, () {
                      setState(() {
                        _verPassword = !_verPassword;
                      });
                    }),

                    SizedBox(height: 20),

                    // Campo de confirmar contraseña
                    _buildPasswordField("Confirmar contraseña", _confirmPasswordController, _verConfirmarPassword, () {
                      setState(() {
                        _verConfirmarPassword = !_verConfirmarPassword;
                      });
                    }),

                    SizedBox(height: 30),

                    // Botón "Crear"
                    SizedBox(
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
                                // Validamos el formulario antes de proceder
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true; // Activamos el estado de carga
                                  });

                                  // Simula un retraso de registro, puedes reemplazarlo con una llamada real a un servicio
                                  Future.delayed(Duration(seconds: 2), () {
                                    setState(() {
                                      _isLoading = false; // Desactivamos el estado de carga
                                    });

                                    // Si todo es válido, vamos al login screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );
                                  });
                                }
                            },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ) // Mostrar indicador de carga
                            : Text(
                                "Crear",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para crear los campos de texto con animación y cambio de color
  Widget _buildPasswordField(String label, TextEditingController controller, bool isVisible, VoidCallback toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Campo requerido";  // Valida que el campo no esté vacío
        }

        if (label == "Contraseña" && value.length < 6) {
          return "La contraseña debe tener al menos 6 caracteres";  // Validación de longitud de contraseña
        }

        if (label == "Confirmar contraseña" && value != _passwordController.text) {
          return "Las contraseñas no coinciden";  // Valida que las contraseñas coincidan
        }

        return null;  // Si no hay errores, el campo es válido
      },
    );
  }
}
