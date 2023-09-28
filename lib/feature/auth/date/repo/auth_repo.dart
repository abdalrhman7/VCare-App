import 'package:vcare_app/core/network/wep_services.dart';
import 'package:vcare_app/feature/auth/date/model/login_model.dart';
import 'package:vcare_app/feature/auth/date/model/register_mode.dart';

import '../../../../core/network/api_constants.dart';

class AuthRepo {
  final WebService webService;

  AuthRepo(this.webService);

  Future<LoginModel> login(
      {required String email, required String password}) async {
    var response = await webService.postData(
      endPoint: ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    return LoginModel.fromJson(response.data['data']);
  }

  Future<LoginModel> register(RegisterModel registerModel) async {
    var response = await webService.postData(
      endPoint: ApiConstants.register,
      data: registerModel.toJson(),
    );
    return LoginModel.fromJson(response.data['data']);
  }

  Future<void> logout(String? token) async {
    await webService
        .postData(data: {}, endPoint: ApiConstants.logout, token: token);
  }
}
