
import '../../../../core/resource/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/current_city_entities.dart';
import '../repository/weather_repository.dart';

class GetCurrentWeatherUseCase
    extends UseCase<DataState<CurrentCityEntity>, String> {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>> call(String param) {
    return weatherRepository.fetchCurrentWeatherData(param);
  }
}
