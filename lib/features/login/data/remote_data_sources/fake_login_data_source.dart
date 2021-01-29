import 'dart:convert';

import 'package:login_lucasian/features/login/data/data_sources/login_data_source_contract.dart';
import 'package:login_lucasian/features/login/domain/models/login_request.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_response.dart';

class FakeLoginDataSource implements LoginDataSourceContract {
  @override
  Future<LoginResponse> doLogin(LoginRequest loginRequest) async {
    await Future.delayed(Duration(seconds: 2));
    final isLoginOk = _isCorrectEmail(loginRequest.email) &&
        _isCorrectPassword(loginRequest.password);

    var message = !_isCorrectEmail(loginRequest.email)
        ? 'Por favor revise sus credenciales e intente nuevamente.'
        : 'Contraseña incorrecta';

    if (isLoginOk) {
      message = '';
    }

    return LoginResponse(isLoginOk, message);
  }

  bool _isCorrectEmail(String email) => email == 'jagudelo@lucasian.com';

  bool _isCorrectPassword(String pwd) =>
      utf8.decode(base64Decode(pwd)) == '123456789';
}
