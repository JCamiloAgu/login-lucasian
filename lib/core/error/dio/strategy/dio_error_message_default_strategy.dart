import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_strategy.dart';

class DioErrorMessageDefaultStrategy implements DioErrorMessageStrategy {
  @override
  String convertErrorToReadableString() =>
      DioErrorMessageStrategy.unexpectedError;

  @override
  Map<String, dynamic> error;
}
