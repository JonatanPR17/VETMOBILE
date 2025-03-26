/*import 'package:flutter/material.dart';
import 'package:vetmobile/data/usecase/authentication_usecase_imp.dart';
import '../screen/recover_account_screen.dart';
import 'package:vetmobile/domain/auth/models/login_request.dart';
import 'welcome_screen.dart'; // Importa la nueva pantalla

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  HTTP_STATES login_state = HTTP_STATES.NONE;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    String loginText = this.login_state != HTTP_STATES.LOADING ? "Ingresar" : "Cargando";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 20),
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
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/logo_company.jpg'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "¡Bienvenido!",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Inicia sesión ahora",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Outfit',
                ),
              ),
              SizedBox(height: 20),
              _buildTextField("Correo electrónico", false, _emailFocusNode),
              SizedBox(height: 10),
              _buildTextField("Contraseña", true, _passwordFocusNode),
              SizedBox(height: 20),
              // Aquí el botón "Ingresar" con el mismo tamaño que "Agregar nueva cita"
              Container(
                width: double.infinity, // Esto asegura que el botón ocupe todo el ancho disponible
                height: 50, // Altura fija
                child: ElevatedButton(
                  onPressed: this.login_state != HTTP_STATES.LOADING
                      ? () => login(context)
                      : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Fondo azul
                    padding: EdgeInsets.symmetric(vertical: 0), // El padding ya lo controlamos con el Container
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Bordes redondeados
                    ),
                  ),
                  child: Text(
                    loginText,
                    style: TextStyle(
                      fontSize: 20, // Tamaño de la fuente
                      fontWeight: FontWeight.bold, // Negrita
                      color: Colors.white, // Texto blanco
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextButton(
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
              SizedBox(height: 50),
              Text(
                "o conéctate con:",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black38,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                ),
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
      ),
    );
  }

  Widget _buildTextField(String hintText, bool isPassword, FocusNode focusNode) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          // Aquí actualizamos el estado cuando el campo recibe o pierde el enfoque
        });
      },
      child: TextFormField(
        controller: isPassword ? _passwordController : _emailController,
        obscureText: isPassword && !_isPasswordVisible,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            color: focusNode.hasFocus || (isPassword && _passwordController.text.isNotEmpty) || (!isPassword && _emailController.text.isNotEmpty)
                ? Colors.black
                : Colors.black,
          ),
          hintText: focusNode.hasFocus || (isPassword && _passwordController.text.isNotEmpty) || (!isPassword && _emailController.text.isNotEmpty)
              ? null
              : hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Campo requerido";
          if (isPassword && hintText == "Contraseña") {
            if (value.length < 6) {
              return "La contraseña debe tener al menos 6 caracteres";
            }
          }
          return null;
        },
      ),
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
        child: Image.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  void login(BuildContext context) {
    AuthenticationUsecaseImpl _auth = AuthenticationUsecaseImpl();
    LoginRequest reqData = LoginRequest(
      mail: _emailController.text,
      password: _passwordController.text,
    );

    print(reqData);
    setState(() {
      login_state = HTTP_STATES.LOADING;
    });
    _auth.login(reqData).then((profile) {
      print("${profile.name} ${profile.lastName} -- ${profile.rol!.name}");
      setState(() {
        login_state = HTTP_STATES.DONE;
      });
      SnackBar snackBar = SnackBar(
        content: Text("¡Login exitoso!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }).catchError((err) {
      setState(() {
        login_state = HTTP_STATES.ERROR;
      });
      print(err);
      SnackBar snackBar = SnackBar(
        content: Text(
            "No se pudo iniciar sesión, verifica tus credenciales e inténtalo nuevamente"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}

enum HTTP_STATES {
  LOADING,
  DONE,
  ERROR,
  NONE,
}*/

import 'package:flutter/material.dart';
import 'package:vetmobile/data/usecase/authentication_usecase_imp.dart';
import '../screen/recover_account_screen.dart';
import 'package:vetmobile/domain/auth/models/login_request.dart';
import 'welcome_screen.dart'; // Importa la nueva pantalla
import '../data/source/localstorage/huella_auth.dart'; // Importa la clase de autenticación biométrica

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Función para manejar la autenticación biométrica
  Future<void> _authenticate() async {
    try {
      final authen = await HuellaAuth.authenticate();
      if (authen) {
        // Si la autenticación biométrica es exitosa, proceder al login
        login(context);
      } else {
        // Si no es exitosa, mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Autenticación biométrica fallida")),
        );
      }
    } catch (e) {
      // En caso de error, mostramos una alerta
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al intentar autenticar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 20),
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
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/logo_company.jpg'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "¡Bienvenido!",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Inicia sesión ahora",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Outfit',
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Correo electrónico", false, _emailController),
                    SizedBox(height: 10),
                    _buildTextField("Contraseña", true, _passwordController),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            login(context);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Ingresar",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 5),
              TextButton(
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
              SizedBox(height: 50),
              Text(
                "o conéctate con:",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black38,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInkWellButton('assets/images/google.png', () {
                    print("Botón Google presionado");
                    // Acción para Google
                  }),
                  SizedBox(width: 15),
                  _buildInkWellButton('assets/images/facebook.png', () {
                    print("Botón Facebook presionado");
                    // Acción para Facebook
                  }),
                  SizedBox(width: 15),
                  _buildInkWellButton('assets/images/huella_dactilar.png', () {
                    print("Botón Huella dactilar presionado");
                    _authenticate(); // Llama a la función de autenticación
                  }),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, bool isPassword, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Campo requerido";

        if (!isPassword && hintText == "Correo electrónico") {
          if (!RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
            return "Correo no válido";
          }
        }

        if (isPassword && hintText == "Contraseña") {
          if (value.length < 6) {
            return "La contraseña debe tener al menos 6 caracteres";
          }
        }

        return null;
      },
    );
  }

  Widget _buildInkWellButton(String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: _buildSocialButton(imagePath),
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
        child: Image.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  void login(BuildContext context) {
    AuthenticationUsecaseImpl _auth = AuthenticationUsecaseImpl();
    LoginRequest reqData = LoginRequest(
      mail: _emailController.text,
      password: _passwordController.text,
    );

    setState(() {
      isLoading = true;
    });

    _auth.login(reqData).then((profile) {
      setState(() {
        isLoading = false;
      });
      SnackBar snackBar = SnackBar(
        content: Text("¡Login exitoso!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      SnackBar snackBar = SnackBar(
        content: Text(
            "No se pudo iniciar sesión, verifica tus credenciales e inténtalo nuevamente"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
