import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../data/usecase/authentication_usecase_imp.dart';
import 'package:vetmobile/domain/auth/models/user_profile.dart';
import '../data/source/vettomy.dart/api_edit_profile.dart';
import 'change_password.dart';
import 'custom_drawer.dart';

class MiCuentaScreen extends StatefulWidget {
  @override
  _MiCuentaScreenState createState() => _MiCuentaScreenState();
}

class _MiCuentaScreenState extends State<MiCuentaScreen> {
  bool _isEditing = false;
  bool _showMoreOptions = false;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthenticationUsecaseImpl authUsecase = AuthenticationUsecaseImpl();
  final EditProfileService editProfileService = EditProfileService();

  UserProfile? _userProfile;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    UserProfile? userProfile = await authUsecase.isLogin();
    if (userProfile != null) {
      setState(() {
        _userProfile = userProfile;
        _nameController.text = userProfile.name ?? "";
        _lastNameController.text = userProfile.lastName ?? "";
        _emailController.text = userProfile.mail ?? "";
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_userProfile != null) {
      _userProfile!.name = _nameController.text;
      _userProfile!.lastName = _lastNameController.text;

      bool success = await editProfileService.updateUserProfile(_userProfile!);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil actualizado con éxito')),
        );
        setState(() {
          _isEditing = false;
          _showMoreOptions = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el perfil')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.black, size: 30),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  Spacer(),
                  Text(
                    "Mi cuenta",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
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
              SizedBox(height: 20),
              _buildProfileImage(),
              SizedBox(height: 20),
              _buildTextField("Nombres", _nameController),
              SizedBox(height: 10),
              _buildTextField("Apellidos", _lastNameController),
              SizedBox(height: 10),
              _buildTextField("Correo electrónico", _emailController, enabled: false),
              SizedBox(height: 10),
              _buildTextField("Contraseña", TextEditingController(text: "************"), enabled: false),
              Visibility(
                visible: _showMoreOptions,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CambiarContrasenaScreen()),
                        );
                      },
                      child: Text("Más opciones"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                    _showMoreOptions = _isEditing;
                    if (!_isEditing) _saveProfile();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  _isEditing ? "Guardar" : "Editar",
                  style: TextStyle(fontSize: 20, fontFamily: 'Outfit', fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage: _profileImage != null
              ? FileImage(_profileImage!)
              : AssetImage('assets/images/logo_company.jpg') as ImageProvider,
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Color(0xFF159EEC), shape: BoxShape.circle),
              child: Icon(Icons.edit, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: enabled && _isEditing,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
