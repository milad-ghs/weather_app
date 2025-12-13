abstract class DataState<T> {
  T? data;

  String? message;

  DataState(this.data, this.message);
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T? data) : super(data, null);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(String? message) : super(null, message);
}
