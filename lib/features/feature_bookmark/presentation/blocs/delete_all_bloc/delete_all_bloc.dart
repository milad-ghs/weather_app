import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';

import '../../../domain/entities/bookmarked_city_entity.dart';
import '../../../domain/use_cases/delete_all_cities_usecase.dart';

part 'delete_all_event.dart';

part 'delete_all_state.dart';

class DeleteAllBloc extends Bloc<DeleteAllEvent, DeleteAllState> {
  final DeleteAllCitiesUseCase deleteAllCitiesUseCase;

  DeleteAllBloc(this.deleteAllCitiesUseCase) : super(DeleteAllInitial()) {
    on<DeleteAllCityEvent>((event, emit) async {
      emit(DeleteAllLoading());
      final DataState dataState = await deleteAllCitiesUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(DeleteAllCompleted());
      } else {
        emit(DeleteAllError('The list of cities is empty.'));
      }
    });
  }
}
