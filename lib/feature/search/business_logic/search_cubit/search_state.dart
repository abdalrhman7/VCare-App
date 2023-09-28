part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchSuccess extends SearchState {
  final List<DoctorModel> doctors;

  SearchSuccess(this.doctors);
}
