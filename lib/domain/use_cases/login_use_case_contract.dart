import 'package:login_lucasian/models/login_request.dart';
import 'package:login_lucasian/ui/pages/login/login_response.dart';

abstract class LoginUseCaseContract {
  Future<LoginResponse> doLogin(LoginRequest loginRequest);
}