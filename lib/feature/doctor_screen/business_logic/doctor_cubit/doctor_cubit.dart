import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vcare_app/feature/doctor_screen/date/doctor_repo/doctor_repo.dart';
import 'package:vcare_app/feature/home_screen/date/model/doctor_model.dart';

import '../../../../core/local_database/secure_storage.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit(this.doctorRepo, this.secureStorage) : super(DoctorInitial());

  final DoctorRepo doctorRepo;
  final SecureStorage secureStorage;
  bool isFilter = false;

  List<DoctorModel> doctors = [];

  void getAllDoctors() async {
    String? token = await secureStorage.readSecureData('token');
    emit(GetAllDoctorLoading());
    doctorRepo.getAllDoctor(token: token!).then((value) {
      for (var element in value['data']) {
        doctors.add(DoctorModel.fromJson(element));
      }
      emit(GetAllDoctorSuccess(doctors));
    }).catchError(
      (onError) {
        emit(
          GetAllDoctorError(onError.toString()),
        );
      },
    );
  }

  void getFilterDoctor({required int cityId}) async {
    String? token = await secureStorage.readSecureData('token');
    emit(GetAllDoctorLoading());
    doctorRepo.getFilterDoctor(token: token!, cityId: cityId).then((value) {
      isFilter = true;
      emit(GetFilterDoctorSuccess(value));
    }).catchError(
      (onError) {
        emit(
          GetAllDoctorError(onError.toString()),
        );
      },
    );
  }

  void cancelFilter() {
    isFilter = false;
    emit(GetAllDoctorSuccess(doctors));
  }
}
