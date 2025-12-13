part of 'find_city_bloc.dart';

@immutable
sealed class FindCityEvent extends Equatable {}

class FindCityByNameEvent extends FindCityEvent {
  final String cityName;

  FindCityByNameEvent(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class FindCityInitialEvent extends FindCityEvent {
  @override
  List<Object?> get props => [];
}
