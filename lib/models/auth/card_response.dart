// To parse this JSON data, do
//
//     final cardResponse = cardResponseFromMap(jsonString);

import 'dart:convert';

class CardResponse {
  CardResponse({
    this.qrCode,
    this.id,
    this.name,
    this.universityName,
  });

  String? qrCode;
  String? id;
  String? name;
  String? universityName;

  CardResponse copyWith({
    String? qrCode,
    String? id,
    String? name,
    String? universityName,
  }) =>
      CardResponse(
        qrCode: qrCode ?? this.qrCode,
        id: id ?? this.id,
        name: name ?? this.name,
        universityName: universityName ?? this.universityName,
      );

  factory CardResponse.fromJson(String str) => CardResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardResponse.fromMap(Map<String, dynamic> json) => CardResponse(
    qrCode:  json["qr_code"] == null ? null : json["qr_code"],
    id: json["id"] == null ? null : json["id"],
    name:json["name"] == null ? null : json["name"],
    universityName:json["university_name"] == null ? null : json["university_name"],
  );

  Map<String, dynamic> toMap() => {
    "qr_code":  qrCode == null ? null :qrCode,
    "id": id == null ? null :id,
    "name": name == null ? null :name,
    "university_name": universityName == null ? null :universityName,
  };
}
