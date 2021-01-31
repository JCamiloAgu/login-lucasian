// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.localId,
    this.email,
    this.displayName,
    this.idToken,
    this.registered,
  });

  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    localId: json["localId"],
    email: json["email"],
    displayName: json["displayName"],
    idToken: json["idToken"],
    registered: json["registered"],
  );

  Map<String, dynamic> toJson() => {
    "localId": localId,
    "email": email,
    "displayName": displayName,
    "idToken": idToken,
    "registered": registered,
  };
}
