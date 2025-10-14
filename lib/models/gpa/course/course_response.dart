// To parse this JSON data, do
//
//     final courseResponse = courseResponseFromMap(jsonString);

import 'dart:convert';

import 'course_model.dart';

class CourseResponse {
  CourseResponse({
    this.data,
  });

  Course? data;

  CourseResponse copyWith({
    Course? data,
  }) =>
      CourseResponse(
        data: data ?? this.data,
      );

  factory CourseResponse.fromJson(String str) => CourseResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseResponse.fromMap(Map<String, dynamic> json) => CourseResponse(
    data: json["data"] == null ? null : Course.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}
