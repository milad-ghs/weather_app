import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_new/core/params/forecast_params.dart';
import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather_app_new/features/feature_weather/presentation/bloc/forecast_bloc/forecast_bloc.dart';

import '../../../../helper/helper.mocks.dart';

void main() {
  late MockGetForecastWeatherUseCase mockGetForecastWeatherUseCase;
  group('Forecast Weather event test', () {
    final params = ForecastParams(lat: 35.6892, lon: 51.3890);

    blocTest<ForecastBloc, ForecastState>(
      'emits Loading and Completed state when LoadForecast is added and call is successful',
      build: () {
        mockGetForecastWeatherUseCase = MockGetForecastWeatherUseCase();
        when(
          mockGetForecastWeatherUseCase.call(params),
        ).thenAnswer((_) => Future.value(DataSuccess(ForecastDaysEntity())));
        return ForecastBloc(mockGetForecastWeatherUseCase);
      },
      act: (bloc) => bloc.add(LoadForecast(params)),
      expect: () => <ForecastState>[
        ForecastLoading(),
        ForecastCompleted(ForecastDaysEntity()),
      ],
      verify: (_) {
        verify(mockGetForecastWeatherUseCase.call(params)).called(1);
      },
    );

    blocTest<ForecastBloc, ForecastState>(
      'emits Loading and Error state when LoadForecast is added and call is failure',
      build: () {
        mockGetForecastWeatherUseCase = MockGetForecastWeatherUseCase();
        when(
          mockGetForecastWeatherUseCase.call(params),
        ).thenAnswer((_) => Future.value(DataFailed('Error')));
        return ForecastBloc(mockGetForecastWeatherUseCase);
      },
      act: (bloc) => bloc.add(LoadForecast(params)),
      expect: () => <ForecastState>[ForecastLoading(), ForecastError('Error')],
      verify: (_) {
        verify(mockGetForecastWeatherUseCase.call(params)).called(1);
      },
    );
  });
}
