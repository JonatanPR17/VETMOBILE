import 'package:vetmobile/domain/auth/models/login_request.dart';
import 'package:vetmobile/domain/auth/models/login_response.dart';
import 'package:dio/dio.dart';

class AuthApi {
  Future<LoginResponse> login(LoginRequest body) async {
    final dio = Dio();

    Response response = await dio.post(
        "https://www.veterinariatomyhyope.somee.com/api/auth/authentication/login",
        data: body.toJson(),
        options: Options(contentType: "application/json"));

    if (response.statusCode != 200) {
      throw Exception("No se logeo correctamente");
    }
    return LoginResponse.fromJson(response.data);
  }
}
