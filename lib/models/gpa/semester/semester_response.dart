// To parse this JSON data, do
//
//     final semesterResponse = semesterResponseFromMap(jsonString);

import 'dart:convert';

import 'semester_model.dart';

class SemesterResponse {
  SemesterResponse({
    this.data,
  });

  Semester? data;

  SemesterResponse copyWith({
    Semester? data,
  }) =>
      SemesterResponse(
        data: data ?? this.data,
      );

  factory SemesterResponse.fromJson(String str) => SemesterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SemesterResponse.fromMap(Map<String, dynamic> json) => SemesterResponse(
    data: json["data"] == null ? null : Semester.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}

