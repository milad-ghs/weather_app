part of 'forecast_bloc.dart';

@immutable
sealed class ForecastState {}

class ForecastLoading extends ForecastState{}

class ForecastCompleted  extends ForecastState{
  final ForecastDaysEntity forecastDaysEntity;
  ForecastCompleted(this.forecastDaysEntity);
}

class ForecastError extends ForecastState{
  final String message;
  ForecastError(this.message);

}
