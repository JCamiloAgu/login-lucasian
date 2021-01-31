import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_strategy.dart';

enum Status { ok, fail }

class Result<T> {
  Status status;

  T data;

  Result(Status status, T data) {
    this.status = status;
    this.data = data;
  }

  T getData() {
    return data;
  }

  Status getStatus() {
    return status;
  }
}

class Success<T> extends Result<T> {
  Success(T data, Status dataStatus) : super(dataStatus, data);
}

class Error<T> extends Result<T> {
  String _error;

  String get error => _error;

  Error(T data, Status dataStatus,
      DioErrorMessageStrategy dioErrorMessageStrategy)
      : _error = dioErrorMessageStrategy?.convertErrorToReadableString(),
        super(dataStatus, data);
}
