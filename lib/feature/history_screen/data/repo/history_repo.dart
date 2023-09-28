import 'package:vcare_app/core/network/wep_services.dart';

import '../../../../core/network/api_constants.dart';
import '../model/appointment_model.dart';

class HistoryRepo {
  final WebService webService;

  HistoryRepo(this.webService);

  Future<List<AppointmentModel>> getAllAppointment({required String token}) async {
    var response = await webService.getData(
        endPoint: ApiConstants.getAllAppointment, token: token);
    List<AppointmentModel> appointments = getAppointmentsList(response);
    print('${appointments[0].appointmentPrice}++++++++++');

    return appointments;
  }
}

List<AppointmentModel> getAppointmentsList(Map<String, dynamic> data) {
  List<AppointmentModel> appointments = [];

  for (var appointment in data['data']) {
    appointments.add(AppointmentModel.fromJson(appointment));
  }
  return appointments;
}
