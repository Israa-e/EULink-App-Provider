// To parse this JSON data, do
//
//     final visitorResponse = visitorResponseFromMap(jsonString);

import 'dart:convert';

class VisitorResponse {
  VisitorResponse({
    this.data,
  });

  Data? data;

  VisitorResponse copyWith({
    Data? data,
  }) =>
      VisitorResponse(
        data: data ?? this.data,
      );

  factory VisitorResponse.fromJson(String str) => VisitorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VisitorResponse.fromMap(Map<String, dynamic> json) => VisitorResponse(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}

class Data {
  Data({
    this.id,
    this.deviceToken,
    this.deviceType,
    this.deviceId,
  });

  int? id;
  String? deviceToken;
  String? deviceType;
  dynamic? deviceId;

  Data copyWith({
    int? id,
    String? deviceToken,
    String? deviceType,
    dynamic? deviceId,
  }) =>
      Data(
        id: id ?? this.id,
        deviceToken: deviceToken ?? this.deviceToken,
        deviceType: deviceType ?? this.deviceType,
        deviceId: deviceId ?? this.deviceId,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    deviceToken: json["device_token"] == null ? null : json["device_token"],
    deviceType: json["device_type"] == null ? null : json["device_type"],
    deviceId: json["device_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "device_token": deviceToken == null ? null : deviceToken,
    "device_type": deviceType == null ? null : deviceType,
    "device_id": deviceId,
  };
}
