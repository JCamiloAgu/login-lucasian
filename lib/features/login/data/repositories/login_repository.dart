import 'package:login_lucasian/features/login/data/data_sources/login_data_source_contract.dart';
import 'package:login_lucasian/features/login/domain/models/login_request.dart';
import 'package:login_lucasian/features/login/domain/repositoy/login_repository_contract.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_response.dart';
import 'package:meta/meta.dart';

class LoginRepository implements LoginRepositoryContract {
  final LoginDataSourceContract loginDataSourceContract;

  LoginRepository({@required this.loginDataSourceContract});

  @override
  Future<LoginResponse> doLogin(LoginRequest loginRequest) async {
    return await loginDataSourceContract.doLogin(loginRequest);
  }
}
