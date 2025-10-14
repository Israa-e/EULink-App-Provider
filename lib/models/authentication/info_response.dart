// To parse this JSON data, do
//
//     final infoResponse = infoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/authentication/provider.dart';

// To parse this JSON data, do
//
//     final infoResponse = infoResponseFromMap(jsonString);

import 'dart:convert';

class InfoResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  InfoResponse({
    this.success,
    this.message,
    this.data,
  });

  InfoResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      InfoResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory InfoResponse.fromJson(String str) => InfoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoResponse.fromMap(Map<String, dynamic> json) => InfoResponse(
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
  Provider? provider;

  Data({
    this.provider,
  });

  Data copyWith({
    Provider? provider,
  }) =>
      Data(
        provider: provider ?? this.provider,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    provider: json["Provider"] == null ? null : Provider.fromMap(json["Provider"]),
  );

  Map<String, dynamic> toMap() => {
    "Provider": provider?.toMap(),
  };
}






