import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_lucasian/features/login/data/remote_data_sources/login_data_source.dart';
import 'package:login_lucasian/features/login/domain/request/login_request.dart';
import 'package:mockito/mockito.dart';

import '../../../../instrument/helper/helper.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  final Dio dio = Dio();
  DioAdapterMock dioAdapterMock;
  LoginDataSource loginDataSource;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    loginDataSource = LoginDataSource(dio: dio);
  });

  group('Petición de login al servidor', () {
    test('Debería retornar un json con un error de INVALID_PASSWORD', () async {
      final responsePayload =
          Helper.readFile('dio_http_response_mocks/login/post_login_400.json');

      final httpResponse =
          ResponseBody.fromString(responsePayload, 400, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response =
          await loginDataSource.doLogin(LoginRequest('test@test.com', 'test'));

      expect(response.data['error']['code'], equals(400));
      expect(response.data['error']['message'], equals('INVALID_PASSWORD'));
    });

    test('Debería retornar la infomación de un usuario', () async {
      final responsePayload =
          Helper.readFile('dio_http_response_mocks/login/post_login_200.json');

      final httpResponse =
          ResponseBody.fromString(responsePayload, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });

      when(dioAdapterMock.fetch(any, any, any))
          .thenAnswer((_) async => httpResponse);

      final response =
          await loginDataSource.doLogin(LoginRequest('test@test.com', 'test'));

      expect(response.data['error'], equals(null));
      expect(response.data['email'], isNotEmpty);
      expect(response.data['idToken'], isNotEmpty);
      expect(response.data['localId'], isNotEmpty);
    });
  });
}
