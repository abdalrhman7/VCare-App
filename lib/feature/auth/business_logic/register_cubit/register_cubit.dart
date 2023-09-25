import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vcare_app/feature/auth/date/model/register_mode.dart';

import '../../date/repo/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());

  final AuthRepo authRepo;

  void register(RegisterModel registerModel) {
    emit(RegisterLoading());
    authRepo
        .register(registerModel)
        .then((_) => emit(RegisterSuccess()))
        .catchError((error) => emit(RegisterError(error)));
  }
}
