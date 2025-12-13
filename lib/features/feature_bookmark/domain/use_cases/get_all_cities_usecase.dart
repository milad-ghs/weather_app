import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';

import '../repository/bookmark_repository.dart';

class GetAllCitiesUseCase
    extends UseCase<DataState<List<BookmarkedCity>>, NoParams> {
  final BookmarkRepository bookmarkRepository;

  GetAllCitiesUseCase(this.bookmarkRepository);

  @override
  Future<DataState<List<BookmarkedCity>>> call(NoParams param) {
    return bookmarkRepository.getAllCities();
  }
}
