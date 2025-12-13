part of 'forecast_bloc.dart';

@immutable
sealed class ForecastEvent {}

class LoadForecast extends ForecastEvent{
  final ForecastParams params;
  LoadForecast(this.params);
}
