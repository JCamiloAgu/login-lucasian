import 'package:login_lucasian/features/login/domain/models/login_request.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_response.dart';

abstract class LoginUseCaseContract {
  Future<LoginResponse> doLogin(LoginRequest loginRequest);
}
