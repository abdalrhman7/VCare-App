import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vcare_app/feature/auth/date/repo/auth_repo.dart';

import '../../../../core/utilities/cache/secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo, this.secureStorage) : super(LoginInitial());
  final AuthRepo authRepo;
  final SecureStorage secureStorage;

  void login({required String email, required String password}) {
    emit(LoginLoading());
    authRepo.login(email: email, password: password).then(
      (value) {
        secureStorage.writeSecureData('token', value.token!);
        emit(LoginSuccess());
      },
    ).catchError(
      (onError) {
        emit(
          LoginError(onError.toString()),
        );
      },
    );
  }

  Future<void> logout() async {
    String? token = await secureStorage.readSecureData('token');
    await authRepo.logout(
      token,
    );
    secureStorage.deleteSecureData('token');
  }
}
