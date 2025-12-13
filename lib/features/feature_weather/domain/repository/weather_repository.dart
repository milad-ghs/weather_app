import '../../../../core/params/forecast_params.dart';
import '../../../../core/resource/data_state.dart';
import '../../data/models/suggest_city_model.dart';
import '../entities/city_entities.dart';
import '../entities/current_city_entities.dart';
import '../entities/forecast_days_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);

  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
    ForecastParams params,
  );

  Future<List<Data>> fetchSuggestData(cityName);

  Future<CityEntities?> getCurrentLocation();
}
