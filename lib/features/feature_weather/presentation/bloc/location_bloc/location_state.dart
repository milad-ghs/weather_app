part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationComplete extends LocationState {
  final CityEntities? cityEntities;

  LocationComplete(this.cityEntities);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
