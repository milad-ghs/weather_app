

import '../../../../core/params/forecast_params.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/forecast_days_entity.dart';
import '../repository/weather_repository.dart';

class GetForecastWeatherUseCase extends UseCase<DataState<ForecastDaysEntity>, ForecastParams>{
  final WeatherRepository weatherRepository;
  GetForecastWeatherUseCase(this.weatherRepository);
  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams param) {
   return weatherRepository.fetchForecastWeatherData(param);
  }
}