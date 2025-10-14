// To parse this JSON data, do
//
//     final userResponse = userResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/auth/user.dart';

class RegisterResponse {
  RegisterResponse({
    this.user,
  });
  User? user;

  RegisterResponse copyWith({
    String? message,
    User? user,
  }) =>
      RegisterResponse(
        user: user ?? this.user,
      );

  factory RegisterResponse.fromJson(String str) => RegisterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponse.fromMap(Map<String, dynamic> json) => RegisterResponse(
     user: json["data"] == null ? null : User.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
     "data": user == null ? null : user!.toMap(),
  };
}


