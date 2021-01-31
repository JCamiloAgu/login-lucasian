import 'package:login_lucasian/features/login/domain/repositoy/login_repository_contract.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/features/login/domain/response/login_response.dart';

import 'login_use_case_contract.dart';

class LoginUseCase implements LoginUseCaseContract {
  final LoginRepositoryContract loginRepositoryContract;

  LoginUseCase(this.loginRepositoryContract);

  @override
  Future<LoginResponse> doLogin(LoginRequest loginRequest) async {
    return await loginRepositoryContract.doLogin(loginRequest);
  }
}
