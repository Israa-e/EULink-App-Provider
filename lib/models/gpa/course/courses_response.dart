// To parse this JSON data, do
//
//     final coursesResponse = coursesResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/base/links.dart';
import 'package:provider/models/base/meta.dart';
import 'package:provider/models/gpa/course/course_model.dart';

class CoursesResponse {
  CoursesResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<Course>? data;
  Links? links;
  Meta? meta;

  CoursesResponse copyWith({
    List<Course>? data,
    Links? links,
    Meta? meta,
  }) =>
      CoursesResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory CoursesResponse.fromJson(String str) => CoursesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoursesResponse.fromMap(Map<String, dynamic> json) => CoursesResponse(
    data: json["data"] == null ? null : List<Course>.from(json["data"].map((x) => Course.fromMap(x))),
    links: json["links"] == null ? null : Links.fromMap(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
    "links": links == null ? null : links!.toMap(),
    "meta": meta == null ? null : meta!.toMap(),
  };
}


