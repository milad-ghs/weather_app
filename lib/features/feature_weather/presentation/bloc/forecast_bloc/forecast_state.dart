part of 'forecast_bloc.dart';

@immutable
sealed class ForecastState extends Equatable {}

class ForecastLoading extends ForecastState {
  @override
  List<Object?> get props => [];
}

class ForecastCompleted extends ForecastState {
  final ForecastDaysEntity forecastDaysEntity;
  ForecastCompleted(this.forecastDaysEntity);

  @override
  List<Object?> get props => [forecastDaysEntity];
}

class ForecastError extends ForecastState {
  final String message;
  ForecastError(this.message);

  @override
  List<Object?> get props => [message];
}
