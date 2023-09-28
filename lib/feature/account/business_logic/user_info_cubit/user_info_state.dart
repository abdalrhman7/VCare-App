part of 'user_info_cubit.dart';

@immutable
abstract class UserInfoState {}

class UserInfoInitial extends UserInfoState {}

class UserInfoSuccess extends UserInfoState {
  final UserModel userModel;

  UserInfoSuccess(this.userModel);
}

class UserInfoLoading extends UserInfoState {}

class UserInfoError extends UserInfoState {
  final String errorMessage;

  UserInfoError(this.errorMessage);
}
