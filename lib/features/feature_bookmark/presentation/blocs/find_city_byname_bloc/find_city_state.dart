part of 'find_city_bloc.dart';

@immutable
sealed class FindCityState extends Equatable {}

final class FindCityInitial extends FindCityState {
  @override
  List<Object?> get props => [];
}

class FindCityLoading extends FindCityState {
  @override
  List<Object?> get props =>[];
}

class FindCityCompleted extends FindCityState {
  final bool cityIsExist;

  FindCityCompleted(this.cityIsExist);

  @override
  List<Object?> get props => [cityIsExist];
}

class FindCityError extends FindCityState {
  final String message;

  FindCityError(this.message);

  @override
  List<Object?> get props => [message];
}
