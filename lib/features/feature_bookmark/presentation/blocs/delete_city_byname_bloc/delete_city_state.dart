part of 'delete_city_bloc.dart';

@immutable
sealed class DeleteCityState extends Equatable {}

final class DeleteCityInitial extends DeleteCityState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteCityLoading extends DeleteCityState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteCityCompleted extends DeleteCityState {
  final String cityName;

  DeleteCityCompleted({required this.cityName});

  @override
  // TODO: implement props
  List<Object?> get props => [cityName];
}

class DeleteCityError extends DeleteCityState {
  final String message;

  DeleteCityError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
