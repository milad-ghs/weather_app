import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/repository/bookmark_repository.dart';

class DeleteByCityNameUseCase extends UseCase<DataState<String>, String> {
  final BookmarkRepository bookmarkRepository;

  DeleteByCityNameUseCase(this.bookmarkRepository);

  @override
  Future<DataState<String>> call(String city) {
    return bookmarkRepository.deleteCityByName(city);
  }
}
