// To parse this JSON data, do
//
//     final offerCodeResponse = offerCodeResponseFromMap(jsonString);

import 'dart:convert';

class OfferCodeResponse {
  OfferCodeResponse({
    this.data,
  });

  Code? data;

  OfferCodeResponse copyWith({
    Code? data,
  }) =>
      OfferCodeResponse(
        data: data ?? this.data,
      );

  factory OfferCodeResponse.fromJson(String str) => OfferCodeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfferCodeResponse.fromMap(Map<String, dynamic> json) => OfferCodeResponse(
    data: json["data"] == null ? null : Code.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}

class Code {
  Code({
    this.id,
    this.type,
    this.value,
  });

  int? id;
  String? type;
  String? value;

  Code copyWith({
    int? id,
    String? type,
    String? value,
  }) =>
      Code(
        id: id ?? this.id,
        type: type ?? this.type,
        value: value ?? this.value,
      );

  factory Code.fromJson(String str) => Code.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Code.fromMap(Map<String, dynamic> json) => Code(
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "value": value == null ? null : value,
  };
}
