import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_app_new/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_app_new/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_app_new/features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:weather_app_new/features/feature_weather/presentation/bloc/home_bloc.dart';

void disableOverflowErrors() {
  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception;
    final isOverflowError =
        exception is FlutterError &&
        !exception.diagnostics.any(
          (e) => e.value.toString().startsWith('A RenderFlex overflowed by'),
        );
    if (isOverflowError) {
      null;
    } else {
      FlutterError.presentError(details);
    }
  };
}

@GenerateMocks([
  Dio,
  ApiProvider,
  GetCurrentWeatherUseCase,
  GetForecastWeatherUseCase,
])

@GenerateNiceMocks([
  MockSpec<HomeBloc>(),
])
void main() {}
