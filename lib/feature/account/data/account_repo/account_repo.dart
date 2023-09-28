import 'package:vcare_app/core/network/api_constants.dart';
import 'package:vcare_app/core/network/wep_services.dart';

import '../../../auth/date/model/register_mode.dart';
import '../model/user_model.dart';

class AccountRepo {
  final WebService webService;

  AccountRepo(this.webService);

  Future<UserModel> getUserInfo({required String token}) async {
    var response = await webService.getData(
        endPoint: ApiConstants.getUserProfile, token: token);

    return UserModel.fromJson(response['data'][0]);
  }

  Future<void> updateUserInfo(RegisterModel registerModel , String token) async {
    await webService.postData(
      endPoint: ApiConstants.updateUserInfo,
      data: registerModel.toJson(),
      token: token
    );
  }
}
