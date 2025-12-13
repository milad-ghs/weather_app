import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_new/core/resource/data_state.dart';

import '../../../domain/use_cases/delete_by_cityname_usecase.dart';

part 'delete_city_event.dart';
part 'delete_city_state.dart';

class DeleteCityBloc extends Bloc<DeleteCityEvent, DeleteCityState> {
  final DeleteByCityNameUseCase deleteByCityNameUseCase;
  DeleteCityBloc(this.deleteByCityNameUseCase) : super(DeleteCityInitial()) {
    on<DeleteCityByNameEvent>((event, emit) async{
      emit(DeleteCityLoading());
      final DataState dataState = await deleteByCityNameUseCase(event.city);
      if(dataState is DataSuccess){
        emit(DeleteCityCompleted(cityName: dataState.data));
      }
      if(dataState is DataFailed){
        emit(DeleteCityError(dataState.message!));
      }
    });
  }
}
