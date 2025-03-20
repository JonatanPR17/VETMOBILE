import 'package:flutter/material.dart';
import '../data/usecase/authentication_usecase_imp.dart';
import 'package:vetmobile/domain/auth/models/user_profile.dart';
import 'custom_drawer.dart';

class WelcomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthenticationUsecaseImpl authUsecase = AuthenticationUsecaseImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey),
      body: Column(
        children: [
          SizedBox(height: 40), // Espaciado superior
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu, size: 30, color: Colors.black87),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                Spacer(),
                Text(
                  "¡Bienvenido!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/logo_company.jpg'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: Image.asset(
                    'assets/images/doctor.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 600,
                  ),
                ),
                Positioned(
                  bottom: -100,
                  left: 0,
                  right: 0,
                  child: FutureBuilder<UserProfile?>(
                    future: authUsecase.isLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return _userDetailsCard(context, snapshot.data!);
                      } else {
                        return _noSessionCard();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _userDetailsCard(BuildContext context, UserProfile userProfile) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Usuario",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text("${userProfile.name} ${userProfile.lastName}"),
          SizedBox(height: 20),
          Text(
            "Datos personales",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text("Id/Clave: ${userProfile.id}"),
          Text("Correo: ${userProfile.mail}"),
          Text("Rol: ${userProfile.rol?.name ?? "N/A"}"),
        ],
      ),
    );
  }

  Widget _noSessionCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          'No hay sesión activa.',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
