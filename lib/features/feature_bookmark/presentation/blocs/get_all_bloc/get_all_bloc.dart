import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';

import '../../../domain/use_cases/get_all_cities_usecase.dart';

part 'get_all_event.dart';

part 'get_all_state.dart';

class GetAllBloc extends Bloc<GetAllEvent, GetAllState> {
  final GetAllCitiesUseCase getAllCitiesUseCase;

  GetAllBloc(this.getAllCitiesUseCase) : super(GetAllInitial()) {
    on<LoadedAllCitiesEvent>((event, emit) async {
      emit(GetAllLoading());
      DataState dataState = await getAllCitiesUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(GetAllSuccess( cities: dataState.data));
      } else {
        emit(GetAllError('The list of cities is empty.'));
      }
    });
  }
}
