import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_lucasian/core/error/dio/factory/dio_error_message_factory.dart';
import 'package:login_lucasian/core/error/dio/strategy/dio_error_message_default_strategy.dart';
import 'package:login_lucasian/core/result/result.dart';
import 'package:login_lucasian/features/login/data/remote_data_sources/login_data_source.dart';
import 'package:login_lucasian/features/login/data/repositories/login_repository.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:mockito/mockito.dart';

class LoginDataSourceMock extends Mock implements LoginDataSource {}

class DioErrorMessageFactoryMock extends Mock
    implements DioErrorMessageFactory {}

void main() {
  LoginDataSource loginDataSource;
  LoginRepository loginRepository;
  DioErrorMessageFactoryMock dioErrorMessageFactoryMock;

  setUp(() {
    loginDataSource = LoginDataSourceMock();
    dioErrorMessageFactoryMock = DioErrorMessageFactoryMock();

    loginRepository = LoginRepository(
        loginDataSourceContract: loginDataSource,
        dioErrorMessageFactoryContract: dioErrorMessageFactoryMock);
  });

  group('Petición del login al DataSource', () {
    test('Debería retornar un Status SUCCESS', () async {
      when(loginDataSource.doLogin(any))
          .thenAnswer((realInvocation) async => Response(
                statusCode: 200,
              ));

      final response = await loginRepository
          .doLogin(LoginRequest('test@test.com', 'password'));

      expect(response.status, Status.ok);
    });

    test('Debería retornar un Status ERROR', () async {
      when(loginDataSource.doLogin(any)).thenAnswer(
          (realInvocation) async => Response(statusCode: 400, data: {
                'error': {
                  "message": "EMAIL_NOT_FOUND",
                }
              }));

      when(dioErrorMessageFactoryMock.getStrategy(any, any))
          .thenReturn(DioErrorMessageDefaultStrategy());

      final response = await loginRepository
          .doLogin(LoginRequest('test@test.com', 'password'));

      expect(response.status, Status.fail);
      expect((response as Error).error, isNotEmpty);
    });
  });
}
