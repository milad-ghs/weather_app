import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';

import '../../../domain/use_cases/find_city_byname_usecase.dart';

part 'find_city_event.dart';

part 'find_city_state.dart';

class FindCityBloc extends Bloc<FindCityEvent, FindCityState> {
  final FindCityByNameUseCase findCityByNameUseCase;

  FindCityBloc(this.findCityByNameUseCase) : super(FindCityInitial()) {
    on<FindCityByNameEvent>((event, emit) async {
      try {
        emit(FindCityLoading());
        final  dataState = await findCityByNameUseCase(event.cityName);

        if (dataState is DataSuccess) {
          final isExist = dataState.data!;
            emit(FindCityCompleted(isExist));
        } else  {
          final msg = dataState.message ?? 'Unknown error';
          emit(FindCityError(msg));
        }
      } catch (e) {
        emit(FindCityError(e.toString()));
      }
    });
    on<FindCityInitialEvent>((event, emit) {
      emit(FindCityInitial());
    });
  }
}
