import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/repository/bookmark_repository.dart';

class SaveCityByNameUseCase extends UseCase<DataState<BookmarkedCity>, String> {
  final BookmarkRepository bookmarkRepository;

  SaveCityByNameUseCase(this.bookmarkRepository);

  @override
  Future<DataState<BookmarkedCity>> call(String city) {
    return bookmarkRepository.saveCityByName(city);
  }
}
