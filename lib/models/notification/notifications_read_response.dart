// To parse this JSON data, do
//
//     final notificationsReadResponse = notificationsReadResponseFromJson(jsonString);

import 'dart:convert';

NotificationsReadResponse notificationsReadResponseFromJson(String str) => NotificationsReadResponse.fromJson(json.decode(str));

String notificationsReadResponseToJson(NotificationsReadResponse data) => json.encode(data.toJson());

class NotificationsReadResponse {
  NotificationsReadResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<String> message;
  List<dynamic> data;

  factory NotificationsReadResponse.fromJson(Map<String, dynamic> json) => NotificationsReadResponse(
    success: json["success"],
    message: List<String>.from(json["message"].map((x) => x)),
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
