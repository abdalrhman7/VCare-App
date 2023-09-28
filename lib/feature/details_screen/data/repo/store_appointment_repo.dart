import 'package:vcare_app/core/network/api_constants.dart';
import 'package:vcare_app/core/network/wep_services.dart';
import 'package:vcare_app/feature/details_screen/data/model/appointment_model.dart';

class StoreAppointmentRepo {
  final WebService webService;

  StoreAppointmentRepo(this.webService);

  Future<void> storeAppointment(
      {required StoreAppointmentModel appointmentModel,
      required String token}) async {
    await webService.postData(
      endPoint: ApiConstants.storeAppointment,
      data: appointmentModel.toJson(),
      token: token,
    );
  }
}
