import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vcare_app/feature/auth/date/model/register_mode.dart';

import '../../../../core/local_database/secure_storage.dart';
import '../../date/repo/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo, this.secureStorage) : super(RegisterInitial());

  final AuthRepo authRepo;
  final SecureStorage secureStorage;

  void register(RegisterModel registerModel) {
    emit(RegisterLoading());
    authRepo.register(registerModel).then((value) {
      secureStorage.writeSecureData('token', value.token!);
      emit(RegisterSuccess());
    }).catchError((error) {
      emit(RegisterError(error));
    });
  }
}
