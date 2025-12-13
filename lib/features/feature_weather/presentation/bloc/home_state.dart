part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class CurrentWeatherLoading extends HomeState {}

class CurrentWeatherCompleted extends HomeState {
  final CurrentCityEntity currentCityEntity;

  CurrentWeatherCompleted(this.currentCityEntity);
}

class CurrentWeatherError extends HomeState {
  final String message;

  CurrentWeatherError(this.message);
}
