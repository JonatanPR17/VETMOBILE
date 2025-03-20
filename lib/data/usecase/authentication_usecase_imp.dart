import 'package:vetmobile/data/source/vettomy.dart/api_login.dart';
import 'package:vetmobile/data/source/localstorage/auth_storage.dart';
import 'package:vetmobile/domain/auth/models/login_response.dart';
import 'package:vetmobile/domain/auth/models/user_profile.dart';
import 'package:vetmobile/domain/auth/models/signup_request.dart';
import 'package:vetmobile/domain/auth/models/login_request.dart';
import 'package:vetmobile/domain/auth/usecase/authentication_usecase.dart';

class AuthenticationUsecaseImpl implements AuthenticationUsecase {
  final AuthApi _auth = AuthApi();
  final AuthStorage _storage = AuthStorage();

  @override
  Future<UserProfile?> isLogin() async {
    // buscar el tocal localmente
    String? tokenLocal = await _storage.getToken();
    // Validamos el token
    // si existe y es valido, retornamos el user profile
    UserProfile? profile = await _storage.getProfile();
    return profile;
  }

  @override
  Future<UserProfile> login(LoginRequest body) async {
    // llamar al servicio para inicioar sesion
    LoginResponse res = await _auth.login(body);
    // validar los datos de inicio de sesion
    //
    // Guardar los datos de inicio de sesion
    await _storage.saveToken(res.token);
    await _storage.saveProfile(res.profile);

    return res.profile;
  }

  @override
  Future<void> logout() {
    return _storage.clearAll();
  }

  @override
  Future<void> signup(SignupRequest body) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
