import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/local_database/secure_storage.dart';
import '../../../home_screen/date/model/city_model.dart';
import '../../date/doctor_repo/doctor_repo.dart';

part 'get_all_city_state.dart';

class GetAllCityCubit extends Cubit<GetAllCityState> {
  GetAllCityCubit(this.doctorRepo, this.secureStorage)
      : super(GetAllCityInitial());

  final DoctorRepo doctorRepo;
  final SecureStorage secureStorage;

  void getAllCities() async {
    String? token = await secureStorage.readSecureData('token');
    emit(GetAllCityLoading());
    doctorRepo
        .getAllCity(token: token!)
        .then((value) => emit(GetAllCitySuccess(value)))
        .catchError(
          (onError) => emit(
            GetAllCityError(onError.toString()),
          ),
        );
  }
}
