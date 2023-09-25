part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<HomeModel> homeModel;

  HomeSuccess(this.homeModel);
}

class HomeError extends HomeState {
  final String errMessage;

  HomeError(this.errMessage);
}
