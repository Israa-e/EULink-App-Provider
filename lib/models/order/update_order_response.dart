// To parse this JSON data, do
//
//     final updateOrderResponse = updateOrderResponseFromJson(jsonString);

import 'dart:convert';

UpdateOrderResponse updateOrderResponseFromJson(String str) => UpdateOrderResponse.fromJson(json.decode(str));

String updateOrderResponseToJson(UpdateOrderResponse data) => json.encode(data.toJson());

class UpdateOrderResponse {
  UpdateOrderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<String> message;
  List<dynamic> data;

  factory UpdateOrderResponse.fromJson(Map<String, dynamic> json) => UpdateOrderResponse(
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
