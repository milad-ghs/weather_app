part of 'save_city_bloc.dart';

@immutable
sealed class SaveCityEvent extends Equatable {}

class LoadSaveCityEvent extends SaveCityEvent {
  final String city;
  LoadSaveCityEvent(this.city);
  @override
  List<Object?> get props => [];
}
