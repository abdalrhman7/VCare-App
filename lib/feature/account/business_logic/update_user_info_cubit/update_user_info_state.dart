part of 'update_user_info_cubit.dart';

@immutable
abstract class UpdateUserInfoState {}

class UpdateUserInfoInitial extends UpdateUserInfoState {}

class UpdateUserInfoLoading extends UpdateUserInfoState {}

class UpdateUserInfoSuccess extends UpdateUserInfoState {}

class UpdateUserInfoError extends UpdateUserInfoState {
  final String errorMessage;

  UpdateUserInfoError(this.errorMessage);
}
