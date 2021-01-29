import 'package:flutter/material.dart';
import 'package:login_lucasian/domain/use_cases/login_use_case_contract.dart';
import 'package:login_lucasian/domain/use_cases/use_case_to_base_64.dart';
import 'package:login_lucasian/models/login_request.dart';
import 'package:login_lucasian/ui/pages/login/login_response.dart';

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
      loginRequest.password = useCaseToBase64.toBase64(loginRequest.password);
      LoginResponse loginResponse =
          await loginUseCaseContract.doLogin(loginRequest);

      isLoginOk = loginResponse.isLoginOk;
      badLoginMessage = loginResponse.message;
    }

    isLoading = false;
  }

  bool validateFields(LoginRequest loginRequest) {
    bool isValidLoginRequest = true;
    if (!loginFormValidator.isValidEmail(loginRequest.email)) {
      isValidEmail = false;
      isValidLoginRequest = false;
    } else {
      isValidEmail = true;
    }

    if (!loginFormValidator.isValidPassword(loginRequest.password)) {
      isValidPassword = false;
      isValidLoginRequest = false;
    } else {
      isValidPassword = true;
    }

    return isValidLoginRequest;
  }
}
