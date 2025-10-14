// To parse this JSON data, do
//
//     final semestersResponse = semestersResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/base/links.dart';
import 'package:provider/models/base/meta.dart';

import 'semester_model.dart';

class SemestersResponse {
  SemestersResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<Semester>? data;
  Links? links;
  Meta? meta;

  SemestersResponse copyWith({
    List<Semester>? data,
    Links? links,
    Meta? meta,
  }) =>
      SemestersResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory SemestersResponse.fromJson(String str) => SemestersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SemestersResponse.fromMap(Map<String, dynamic> json) => SemestersResponse(
    data: json["data"] == null ? null : List<Semester>.from(json["data"].map((x) => Semester.fromMap(x))),
    links: json["links"] == null ? null : Links.fromMap(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
    "links": links == null ? null : links!.toMap(),
    "meta": meta == null ? null : meta!.toMap(),
  };
}




