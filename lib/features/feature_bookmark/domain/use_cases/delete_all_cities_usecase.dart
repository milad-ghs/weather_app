import 'package:weather_app_new/core/resource/data_state.dart';
import 'package:weather_app_new/core/usecase/use_case.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/repository/bookmark_repository.dart';

class DeleteAllCitiesUseCase extends UseCase<DataState<void>, NoParams>{
  final BookmarkRepository bookmarkRepository;
  DeleteAllCitiesUseCase(this.bookmarkRepository);
  @override
  Future<DataState<void>> call(NoParams param) {
   return bookmarkRepository.deleteAllCities();
  }


}