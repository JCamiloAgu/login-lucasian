import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:login_lucasian/features/login/data/data_sources/login_data_source_contract.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:meta/meta.dart';

class LoginDataSource implements LoginDataSourceContract {
  static const _API_BASE_URL = 'https://identitytoolkit.googleapis.com/v1';
  static const _API_KEY = 'AIzaSyAtPXM03HvfFYuVBYXzMgpGMFQkkwWmDac';
  final Dio dio;

  LoginDataSource({@required this.dio});

  @override
  Future<Response> doLogin(LoginRequest loginRequest) async {
    BaseOptions options =
        new BaseOptions(headers: {'Content-Type': 'application/json'});

    dio.options = options;

    try {
      return await dio.post('$_API_BASE_URL/accounts:signInWithPassword',
          data: json.encode(loginRequest.toMap()),
          queryParameters: {'key': _API_KEY});
    } on DioError catch (e) {
      return e.response;
    }
  }
}
