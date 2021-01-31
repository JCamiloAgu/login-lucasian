import 'package:login_lucasian/core/result/result.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/features/login/domain/response/login_response.dart';

abstract class LoginRepositoryContract {
  Future<Result<LoginResponse>> doLogin(LoginRequest loginRequest);
}
