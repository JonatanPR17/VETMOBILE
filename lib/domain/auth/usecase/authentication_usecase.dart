import 'package:vetmobile/domain/auth/models/login_request.dart';
import 'package:vetmobile/domain/auth/models/signup_request.dart';
import 'package:vetmobile/domain/auth/models/user_profile.dart';

abstract class AuthenticationUsecase {
  Future<void> signup(SignupRequest body);
  Future<UserProfile> login(LoginRequest body);
  Future<void> logout();
  Future<UserProfile?> isLogin();
}
