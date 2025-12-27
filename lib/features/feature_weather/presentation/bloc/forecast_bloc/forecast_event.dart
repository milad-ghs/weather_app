part of 'forecast_bloc.dart';

@immutable
sealed class ForecastEvent extends Equatable {}

class LoadForecast extends ForecastEvent {
  final ForecastParams params;
  LoadForecast(this.params);

  @override
  List<Object?> get props => [params];
}
