abstract class DioErrorMessageStrategy {
  String convertErrorToReadableString();

  final Map<String, dynamic> error;

  DioErrorMessageStrategy(this.error);

  static const unexpectedError = 'Ocurrió un error inesperado';
}
