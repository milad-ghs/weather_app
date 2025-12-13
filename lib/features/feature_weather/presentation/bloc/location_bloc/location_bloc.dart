import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


import '../../../../../core/usecase/use_case.dart';
import '../../../domain/entities/city_entities.dart';
import '../../../domain/use_cases/get_current_location.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocation getCurrentLocation;

  LocationBloc(this.getCurrentLocation) : super(LocationInitial()) {
    on<LoadCurrentLocation>((event, emit) async {
      emit(LocationLoading());
      final location = await getCurrentLocation(NoParams());
      if (location != null) {
        emit(LocationComplete(location));
      } else {
        emit(LocationError('failed to get location'));
      }
    });


  }
}
