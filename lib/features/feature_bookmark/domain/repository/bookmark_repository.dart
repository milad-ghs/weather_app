import 'package:weather_app_new/core/resource/data_state.dart';

import '../entities/bookmarked_city_entity.dart';

abstract class BookmarkRepository {
  Future<DataState<List<BookmarkedCity>>> getAllCities();

  Future<DataState<BookmarkedCity>> saveCityByName(String city);

  Future<DataState<String>> deleteCityByName(String city);

  Future<DataState<bool>> findCityByName(String city);

  Future<DataState<void>> deleteAllCities();
}
