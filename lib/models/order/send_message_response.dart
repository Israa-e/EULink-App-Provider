// To parse this JSON data, do
//
//     final sendMessageResponse = sendMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/order/show_messages_response.dart';

SendMessageResponse sendMessageResponseFromJson(String str) => SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) => json.encode(data.toJson());

class SendMessageResponse {
  SendMessageResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
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
    required this.chat,
  });

  Chat chat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    chat: Chat.fromJson(json["Chat"]),
  );

  Map<String, dynamic> toJson() => {
    "Chat": chat.toJson(),
  };
}

