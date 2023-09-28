import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vcare_app/feature/details_screen/data/model/appointment_model.dart';

import '../../../../core/local_database/secure_storage.dart';
import '../../data/repo/store_appointment_repo.dart';

part 'store_appointment_state.dart';

class StoreAppointmentCubit extends Cubit<StoreAppointmentState> {
  StoreAppointmentCubit(this.storeAppointmentRepo, this.secureStorage)
      : super(StoreAppointmentInitial());

  final StoreAppointmentRepo storeAppointmentRepo;
  final SecureStorage secureStorage;

  void storeAppointment(StoreAppointmentModel appointmentModel) async {
    String? token = await secureStorage.readSecureData('token');
    emit(StoreAppointmentLoading());
    storeAppointmentRepo
        .storeAppointment(appointmentModel: appointmentModel, token: token!)
        .then((value) => emit(StoreAppointmentSuccess()))
        .catchError((onError) => emit(StoreAppointmentError()));
  }
}
