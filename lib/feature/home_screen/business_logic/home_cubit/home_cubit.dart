import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vcare_app/core/utilities/cache/secure_storage.dart';
import 'package:vcare_app/feature/home_screen/date/repo/home_repo.dart';

import '../../date/model/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo, this.secureStorage) : super(HomeInitial());

  final HomeRepo homeRepo;
  final SecureStorage secureStorage;

  void getHomeDoctors() async{
    String? token = await secureStorage.readSecureData('token');
    emit(HomeLoading());
    homeRepo
        .getHomeDoctors(token : token!)
        .then((value) => emit(HomeSuccess(value)))
        .catchError(
          (onError) => emit(
            HomeError(onError.toString()),
          ),
        );
  }


}
