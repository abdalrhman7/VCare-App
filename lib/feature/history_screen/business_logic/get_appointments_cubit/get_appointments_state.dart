part of 'get_appointments_cubit.dart';

@immutable
abstract class GetAppointmentsState {}

class GetAppointmentsInitial extends GetAppointmentsState {}

class GetAppointmentsLoading extends GetAppointmentsState {}

class GetAppointmentsSuccess extends GetAppointmentsState {
  final List<AppointmentModel> appointments;

  GetAppointmentsSuccess(this.appointments);
}

class GetAppointmentsError extends GetAppointmentsState {
  final String errorMessage;

  GetAppointmentsError(this.errorMessage);
}
