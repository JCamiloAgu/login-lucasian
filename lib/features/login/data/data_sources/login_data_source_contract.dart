import 'package:dio/dio.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';

abstract class LoginDataSourceContract {
  Future<Response> doLogin(LoginRequest loginRequest);
}
