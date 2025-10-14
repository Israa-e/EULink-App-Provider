// To parse this JSON data, do
//
//     final chooseServicesResponse = chooseServicesResponseFromJson(jsonString);

import 'dart:convert';

ChooseServicesResponse chooseServicesResponseFromJson(String str) => ChooseServicesResponse.fromJson(json.decode(str));

String chooseServicesResponseToJson(ChooseServicesResponse data) => json.encode(data.toJson());

class ChooseServicesResponse {
  ChooseServicesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  List<String> data;

  factory ChooseServicesResponse.fromJson(Map<String, dynamic> json) => ChooseServicesResponse(
    success: json["success"],
    message: List<dynamic>.from(json["message"].map((x) => x)),
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
