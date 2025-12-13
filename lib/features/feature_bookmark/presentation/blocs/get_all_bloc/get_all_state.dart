part of 'get_all_bloc.dart';

@immutable
sealed class GetAllState {}

final class GetAllInitial extends GetAllState {}

class GetAllLoading extends GetAllState {}

class GetAllSuccess extends GetAllState {
final List<BookmarkedCity> cities;
  GetAllSuccess({required this.cities});
}

class GetAllError extends GetAllState {
  final String message;

  GetAllError(this.message);
}
