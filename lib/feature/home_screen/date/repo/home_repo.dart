import 'package:dio/dio.dart';
import 'package:vcare_app/core/network/wep_services.dart';
import 'package:vcare_app/feature/home_screen/date/model/home_model.dart';

import '../../../../core/network/api_constants.dart';

class HomeRepo {
  final WebService webService;

  HomeRepo(this.webService);

  Future<List<HomeModel>> getHomeDoctors({required String token}) async {
    var response =
        await webService.getData(endPoint: ApiConstants.homePage, token: token);
    List<HomeModel> home = getHomeDoctorsList(response);
    print('${home[0].doctors![0].phone}++++++++++');

    return home;
  }
}

List<HomeModel> getHomeDoctorsList(Map<String, dynamic> data) {
  List<HomeModel> characters = [];

  for (var character in data['data']) {
    characters.add(HomeModel.fromJson(character));
  }
  return characters;
}
