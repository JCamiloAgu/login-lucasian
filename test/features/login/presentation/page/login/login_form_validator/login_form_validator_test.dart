import 'package:flutter_test/flutter_test.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_form_validator/login_form_validator.dart';

void main() {
  LoginFormValidator loginFormValidator = LoginFormValidator();

  group('Validaciones del email', () {
    test(
        'Debería retornar false porque el email está vacío o es null o tiene más de 60 letras',
        () {
      expect(loginFormValidator.isValidEmail(''), isFalse);
      expect(loginFormValidator.isValidEmail(null), isFalse);
      expect(
          loginFormValidator.isValidEmail(
              'email@emailemailemailemailemailemailemailemailemailemailemail'),
          isFalse);
    });

    test(
        'Debería retornar false porque el email no contiene la estructura requerida',
        () {
      expect(loginFormValidator.isValidEmail('email@email'), isFalse);
      expect(loginFormValidator.isValidEmail('email@.com'), isFalse);
      expect(loginFormValidator.isValidEmail('email@mail.'), isFalse);
      expect(loginFormValidator.isValidEmail('@mail.com'), isFalse);
    });

    test('Debería retornar true', () {
      expect(loginFormValidator.isValidEmail('mail@mail.com'), isTrue);
    });
  });

  group('Validaciones del password', () {
    test('Debería retornar false', () {
      expect(loginFormValidator.isValidPassword(null), isFalse);
      expect(loginFormValidator.isValidPassword(''), isFalse);
      expect(loginFormValidator.isValidPassword('passwordpassword'), isFalse);
    });
    test('Debería retornar true', () {
      expect(loginFormValidator.isValidPassword('correct-pass000'), isTrue);
    });
  });
}
