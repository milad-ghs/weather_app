import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_app_new/features/feature_weather/data/repository/weather_respostoryimpl.dart';
import 'package:weather_app_new/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:weather_app_new/locator.dart';

import '../../../../helper/helper.mocks.dart';

void main() {
  late WeatherRepositoryImp weatherRepositroyImpl;
  late MockApiProvider mockApiProvider;

  setUp(() {
    mockApiProvider = MockApiProvider();
    locator.registerSingleton<ApiProvider>(mockApiProvider);
    weatherRepositroyImpl = WeatherRepositoryImp(
      apiProvider: locator<ApiProvider>(),
    );
  });

  tearDown(() {
    locator.reset();
  });

  group('fetch Current Weather Data', () {
    final cityName = 'tehran';
    test(':should return DataSuccess on status 200  ', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'': ''},
      );
      when(
        mockApiProvider.callCurrentWeather(cityName),
      ).thenAnswer((_) async => response);

      final result = await weatherRepositroyImpl.fetchCurrentWeatherData(
        cityName,
      );
      expect(result, isA<DataSuccess<CurrentCityEntity>>());
      verify(mockApiProvider.callCurrentWeather(cityName)).called(1);
    });

    test(' should return DataError on failed response ', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 400,
        data: {'': ''},
      );
      when(
        mockApiProvider.callCurrentWeather(cityName),
      ).thenAnswer((_) async => response);

      final result = await weatherRepositroyImpl.fetchCurrentWeatherData(
        cityName,
      );
      expect(result, isA<DataFailed>());
    });

    test(': should return DioException on failed ', () async {
      when(
        mockApiProvider.callCurrentWeather(cityName),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await weatherRepositroyImpl.fetchCurrentWeatherData(cityName);
      expect(result, isA<DataFailed>());
    });
  });
}
