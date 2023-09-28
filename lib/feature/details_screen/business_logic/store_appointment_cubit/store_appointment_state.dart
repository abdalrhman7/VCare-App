part of 'store_appointment_cubit.dart';

@immutable
abstract class StoreAppointmentState {}

class StoreAppointmentInitial extends StoreAppointmentState {}

class StoreAppointmentLoading extends StoreAppointmentState {}

class StoreAppointmentSuccess extends StoreAppointmentState {}

class StoreAppointmentError extends StoreAppointmentState {}
