part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {}
class CurrentWeatherInitial extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CurrentWeatherLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class CurrentWeatherCompleted extends HomeState {
  final CurrentCityEntity currentCityEntity;

  CurrentWeatherCompleted(this.currentCityEntity);

  @override
  List<Object?> get props => [currentCityEntity];
}

class CurrentWeatherError extends HomeState {
  final String message;

  CurrentWeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
