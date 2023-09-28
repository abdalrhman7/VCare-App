import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/local_database/secure_storage.dart';
import '../../data/account_repo/account_repo.dart';
import '../../data/model/user_model.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this.accountRepo, this.secureStorage)
      : super(UserInfoInitial());

  final AccountRepo accountRepo;
  final SecureStorage secureStorage;

  Future<void> getUserProfile() async {
    emit(UserInfoLoading());
    String? token = await secureStorage.readSecureData('token');
    await accountRepo
        .getUserInfo(token: token!)
        .then((value) => emit(UserInfoSuccess(value)))
        .catchError((onError) {
      emit(UserInfoError(onError.toString()));
    });
  }
}
