import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../data/source/vettomy.dart/api_register.dart'; // Asegúrate de tener este servicio

class NuevaCuentaScreen extends StatefulWidget {
  @override
  _NuevaCuentaScreenState createState() => _NuevaCuentaScreenState();
}

class _NuevaCuentaScreenState extends State<NuevaCuentaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _verPassword = false;
  bool _verConfirmarPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _mailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final authService = AuthService();
    final user = await authService.registerUser(
      name: _nameController.text,
      lastName: _lastNameController.text,
      mail: _mailController.text,
      password: _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Registro exitoso")),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error al registrar usuario")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/logo_company.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              "Nueva cuenta",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Nombre", _nameController),
                  SizedBox(height: 10),
                  _buildTextField("Apellido", _lastNameController),
                  SizedBox(height: 10),
                  _buildTextField("Correo electrónico", _mailController, isEmail: true),
                  SizedBox(height: 10),
                  _buildPasswordField("Contraseña", _passwordController, _verPassword, () {
                    setState(() {
                      _verPassword = !_verPassword;
                    });
                  }),
                  SizedBox(height: 10),
                  _buildPasswordField("Confirmar contraseña", _confirmPasswordController, _verConfirmarPassword, () {
                    setState(() {
                      _verConfirmarPassword = !_verConfirmarPassword;
                    });
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Botón Crear con el mismo tamaño
            Container(
              width: double.infinity, // El botón ocupa todo el ancho disponible
              height: 50, // Altura fija
              child: _isLoading
                  ? Center(child: CircularProgressIndicator()) // Cargando cuando se está registrando
                  : ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 0), // El padding ya lo controlamos con el Container
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Bordes redondeados
                        ),
                      ),
                      child: Text(
                        "Crear",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 55),
            Text(
              "o regístrate con:",
              style: TextStyle(fontSize: 25, color: Colors.black38, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton('assets/images/google.png'),
                SizedBox(width: 15),
                _buildSocialButton('assets/images/facebook.png'),
                SizedBox(width: 15),
                _buildSocialButton('assets/images/huella_dactilar.png'),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Campo requerido";

        if (isEmail) {
          if (!RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
            return "Correo no válido";
          }
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool isVisible, VoidCallback toggle) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggle,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Campo requerido";

        // Valida que las contraseñas coincidan
        if (label == "Confirmar contraseña" && value != _passwordController.text) {
          return "Las contraseñas no coinciden";
        }

        return null;
      },
    );
  }

  Widget _buildSocialButton(String imagePath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFD0E4FF),
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF159EEC), width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Image.asset(imagePath, width: 40, height: 40),
      ),
    );
  }
}
