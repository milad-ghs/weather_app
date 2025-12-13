import '../../../../core/usecase/use_case.dart';
import '../entities/city_entities.dart';
import '../repository/weather_repository.dart';

class GetCurrentLocation extends UseCase<CityEntities?, NoParams> {
  final WeatherRepository weatherRepository;

  GetCurrentLocation(this.weatherRepository);

  @override
  Future<CityEntities?> call(NoParams param) {
    return weatherRepository.getCurrentLocation();
  }
}
