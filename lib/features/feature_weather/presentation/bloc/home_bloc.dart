import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/resource/data_state.dart';
import '../../domain/entities/current_city_entities.dart';

import '../../domain/use_cases/get_current_weather_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  HomeBloc(this.getCurrentWeatherUseCase) : super(CurrentWeatherLoading()) {
    on<LoadCwEvent>((event, emit) async {
      emit(CurrentWeatherLoading());
      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      if (dataState is DataSuccess) {
        emit(CurrentWeatherCompleted(dataState.data));
      } else if (dataState is DataFailed) {
        emit(CurrentWeatherError(dataState.message!));
      }
    });
  }
}
