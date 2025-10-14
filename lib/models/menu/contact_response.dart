// To parse this JSON data, do
//
//     final contactResponse = contactResponseFromJson(jsonString);

import 'dart:convert';

ContactResponse contactResponseFromJson(String str) => ContactResponse.fromJson(json.decode(str));

String contactResponseToJson(ContactResponse data) => json.encode(data.toJson());

class ContactResponse {
  ContactResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<String> message;
  List<dynamic> data;

  factory ContactResponse.fromJson(Map<String, dynamic> json) => ContactResponse(
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
