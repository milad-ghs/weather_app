import 'package:equatable/equatable.dart';

import '../../data/models/forecast_days_model.dart';

class ForecastDaysEntity extends Equatable{
  final num? latitude;
  final num? longitude;
  final num? generationtimeMs;
  final num? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final num? elevation;
  final DailyUnits? dailyUnits;
  final  Daily? daily;

  const ForecastDaysEntity({this.latitude, this.longitude, this.generationtimeMs,
      this.utcOffsetSeconds, this.timezone, this.timezoneAbbreviation,
      this.elevation, this.dailyUnits, this.daily});

  @override
  // TODO: implement props
  List<Object?> get props => [];

}