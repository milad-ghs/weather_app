import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/params/forecast_params.dart';
import '../../../../../core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final apiKey = Constants.apiKey1;

  /// request for current weather
  Future<dynamic> callCurrentWeather(String cityName) async {
    var response = await _dio.get(
      '${Constants.baseUrl}/data/2.5/weather',
      queryParameters: {'q': cityName, 'appid': apiKey, 'units': 'metric'},
    );
    //
    // if (kDebugMode) {
    //   print(response.data);
    // }
    return response;
  }

  /// request for forecast 7 days
  Future<dynamic> sendRequest7DaysForecast(ForecastParams params) async {
    var response = await _dio.get(
      "https://api.open-meteo.com/v1/forecast",
      queryParameters: {
        'latitude': params.lat,
        'longitude': params.lon,
        'daily': 'temperature_2m_mean,weathercode',
        'timezone': 'auto',
      },
    );
    // if (kDebugMode) {
    //   print(response.data);
    // }
    return response;
  }

  /// request for suggestion city
  Future<dynamic> sendRequestCitySuggestion(String prefix) async {
    var response = await _dio.get(
      "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
      queryParameters: {'limit': 7, 'offset': 0, 'namePrefix': prefix},
    );
    if (kDebugMode) {
      print(response);
    }
    return response;
  }
}
