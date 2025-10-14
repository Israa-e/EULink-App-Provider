// To parse this JSON data, do
//
//     final slidersResponse = slidersResponseFromMap(jsonString);

import 'dart:convert';

import 'slider_model.dart';

class SlidersResponse {
  SlidersResponse({
    this.data,
  });

  List<Slider>? data;

  SlidersResponse copyWith({
    List<Slider>? data,
  }) =>
      SlidersResponse(
        data: data ?? this.data,
      );

  factory SlidersResponse.fromJson(String str) => SlidersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SlidersResponse.fromMap(Map<String, dynamic> json) => SlidersResponse(
    data: json["data"] == null ? null : List<Slider>.from(json["data"].map((x) => Slider.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

