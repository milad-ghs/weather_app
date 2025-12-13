import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/repository/bookmark_repository.dart';

class FindCityByNameUseCase
    extends UseCase<DataState<bool>, String> {
  final BookmarkRepository bookmarkRepository;

  FindCityByNameUseCase(this.bookmarkRepository);

  @override
  Future<DataState<bool>> call(String param) {
    return bookmarkRepository.findCityByName(param);
  }
}
