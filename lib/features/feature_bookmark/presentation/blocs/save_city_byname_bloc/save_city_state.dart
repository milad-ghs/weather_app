part of 'save_city_bloc.dart';

@immutable
sealed class SaveCityState extends  Equatable{}

final class SaveCityInitial extends SaveCityState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SaveCityLoading extends SaveCityState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SaveCitySuccess extends SaveCityState{
  final BookmarkedCity city;
  SaveCitySuccess({required this.city});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SaveCityError extends SaveCityState{
  final String message;
  SaveCityError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
