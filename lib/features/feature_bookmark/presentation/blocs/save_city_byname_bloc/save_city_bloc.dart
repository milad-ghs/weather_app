import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';

import '../../../domain/use_cases/save_city_byname_usecase.dart';

part 'save_city_event.dart';

part 'save_city_state.dart';

class SaveCityBloc extends Bloc<SaveCityEvent, SaveCityState> {
  final SaveCityByNameUseCase saveCityByNameUseCase;

  SaveCityBloc(this.saveCityByNameUseCase) : super(SaveCityInitial()) {
    on<LoadSaveCityEvent>((event, emit) async {
      emit(SaveCityLoading());
      DataState dataState = await saveCityByNameUseCase(event.city);
      if (dataState is DataSuccess) {
        return emit(SaveCitySuccess( city: dataState.data));
      } else {
        return emit(SaveCityError(dataState.message!));
      }
    });
  }
}
