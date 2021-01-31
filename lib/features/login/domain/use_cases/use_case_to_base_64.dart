import 'dart:convert';

class UseCaseToBase64 {
  String toBase64(String password) {
    try {
      final bytes = utf8.encode(password ?? '');
      return base64Encode(bytes);
    } on Exception catch (_) {
      return '';
    }
  }
}
