import 'package:flutter/material.dart';
import 'package:login_lucasian/core/result/result.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/features/login/domain/use_cases/login_use_case_contract.dart';
import 'package:login_lucasian/features/login/domain/use_cases/use_case_to_base_64.dart';

import '../../../domain/response/login_response.dart';
import 'login_form_validator/login_form_validator.dart';

class LoginPresenter extends ChangeNotifier {
  final LoginUseCaseContract loginUseCaseContract;
  final UseCaseToBase64 useCaseToBase64;

  final LoginFormValidator loginFormValidator;

  bool _isLoading = false;
  bool _isLoginOk;
  bool _isValidEmail = true;
  bool _isValidPassword = true;

  String badLoginMessage = '';

  bool get isValidEmail => _isValidEmail;

  set isValidEmail(bool value) {
    _isValidEmail = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoginOk => _isLoginOk;

  set isLoginOk(bool value) {
    _isLoginOk = value;
    notifyListeners();
  }

  bool get isValidPassword => _isValidPassword;

  set isValidPassword(bool value) {
    _isValidPassword = value;
    notifyListeners();
  }

  LoginPresenter(
    this.loginUseCaseContract,
    this.loginFormValidator,
    this.useCaseToBase64,
  );

  Future<void> doLogin(LoginRequest loginRequest) async {
    isLoading = true;

    if (validateFields(loginRequest)) {
      await _doLoginRequest(loginRequest);
    }

    isLoading = false;
  }

  bool validateFields(LoginRequest loginRequest) {
    bool isValidLoginRequest = true;

    if (!validateEmail(loginRequest.email)) {
      isValidLoginRequest = false;
    }

    if (!validatePassword(loginRequest.password)) {
      isValidLoginRequest = false;
    }

    return isValidLoginRequest;
  }

  Future<void> _doLoginRequest(LoginRequest loginRequest) async {
    loginRequest.password = useCaseToBase64.toBase64(loginRequest.password);
    Result<LoginResponse> loginResponse =
        await loginUseCaseContract.doLogin(loginRequest);

    isLoginOk = loginResponse.status == Status.ok;

    if (loginResponse is Error) {
      badLoginMessage = (loginResponse as Error).error;
    } else {
      badLoginMessage = '';
    }
  }

  bool validateEmail(String email) {
    if (!loginFormValidator.isValidEmail(email)) {
      isValidEmail = false;
      return false;
    } else {
      isValidEmail = true;
    }
    return true;
  }

  bool validatePassword(String password) {
    if (!loginFormValidator.isValidPassword(password)) {
      isValidPassword = false;
      return false;
    } else {
      isValidPassword = true;
    }
    return true;
  }

  bool isAnyInputEmpty(String email, String pass) => email.isEmpty || pass.isEmpty;
}
