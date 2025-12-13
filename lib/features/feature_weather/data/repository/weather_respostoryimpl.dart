import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_new/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:weather_app_new/features/feature_weather/domain/entities/suggest_city_entity.dart';

import '../../../../core/params/forecast_params.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entities/city_entities.dart';
import '../../domain/entities/current_city_entities.dart';
import '../../domain/entities/forecast_days_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../data_source/remote/api_provider.dart';
import '../models/current_city_model.dart';
import '../models/forecast_days_model.dart';

class WeatherRepositoryImp extends WeatherRepository {
  ApiProvider apiProvider;

  WeatherRepositoryImp(this.apiProvider);

  /// Current
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
    String cityName,
  ) async {
    try {
      Response response = await apiProvider.callCurrentWeather(cityName);
      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity = CurrentCityModel.fromJson(
          response.data,
        );
        return DataSuccess(currentCityEntity);
      } else {
        return DataFailed('something went wrong . try again ... ');
      }
    } catch (e) {
      return DataFailed('Please check your connection');
    }
  }

  /// Forecast
  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
    ForecastParams params,
  ) async {
    try {
      Response response = await ApiProvider().sendRequest7DaysForecast(params);

      if (response.statusCode == 200) {
        final ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return DataFailed('Something went wrong . please try agian');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return DataFailed(' please check your connection ');
    }
  }

  /// Get Location
  @override
  Future<CityEntities?> getCurrentLocation() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        /// go to setting
        await Geolocator.openLocationSettings();
        return Future.error(
          'Location services are disabled. Please enable them.',
        );
      }

      /// check permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }
      final position = await Geolocator.getCurrentPosition();

      final placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final city = placeMarks.isNotEmpty ? placeMarks.first.locality ?? '' : '';

      return CityEntities(
        city: city,
        lat: position.latitude,
        lon: position.longitude,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(cityName) async {

      final Response response = await apiProvider.sendRequestCitySuggestion(
        cityName,
      );

      final SuggestCityEntity suggestCityEntity = SuggestCityModel.fromJson(
        response.data,
      );
      return suggestCityEntity.data!;

  }
}
