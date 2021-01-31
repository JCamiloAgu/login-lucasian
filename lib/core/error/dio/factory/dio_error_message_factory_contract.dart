import 'package:login_lucasian/core/error/dio/dio_error_message_type.dart';
import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_strategy.dart';

abstract class DioErrorMessageFactoryContract {
  DioErrorMessageStrategy getStrategy(
      DioErrorMessageType dioErrorMessageType, Map<String, dynamic> error);
}
