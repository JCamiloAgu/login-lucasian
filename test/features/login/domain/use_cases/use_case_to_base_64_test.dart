import 'package:flutter_test/flutter_test.dart';
import 'package:login_lucasian/features/login/domain/use_cases/use_case_to_base_64.dart';

void main() {
  final useCaseToBase64 = UseCaseToBase64();

  group('Encriptar String en base64', (){
    test('Debería retornar un string codificado', () {
      final encodedString = useCaseToBase64.toBase64('password');

      expect(encodedString, isNotNull);
      expect(encodedString, isNotEmpty);
    });

    test('Debería retornar un string vacío cuando se envíe un null', () {
      final encodedString = useCaseToBase64.toBase64(null);

      expect(encodedString, isEmpty);
    });
  });
}
