import 'package:login_lucasian/core/error/dio/dio_error_message_strategy.dart';

class DioErrorMessageLoginStrategy implements DioErrorMessageStrategy {
  final Map<String, dynamic> error;

  DioErrorMessageLoginStrategy(this.error);

  @override
  String convertErrorToReadableString() {
    try {
      final message = error['message'].toString();
      return _transformMessageToReadableString(message);
    } on Exception catch (_) {
      return DioErrorMessageStrategy.unexpectedError;
    }
  }

  String _transformMessageToReadableString(String message) {
    if (message.contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
      return _tooManyAttempts;
    }

    if (message.contains('INVALID_PASSWORD')) {
      return _invalidPassword;
    }

    if (message.contains('EMAIL_NOT_FOUND')) {
      return _emailNotFound;
    }

    if (message.contains('USER_DISABLED')) {
      return _userDisabled;
    }

    return DioErrorMessageStrategy.unexpectedError;
  }

  final String _tooManyAttempts =
      'El acceso a esta cuenta se ha desactivado temporalmente debido a muchos intentos fallidos de inicio de sesión. Puede restaurarlo inmediatamente restableciendo su contraseña o puede intentarlo de nuevo más tarde.';
  final String _invalidPassword = 'Contraseña incorrecta';
  final String _emailNotFound = 'No se encontró el correo electrónico';
  final String _userDisabled = 'El usuario ha sido inhabilitado';
}
