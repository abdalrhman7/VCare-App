import 'package:vcare_app/core/network/wep_services.dart';

import '../../../../core/network/api_constants.dart';
import '../../../home_screen/date/model/doctor_model.dart';

class SearchRepo {
  final WebService webService;

  SearchRepo(this.webService);

  Future<List<DoctorModel>> searchDoctor(
      {required String token, required String searchKeyWord}) async {
    var response = await webService.getData(
        endPoint: ApiConstants.searchDoctor,
        token: token,
        data: {'name': searchKeyWord});
    List<DoctorModel> doctors = getDoctorsList(response);

    return doctors;
  }

  List<DoctorModel> getDoctorsList(Map<String, dynamic> data) {
    List<DoctorModel> doctors = [];

    for (var character in data['data']) {
      doctors.add(DoctorModel.fromJson(character));
    }
    return doctors;
  }
}
