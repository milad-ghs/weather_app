import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:weather_app_new/features/feature_weather/presentation/bloc/home_bloc.dart';

import '../../../../helper/helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;

  group(' Current weather event test', () {
    final cityName = 'tehran';
    blocTest<HomeBloc, HomeState>(
      'emits Loading and Completed state when LoadCwEvent is added and call is successful',
      build: () {
        mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
        when(
          mockGetCurrentWeatherUseCase.call(cityName),
        ).thenAnswer((_) => Future.value(DataSuccess(CurrentCityEntity())));
        return HomeBloc(mockGetCurrentWeatherUseCase);
      },
      act: (homeBloc) => homeBloc.add(LoadCwEvent(cityName)),
      expect: () => <HomeState>[
        CurrentWeatherLoading(),
        CurrentWeatherCompleted(CurrentCityEntity()),
      ],
      verify: (_) {
        verify(mockGetCurrentWeatherUseCase.call(cityName)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits Loading and Error state when LoadCwEvent is added and call is failed',
      build: () {
        mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
        when(
          mockGetCurrentWeatherUseCase.call(cityName),
        ).thenAnswer((_) => Future.value(DataFailed('Error')));
        return HomeBloc(mockGetCurrentWeatherUseCase);
      },
      act: (homeBloc) => homeBloc.add(LoadCwEvent(cityName)),
      expect: () => <HomeState>[
        CurrentWeatherLoading(),
        CurrentWeatherError('Error'),
      ],
    );
  });
}
