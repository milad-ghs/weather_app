import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_new/core/params/forecast_params.dart';
import 'package:weather_app_new/core/utils/constants.dart';
import 'package:weather_app_new/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_app_new/locator.dart';

import '../../../../helper/helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late ApiProvider apiProvider;

  setUp(() {
    mockDio = MockDio();
    locator.registerSingleton<Dio>(mockDio);
    apiProvider = ApiProvider(dio: locator<Dio>());
  });
  tearDown(() {
    locator.reset();
  });

  /// test for current weather
  group('call Current Weather', () {
    /// happy path
    test(' : should Retun response on success', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'': ''},
      );
      final cityName = 'tehran';
      when(
        mockDio.get(
          any,
          queryParameters: {
            'q': cityName,
            'appid': Constants.apiKey1,
            'units': 'metric',
          },
        ),
      ).thenAnswer((_) async => response);

      final result = await apiProvider.callCurrentWeather(cityName);
      expect(result, isA<Response>());
      verify(
        mockDio.get(
          '${Constants.baseUrl}/data/2.5/weather',
          queryParameters: {
            'q': cityName,
            'appid': Constants.apiKey1,
            'units': 'metric',
          },
        ),
      ).called(1);
    });

    /// error path
    test(': should throw an DioException on failure ', () async {
      final cityName = 'tehran';
      when(
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      final result = apiProvider.callCurrentWeather(cityName);
      expect(
        result,
        throwsA(isA<DioException>()),
      );
    });
  });

  /// test for Forecast weather
  group('Forecast Weather ', () {
    /// happy path
    test(' : should Retun response on success', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'': ''},
      );
      final params = ForecastParams(lat: 35.6892,lon: 51.3890);
      when(
        mockDio.get(
          "https://api.open-meteo.com/v1/forecast",
          queryParameters: {
            'latitude': params.lat,
            'longitude': params.lon,
            'daily': 'temperature_2m_mean,weathercode',
            'timezone': 'auto',
          },
        ),
      ).thenAnswer((_) async => response);

      final result = await apiProvider.sendRequest7DaysForecast(params);
      expect(result, isA<Response>());
      verify(
        mockDio.get(
          "https://api.open-meteo.com/v1/forecast",
          queryParameters: {
            'latitude': params.lat,
            'longitude': params.lon,
            'daily': 'temperature_2m_mean,weathercode',
            'timezone': 'auto',
          },
        ),
      ).called(1);
    });

    /// error path
    test(' : should throw an DioException on failure', () async {
      final params = ForecastParams(lat: 35.6892, lon: 51.3890);
      when(
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () => apiProvider.sendRequest7DaysForecast(params),
        throwsA(isA<DioException>()),
      );
    });
  });

  /// test for Suggestion
  group('send Request City Suggestion ', () {
    /// happy path
    test(' : should Retun response on success', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'': ''},
      );

      final prefix = 'teh';
      when(
        mockDio.get(
          "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
          queryParameters: {'limit': 7, 'offset': 0, 'namePrefix': prefix},
        ),
      ).thenAnswer((_) async => response);

      final result = await apiProvider.sendRequestCitySuggestion(prefix);

      expect(result, isA<Response>());
      expect(result.statusCode, 200);
      verify(
        mockDio.get(
          "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
          queryParameters: {'limit': 7, 'offset': 0, 'namePrefix': prefix},
        ),
      ).called(1);
    });

    ///error path
    test(' : should throw an DioException on failure', () async {
      final prefix = 'teh';
      when(
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () => apiProvider.sendRequestCitySuggestion(prefix),
        throwsA(isA<DioException>()),
      );
    });
  });
}
