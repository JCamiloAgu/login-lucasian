import 'dart:convert';

import 'package:login_lucasian/core/error/dio/dio_error_message_type.dart';
import 'package:login_lucasian/core/error/dio/factory/dio_error_message_factory_contract.dart';
import 'package:login_lucasian/core/result/result.dart';
import 'package:login_lucasian/features/login/data/data_sources/login_data_source_contract.dart';
import 'package:login_lucasian/features/login/domain/repositoy/login_repository_contract.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/features/login/domain/response/login_response.dart';
import 'package:meta/meta.dart';

class LoginRepository implements LoginRepositoryContract {
  final LoginDataSourceContract loginDataSourceContract;
  final DioErrorMessageFactoryContract dioErrorMessageFactoryContract;

  LoginRepository(
      {@required this.loginDataSourceContract,
      @required this.dioErrorMessageFactoryContract});

  @override
  Future<Result<LoginResponse>> doLogin(LoginRequest loginRequest) async {
    final response = await loginDataSourceContract.doLogin(loginRequest);
    if (response.statusCode == 200) {
      return Success(
          loginResponseFromJson(json.encode(response.data)), Status.ok);
    } else {
      return Error(
          null,
          Status.fail,
          dioErrorMessageFactoryContract.getStrategy(
              DioErrorMessageType.LOGIN, response.data['error']));
    }
  }
}
