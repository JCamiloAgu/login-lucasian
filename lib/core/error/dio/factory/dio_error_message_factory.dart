import 'package:login_lucasian/core/error/dio/dio_error_message_type.dart';
import 'package:login_lucasian/core/error/dio/factory/dio_error_message_factory_contract.dart';
import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_default_strategy.dart';
import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_login_strategy.dart';
import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_strategy.dart';

class DioErrorMessageFactory implements DioErrorMessageFactoryContract {
  @override
  DioErrorMessageStrategy getStrategy(
      DioErrorMessageType type, Map<String, dynamic> error) {
    switch (type) {
      case DioErrorMessageType.LOGIN:
        return DioErrorMessageLoginStrategy(error);
      default:
        return DioErrorMessageDefaultStrategy();
    }
  }
}
