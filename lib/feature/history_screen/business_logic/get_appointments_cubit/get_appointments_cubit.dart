import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/local_database/secure_storage.dart';
import '../../data/model/appointment_model.dart';
import '../../data/repo/history_repo.dart';

part 'get_appointments_state.dart';

class GetAppointmentsCubit extends Cubit<GetAppointmentsState> {
  GetAppointmentsCubit(this.historyRepo, this.secureStorage)
      : super(GetAppointmentsInitial());
  final HistoryRepo historyRepo;
  final SecureStorage secureStorage;

  void getAllAppointment() async {
    String? token = await secureStorage.readSecureData('token');
    emit(GetAppointmentsLoading());
    historyRepo
        .getAllAppointment(token: token!)
        .then((value) => emit(GetAppointmentsSuccess(value)))
        .catchError(
          (onError) => emit(
            GetAppointmentsError(onError.toString()),
          ),
        );
  }
}
