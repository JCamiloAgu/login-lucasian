import 'package:flutter_test/flutter_test.dart';
import 'package:login_lucasian/core/result/result.dart';
import 'package:login_lucasian/features/login/domain/repositoy/login_repository_contract.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:login_lucasian/features/login/domain/use_cases/login_use_case.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryContractMock extends Mock
    implements LoginRepositoryContract {}

void main() {
  LoginUseCase loginUseCase;
  LoginRepositoryContractMock loginRepositoryContractMock;

  setUp(() {
    loginRepositoryContractMock = LoginRepositoryContractMock();
    loginUseCase = LoginUseCase(loginRepositoryContractMock);
  });

  group('Petición de login al repositorio', () {
    test('Debería responder un SUCCESS', () async {
      when(loginRepositoryContractMock.doLogin(any))
          .thenAnswer((realInvocation) async => Success(null, Status.ok));

      final result =
          await loginUseCase.doLogin(LoginRequest('test@test', 'password'));

      expect(result, isA<Success>());
      expect(result.status, equals(Status.ok));
    });

    test('Debería responder un ERROR', () async {
      when(loginRepositoryContractMock.doLogin(any))
          .thenAnswer((realInvocation) async => Error(null, Status.fail, null));

      final result =
          await loginUseCase.doLogin(LoginRequest('test@test', 'password'));

      expect(result, isA<Error>());
      expect(result.status, equals(Status.fail));
    });
  });
}
