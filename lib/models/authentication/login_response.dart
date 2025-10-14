// To parse this JSON data, do
//
//     final longinResponse = longinResponseFromJson(jsonString);

import 'dart:convert';

LonginResponse longinResponseFromJson(String str) => LonginResponse.fromJson(json.decode(str));

String longinResponseToJson(LonginResponse data) => json.encode(data.toJson());

class LonginResponse {
  LonginResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  List<dynamic> data;

  factory LonginResponse.fromJson(Map<String, dynamic> json) => LonginResponse(
    success: json["success"],
    message: List<dynamic>.from(json["message"].map((x) => x)),
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
