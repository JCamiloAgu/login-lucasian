import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/features/login/domain/response/login_response.dart';

abstract class LoginUseCaseContract {
  Future<LoginResponse> doLogin(LoginRequest loginRequest);
}
