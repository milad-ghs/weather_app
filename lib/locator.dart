import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app_new/features/feature_bookmark/data/repository/bookmarked_repositoyImp.dart';
import 'features/feature_bookmark/data/data_source/local/data_source.dart';
import 'features/feature_bookmark/domain/repository/bookmark_repository.dart';
import 'features/feature_bookmark/domain/use_cases/delete_all_cities_usecase.dart';
import 'features/feature_bookmark/domain/use_cases/delete_by_cityname_usecase.dart';
import 'features/feature_bookmark/domain/use_cases/find_city_byname_usecase.dart';
import 'features/feature_bookmark/domain/use_cases/get_all_cities_usecase.dart';
import 'features/feature_bookmark/domain/use_cases/save_city_byname_usecase.dart';
import 'features/feature_bookmark/presentation/blocs/delete_all_bloc/delete_all_bloc.dart';
import 'features/feature_bookmark/presentation/blocs/delete_city_byname_bloc/delete_city_bloc.dart';
import 'features/feature_bookmark/presentation/blocs/find_city_byname_bloc/find_city_bloc.dart';
import 'features/feature_bookmark/presentation/blocs/get_all_bloc/get_all_bloc.dart';
import 'features/feature_bookmark/presentation/blocs/save_city_byname_bloc/save_city_bloc.dart';
import 'features/feature_weather/data/data_source/remote/api_provider.dart';
import 'features/feature_weather/data/repository/weather_respostoryimpl.dart';
import 'features/feature_weather/domain/repository/weather_repository.dart';
import 'features/feature_weather/domain/use_cases/get_current_location.dart';
import 'features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'features/feature_weather/presentation/bloc/forecast_bloc/forecast_bloc.dart';
import 'features/feature_weather/presentation/bloc/home_bloc.dart';
import 'features/feature_weather/presentation/bloc/location_bloc/location_bloc.dart';

GetIt locator = GetIt.instance;

setup() {
  /// data source
  locator.registerSingleton<ApiProvider>(ApiProvider());

  /// ثبت FlutterSecureStorage
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked),
    ),
  );

  /// ثبت SecureStorageDataSource
  locator.registerLazySingleton<SecureStorageDataSource>(
    () => SecureStorageDataSource(locator()),
  );

  /// repositories
  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImp(locator()));
  locator.registerSingleton<BookmarkRepository>(BookmarkedRepositoryImpl(locator()));

  /// use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
    GetCurrentWeatherUseCase(locator()),
  );
  locator.registerSingleton<GetForecastWeatherUseCase>(
    GetForecastWeatherUseCase(locator()),
  );
  locator.registerSingleton<GetCurrentLocation>(GetCurrentLocation(locator()));

   //bookmark
  locator.registerSingleton<DeleteAllCitiesUseCase>(DeleteAllCitiesUseCase(locator()));
  locator.registerSingleton<DeleteByCityNameUseCase>(DeleteByCityNameUseCase(locator()));
  locator.registerSingleton<FindCityByNameUseCase>(FindCityByNameUseCase(locator()));
  locator.registerSingleton<GetAllCitiesUseCase>(GetAllCitiesUseCase(locator()));
  locator.registerSingleton<SaveCityByNameUseCase>(SaveCityByNameUseCase(locator()));
  /// bloc

  locator.registerSingleton<HomeBloc>(HomeBloc(locator()));
  locator.registerSingleton<ForecastBloc>(ForecastBloc(locator()));
  locator.registerSingleton<LocationBloc>(LocationBloc(locator()));

  //bookmark
  locator.registerSingleton<DeleteAllBloc>(DeleteAllBloc(locator()));
  locator.registerSingleton<DeleteCityBloc>(DeleteCityBloc(locator()));
  locator.registerSingleton<FindCityBloc>(FindCityBloc(locator()));
  locator.registerSingleton<GetAllBloc>(GetAllBloc(locator()));
  locator.registerSingleton<SaveCityBloc>(SaveCityBloc(locator()));
}
