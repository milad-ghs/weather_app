import 'package:equatable/equatable.dart';

class CityEntities extends Equatable {
  final double? lat;
  final double? lon;
  final String? city;

  const CityEntities({this.lat, this.lon, this.city});

  @override
  List<Object?> get props => [lat, lon, city];
}
