import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/params/forecast_params.dart';
import '../../../../../core/resource/data_state.dart';
import '../../../domain/entities/forecast_days_entity.dart';
import '../../../domain/use_cases/get_forecast_weather_usecase.dart';
part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final GetForecastWeatherUseCase getForecastWeatherUseCase;

  ForecastBloc(this.getForecastWeatherUseCase) : super(ForecastLoading()) {
    on<LoadForecast>((event, emit) async {
      emit(ForecastLoading());
      final DataState dataState = await getForecastWeatherUseCase(event.params);

      if (dataState is DataSuccess) {
        emit(ForecastCompleted(dataState.data));
      } else if (dataState is DataFailed) {
        emit(ForecastError(dataState.message!));
      }
    });
  }
}
