import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_new/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:weather_app_new/features/feature_weather/presentation/screens/home_screen.dart';

import '../../../../helper/helper.mocks.dart';
// class FakeHomeEvent extends Fake implements HomeEvent {}
// class FakeHomeState extends Fake implements HomeState {}
void main() {
  group('Home screen test', () {
    late MockHomeBloc mockHomeBloc;
    
    setUp(() {
      mockHomeBloc = MockHomeBloc();
      when(() => mockHomeBloc.state).thenReturn(() => CurrentWeatherInitial());
    });
    testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomeBloc>.value(
            value: mockHomeBloc,
            child: HomeScreen(),
          ),
        ),
      );
    });
  });
}
