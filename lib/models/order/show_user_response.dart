// To parse this JSON data, do
//
//     final showUserResponse = showUserResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/auth/user.dart';
import 'package:provider/models/order/order_response.dart';

ShowUserResponse showUserResponseFromJson(String str) => ShowUserResponse.fromJson(json.decode(str));

String showUserResponseToJson(ShowUserResponse data) => json.encode(data.toJson());

class ShowUserResponse {
  ShowUserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory ShowUserResponse.fromJson(Map<String, dynamic> json) => ShowUserResponse(
    success: json["success"],
    message: List<dynamic>.from(json["message"].map((x) => x)),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.user,
  });

  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "User": user.toJson(),
  };
}


