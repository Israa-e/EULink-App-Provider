// To parse this JSON data, do
//
//     final userResponse = userResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/auth/user.dart';

class UserResponse {
  UserResponse({
    this.message,
    this.user,
  });
  String? message;
  User? user;

  UserResponse copyWith({
    String? message,
    User? user,
  }) =>
      UserResponse(
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory UserResponse.fromJson(String str) => UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
    message: json["message"] == null ? null : json["message"],
    user: json["User"] == null ? null : User.fromMap(json["User"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message.toString(),
    "User": user == null ? null : user!.toMap(),
  };
}


