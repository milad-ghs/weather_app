import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';
import 'package:weather_app_new/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather_app_new/features/feature_weather/domain/repository/weather_repository.dart';

class GetSuggestionCityUseCase extends UseCase<List<Data>, String> {
  final WeatherRepository weatherRepository;

  GetSuggestionCityUseCase(this.weatherRepository);

  @override
  Future<List<Data>> call(String city) {
    return weatherRepository.fetchSuggestData(city);
  }
}
