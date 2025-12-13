import 'package:weather_app_new/core/resource/data_state.dart';

import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';

import '../../domain/repository/bookmark_repository.dart';
import '../data_source/local/data_source.dart';

class BookmarkedRepositoryImpl extends BookmarkRepository {
  final SecureStorageDataSource secureStorageDataSource;

  BookmarkedRepositoryImpl(this.secureStorageDataSource);

  @override
  Future<DataState<void>> deleteAllCities() async {
    try {
      await secureStorageDataSource.saveCities([]);
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteCityByName(String city) async {
    try {
      final cities = await secureStorageDataSource.getCities();
      var index = cities.indexWhere((c) => c.name == city);
      print('index = $index ');
      if (index == -1) {
        return DataFailed('City not found');
      }
      cities.removeAt(index);
      await secureStorageDataSource.saveCities(cities);
      return DataSuccess(city);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  /// edit
  @override
  Future<DataState<bool>> findCityByName(String city) async {
    try {
      final cities = await secureStorageDataSource.getCities();
      final bool isExisting = cities.any(
            (c) => c.name == city, );
        return DataSuccess(isExisting);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<BookmarkedCity>>> getAllCities() async {
    try {
      final cities = await secureStorageDataSource.getCities();
      return DataSuccess(cities);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<BookmarkedCity>> saveCityByName(String city) async {
    try {
      final cities = await secureStorageDataSource.getCities();
      final bool isExisting = cities.any(
            (c) => c.name == city, );

      if (isExisting) {
        return DataFailed('$city has already exists');
      }
      final newCity = BookmarkedCity(city);
      cities.add(newCity);
      await secureStorageDataSource.saveCities(cities);

      return DataSuccess(newCity);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
