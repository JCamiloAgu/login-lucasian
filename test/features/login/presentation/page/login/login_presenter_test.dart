import 'package:flutter_test/flutter_test.dart';
import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_default_strategy.dart';
import 'package:login_lucasian/core/result/result.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/features/login/domain/use_cases/login_use_case_contract.dart';
import 'package:login_lucasian/features/login/domain/use_cases/use_case_to_base_64.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_form_validator/login_form_validator.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_presenter.dart';
import 'package:mockito/mockito.dart';

class LoginUseCaseContractMock extends Mock implements LoginUseCaseContract {}

class UseCaseToBase64Mock extends Mock implements UseCaseToBase64 {}

class LoginFormValidatorMock extends Mock implements LoginFormValidator {}

void main() {
  LoginPresenter loginPresenter;

  LoginUseCaseContract loginUseCaseContract;
  UseCaseToBase64 useCaseToBase64;
  LoginFormValidator loginFormValidator;

  setUp(() {
    loginUseCaseContract = LoginUseCaseContractMock();
    useCaseToBase64 = UseCaseToBase64Mock();
    loginFormValidator = LoginFormValidatorMock();

    when(useCaseToBase64.toBase64(any)).thenReturn('encodedPassword');
    when(loginFormValidator.isValidEmail(any)).thenReturn(true);
    when(loginFormValidator.isValidPassword(any)).thenReturn(true);

    loginPresenter = LoginPresenter(
        loginUseCaseContract, loginFormValidator, useCaseToBase64);
  });

  group('Validaciones', () {
    test('isAnyInput Debería retornar true isAnyInput', () {
      expect(loginPresenter.isAnyInputEmpty('', 'pass'), isTrue);
      expect(loginPresenter.isAnyInputEmpty('email', ''), isTrue);
    });
    test('isAnyInput Debería retornar false isAnyInput', () {
      expect(loginPresenter.isAnyInputEmpty('ssa', 'pass'), isFalse);
    });

    test('El password es inválido', () {
      when(loginFormValidator.isValidPassword(any)).thenReturn(false);

      expect(loginPresenter.isValidPassword, isTrue);

      final isValidPassword = loginPresenter.validatePassword('password');

      expect(isValidPassword, isFalse);
      expect(loginPresenter.isValidPassword, isFalse);
    });

    test('El password es válido', () {
      when(loginFormValidator.isValidPassword(any)).thenReturn(true);

      expect(loginPresenter.isValidPassword, isTrue);

      final isValidPassword = loginPresenter.validatePassword('password');

      expect(isValidPassword, isTrue);
      expect(loginPresenter.isValidPassword, isTrue);
    });

    test('El email es inválido', () {
      when(loginFormValidator.isValidEmail(any)).thenReturn(false);

      expect(loginPresenter.isValidEmail, isTrue);

      final isValidEmail = loginPresenter.validateEmail('email');

      expect(isValidEmail, isFalse);
      expect(loginPresenter.isValidEmail, isFalse);
    });

    test('El email es válido', () {
      when(loginFormValidator.isValidEmail(any)).thenReturn(true);

      expect(loginPresenter.isValidEmail, isTrue);

      final isValidEmail = loginPresenter.validateEmail('email');

      expect(isValidEmail, isTrue);
      expect(loginPresenter.isValidEmail, isTrue);
    });

    test('ValidateFields debería retorna false por el email inválido', () {
      when(loginFormValidator.isValidEmail(any)).thenReturn(false);
      when(loginFormValidator.isValidPassword(any)).thenReturn(true);

      final loginRequest = LoginRequest('', 'password');
      expect(loginPresenter.validateFields(loginRequest), isFalse);
    });

    test('ValidateFields debería retorna false por el password inválido', () {
      when(loginFormValidator.isValidEmail(any)).thenReturn(true);
      when(loginFormValidator.isValidPassword(any)).thenReturn(false);

      final loginRequest = LoginRequest('email', '');
      expect(loginPresenter.validateFields(loginRequest), isFalse);
    });

    test(
        'ValidateFields debería retorna false por el password y el email inválidos',
        () {
      when(loginFormValidator.isValidEmail(any)).thenReturn(false);
      when(loginFormValidator.isValidPassword(any)).thenReturn(false);

      final loginRequest = LoginRequest('', '');
      expect(loginPresenter.validateFields(loginRequest), isFalse);
    });

    test('ValidateFields debería retorna true', () {
      when(loginFormValidator.isValidEmail(any)).thenReturn(true);
      when(loginFormValidator.isValidPassword(any)).thenReturn(true);

      final loginRequest = LoginRequest('email', 'password');
      expect(loginPresenter.validateFields(loginRequest), isTrue);
    });
  });

  group('Login', () {
    test(
        'El isLoading debe estar en true cuando inicia la petición y en false cuando termina',
        () {
      when(loginUseCaseContract.doLogin(any))
          .thenAnswer((realInvocation) async => Success(null, Status.ok));
      when(loginFormValidator.isValidEmail(any)).thenReturn(true);
      when(loginFormValidator.isValidPassword(any)).thenReturn(true);

      expect(loginPresenter.isLoading, isFalse);

      loginPresenter
          .doLogin(LoginRequest('email', 'password'))
          .then((value) => expect(loginPresenter.isLoading, isFalse));

      expect(loginPresenter.isLoading, isTrue);
    });

    test(
        'El login se realiza correctamente y el badLoginMessage está vacío y isLoginOk es true',
        () async {
      when(loginUseCaseContract.doLogin(any))
          .thenAnswer((realInvocation) async => Success(null, Status.ok));

      await loginPresenter.doLogin(LoginRequest('email', 'password'));

      expect(loginPresenter.isLoginOk, isTrue);
      expect(loginPresenter.badLoginMessage, isEmpty);
    });

    test(
        'El login falla y el badLoginMessage tiene información y isLoginOk es false',
        () async {
      when(loginUseCaseContract.doLogin(any)).thenAnswer(
          (realInvocation) async =>
              Error(null, Status.fail, DioErrorMessageDefaultStrategy()));

      await loginPresenter.doLogin(LoginRequest('email', 'password'));

      expect(loginPresenter.isLoginOk, isFalse);
      expect(loginPresenter.badLoginMessage, isNotEmpty);
    });
  });
}
