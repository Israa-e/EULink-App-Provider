// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromMap(jsonString);

import 'dart:convert';

import 'message_model.dart';

class ChatResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  ChatResponse({
    this.success,
    this.message,
    this.data,
  });

  ChatResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      ChatResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ChatResponse.fromJson(String str) => ChatResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatResponse.fromMap(Map<String, dynamic> json) => ChatResponse(
    success: json["success"],
    message: json["message"] == null ? [] : List<dynamic>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data?.toMap(),
  };
}

class Data {
  Chat? chat;

  Data({
    this.chat,
  });

  Data copyWith({
    Chat? chat,
  }) =>
      Data(
        chat: chat ?? this.chat,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    chat: json["Chat"] == null ? null : Chat.fromMap(json["Chat"]),
  );

  Map<String, dynamic> toMap() => {
    "Chat": chat?.toMap(),
  };
}

