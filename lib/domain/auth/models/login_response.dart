import 'package:vetmobile/domain/auth/models/user_profile.dart';

class LoginResponse {
  String token;
  UserProfile profile;

  LoginResponse({required this.token, required this.profile});

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        token: json['token'], profile: UserProfile.fromJson(json['profile']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}
