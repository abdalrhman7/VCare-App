part of 'get_all_city_cubit.dart';

@immutable
abstract class GetAllCityState {}

class GetAllCityInitial extends GetAllCityState {}

class GetAllCityLoading extends GetAllCityState {}

class GetAllCitySuccess extends GetAllCityState {
  final List<CityModel> cities;

  GetAllCitySuccess(this.cities);
}

class GetAllCityError extends GetAllCityState {
  final String errorMessage;

  GetAllCityError(this.errorMessage);
}
