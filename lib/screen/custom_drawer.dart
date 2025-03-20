import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../data/usecase/authentication_usecase_imp.dart';
import 'package:vetmobile/domain/auth/models/user_profile.dart';
import 'welcome_screen.dart';
import 'my_account_screen.dart';
import 'store_screen.dart';
import 'my_appointments_screen.dart';
import 'my_pet_screen.dart';
import 'my_purchases_screen.dart';
import 'configuration_screen.dart';
import 'close_session_screen.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomDrawer({required this.scaffoldKey});

  final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  final AuthenticationUsecaseImpl authUsecase = AuthenticationUsecaseImpl();

  Future<void> _pickImage(BuildContext context, Function(File?) updateImage) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      updateImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: FutureBuilder<UserProfile?>(
              future: authUsecase.isLogin(), // Llamada asíncrona para obtener los datos del usuario
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data != null) {
                  return _buildUserHeader(context, snapshot.data!);
                } else {
                  return Center(
                    child: Text(
                      "No hay sesión activa.",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(height: 20),
                  _buildListTile(context, Icons.person, 'Mi Cuenta', MiCuentaScreen()),
                  _buildListTile(context, Icons.home, 'Inicio', WelcomeScreen()),
                  _buildListTile(context, Icons.store, 'Tienda', TiendaScreen()),
                  _buildListTile(context, Icons.calendar_today, 'Citas', CitasScreen()),
                  _buildListTile(context, Icons.pets, 'Mi Mascota', MiMascotaScreen()),
                  _buildListTile(context, Icons.shopping_cart, 'Mis Compras', MisComprasScreen()),
                  _buildListTile(context, Icons.settings, 'Configuración', ConfiguracionesScreen()),
                  _buildListTile(context, Icons.exit_to_app, 'Cerrar sesión', null),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context, UserProfile userProfile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : AssetImage('assets/images/logo_company.jpg') as ImageProvider,
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  _pickImage(context, (updatedImage) {
                    _profileImage = updatedImage;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0xFF159EEC),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "${userProfile.name} ${userProfile.lastName}",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title, Widget? screen) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (title == 'Cerrar sesión') {
            cerrarSesion(context);
          } else if (screen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          }
        },
        splashColor: Color(0xFF159EEC),
        highlightColor: Color(0xFF159EEC),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}