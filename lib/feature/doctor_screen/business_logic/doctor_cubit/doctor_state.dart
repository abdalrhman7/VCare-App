part of 'doctor_cubit.dart';

@immutable
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class GetAllDoctorLoading extends DoctorState {}

class GetAllDoctorSuccess extends DoctorState {
final  List<DoctorModel> doctors;

  GetAllDoctorSuccess(this.doctors);
}

class GetFilterDoctorSuccess extends DoctorState {
  final  List<DoctorModel> filterDoctors;

  GetFilterDoctorSuccess(this.filterDoctors);
}

class GetAllDoctorError extends DoctorState {
  final String errorMessage;

  GetAllDoctorError(this.errorMessage);
}
