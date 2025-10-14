// To parse this JSON data, do
//
//     final brandResponse = brandResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/brand/brand_model.dart';

class BrandResponse {
  BrandResponse({
    this.data,
  });

  Brand? data;

  BrandResponse copyWith({
    Brand? data,
  }) =>
      BrandResponse(
        data: data ?? this.data,
      );

  factory BrandResponse.fromJson(String str) => BrandResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandResponse.fromMap(Map<String, dynamic> json) => BrandResponse(
    data: json["data"] == null ? null : Brand.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}


