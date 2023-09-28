import 'package:vcare_app/core/network/wep_services.dart';
import 'package:vcare_app/feature/home_screen/date/model/city_model.dart';
import 'package:vcare_app/feature/home_screen/date/model/doctor_model.dart';

import '../../../../core/network/api_constants.dart';

class DoctorRepo {
  final WebService webService;

  DoctorRepo(this.webService);

  Future<Map<String, dynamic>> getAllDoctor({required String token}) async {
    var response = await webService.getData(
        endPoint: ApiConstants.getAllDoctor, token: token);
    return response;
  }

  Future<List<DoctorModel>> getFilterDoctor(
      {required String token, required int cityId}) async {
    var response = await webService.getData(
        endPoint: ApiConstants.getFilterDoctor,
        token: token,
        data: {'city': cityId});
    List<DoctorModel> doctors = getDoctorsList(response);
    return doctors;
  }

  Future<List<CityModel>> getAllCity({required String token}) async {
    var response = await webService.getData(
        endPoint: ApiConstants.getAllCity, token: token);
    List<CityModel> cities = getCitiesList(response);
    return cities;
  }
}

List<DoctorModel> getDoctorsList(Map<String, dynamic> data) {
  List<DoctorModel> doctors = [];

  for (var character in data['data']) {
    doctors.add(DoctorModel.fromJson(character));
  }
  return doctors;
}

List<CityModel> getCitiesList(Map<String, dynamic> data) {
  List<CityModel> cities = [];

  for (var character in data['data']) {
    cities.add(CityModel.fromJson(character));
  }
  return cities;
}
