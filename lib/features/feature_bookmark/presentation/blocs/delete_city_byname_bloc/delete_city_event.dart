part of 'delete_city_bloc.dart';

@immutable
sealed class DeleteCityEvent extends Equatable{}

class DeleteCityByNameEvent extends DeleteCityEvent{
  final String city;
  DeleteCityByNameEvent({required this.city});
  @override
  // TODO: implement props
  List<Object?> get props => [city];
}
