// To parse this JSON data, do
//
//     final infoResponse = infoResponseFromMap(jsonString);

import 'dart:convert';

class InfoResponse {
  InfoResponse({
    this.data,
  });

  String? data;

  InfoResponse copyWith({
    String? data,
  }) =>
      InfoResponse(
        data: data ?? this.data,
      );

  factory InfoResponse.fromJson(String str) => InfoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoResponse.fromMap(Map<String, dynamic> json) => InfoResponse(
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data,
  };
}
