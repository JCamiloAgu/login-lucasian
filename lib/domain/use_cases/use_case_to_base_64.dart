import 'dart:convert';

class UseCaseToBase64 {
  String toBase64(String password) {
    final bytes = utf8.encode(password);
    return base64Encode(bytes);
  }
}
