import 'package:flutter/material.dart';
import '../screen/verify_mail_screen.dart';

class RecuperarCuentaScreen extends StatefulWidget {
  @override
  _RecuperarCuentaScreenState createState() => _RecuperarCuentaScreenState();
}

class _RecuperarCuentaScreenState extends State<RecuperarCuentaScreen> {
  bool _isLoading = false; // Estado de carga
  bool _isEmailFieldFocused = false; // Estado de enfoque para el campo de email
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _emailController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Controlar el enfoque para el campo de correo electrónico
    _emailFocusNode.addListener(() {
      setState(() {
        _isEmailFieldFocused = _emailFocusNode.hasFocus;
      });
    });
  }

  // Función para validar el correo electrónico
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    // Expresión regular para validar el formato del correo electrónico
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }
    return null;
  }

  Future<void> _sendRecoveryLink() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true); // Activar el estado de carga
      try {
        // Simular el envío del enlace de recuperación
        await Future.delayed(Duration(seconds: 2)); // Simulación de tiempo de espera

        // Navegar al siguiente pantalla (Verificar correo)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerificarCorreoScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() => _isLoading = false); // Desactivar el estado de carga
      }
    }
  }

  Widget _buildTextField(String hintText, TextEditingController controller, FocusNode focusNode, FormFieldValidator<String>? validator) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            color: focusNode.hasFocus || controller.text.isNotEmpty ? Colors.black : Colors.black,
          ),
          hintText: focusNode.hasFocus || controller.text.isNotEmpty ? null : hintText,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60), // Espaciado para evitar notch en dispositivos

            // Título "Dr. Tomy"
            Text(
              "Dr. Tomy",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),

            SizedBox(height: 10),

            Stack(
              alignment: Alignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.transparent, Color(0xFF159EEC), Colors.transparent],
                    stops: [0.0, 0.5, 1.0],
                  ).createShader(bounds),
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Color(0xFF159EEC), Colors.transparent],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
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
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/logo_company.jpg'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Subtítulo "Recupera tu cuenta"
            Text(
              "Recupera tu cuenta",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),

            SizedBox(height: 10),

            // Texto descriptivo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Introduzca su cuenta de correo electrónico y nosotros enviaremos un enlace para restablecer su contraseña.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa'),
              ),
            ),

            SizedBox(height: 30),

            // Campo de correo electrónico
            Form(
              key: _formKey,
              child: _buildTextField("Correo electrónico", _emailController, _emailFocusNode, _validateEmail),
            ),

            SizedBox(height: 20),

            // Botón "Enviar"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _sendRecoveryLink, // Deshabilitar si está cargando
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white) // Mostrar indicador de carga
                      : Text(
                          "Enviar",
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

            SizedBox(height: 20),

            // Botón "Volver a Inicio"
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Volver a Inicio",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
