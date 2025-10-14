// To parse this JSON data, do
//
//     final universitiesResponse = universitiesResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/universitie/universitie_model.dart';

class UniversitiesResponse {
  UniversitiesResponse({
    this.data,
  });

  List<University>? data;

  UniversitiesResponse copyWith({
    List<University>? data,
  }) =>
      UniversitiesResponse(
        data: data ?? this.data,
      );

  factory UniversitiesResponse.fromJson(String str) => UniversitiesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UniversitiesResponse.fromMap(Map<String, dynamic> json) => UniversitiesResponse(
    data: json["data"] == null ? null : List<University>.from(json["data"].map((x) => University.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

