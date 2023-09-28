import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/local_database/secure_storage.dart';
import '../../../auth/date/model/register_mode.dart';
import '../../data/account_repo/account_repo.dart';

part 'update_user_info_state.dart';

class UpdateUserInfoCubit extends Cubit<UpdateUserInfoState> {
  UpdateUserInfoCubit(this.accountRepo, this.secureStorage) : super(UpdateUserInfoInitial());

  final AccountRepo accountRepo;
  final SecureStorage secureStorage;


  void updateUserInfo(RegisterModel registerModel) async{
    String? token = await secureStorage.readSecureData('token');
    emit(UpdateUserInfoLoading());
    accountRepo
        .updateUserInfo(registerModel , token!)
        .then((_) => emit(UpdateUserInfoSuccess()))
        .catchError((error) => emit(UpdateUserInfoError(error.toString())));
  }
}
