part of 'delete_all_bloc.dart';

@immutable
sealed class DeleteAllState  extends Equatable{}

final class DeleteAllInitial extends DeleteAllState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class DeleteAllLoading extends DeleteAllState{
  @override
  List<Object?> get props => [];
}
class DeleteAllCompleted extends DeleteAllState{
  @override
  List<BookmarkedCity?> get props => [];
}
class DeleteAllError extends DeleteAllState{
  final String message;
  DeleteAllError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
