import 'package:login_lucasian/domain/repositoy/login_repository_contract.dart';
import 'package:login_lucasian/domain/use_cases/login_use_case_contract.dart';
import 'package:login_lucasian/models/login_request.dart';
import 'package:login_lucasian/ui/pages/login/login_response.dart';

class LoginUseCase implements LoginUseCaseContract {
  final LoginRepositoryContract loginRepositoryContract;

  LoginUseCase(this.loginRepositoryContract);

  @override
  Future<LoginResponse> doLogin(LoginRequest loginRequest) async {
    return await loginRepositoryContract.doLogin(loginRequest);
  }
}
