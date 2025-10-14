import 'dart:convert';

import 'package:get/get.dart';

class Semester {
  Semester({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.gpa,
    this.semesterCourse,
  });

  int? id;
  int? userId;
  String? name;
  String? description;
  String? gpa;
  List<dynamic>? semesterCourse;
  bool isSelect = false ;

  Semester copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    String? gpa,
    List<dynamic>? semesterCourse,
  }) =>
      Semester(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        description: description ?? this.description,
        gpa: gpa ?? this.gpa,
        semesterCourse: semesterCourse ?? this.semesterCourse,
      );

  factory Semester.fromJson(String str) => Semester.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Semester.fromMap(Map<String, dynamic> json) => Semester(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : (json["name"].toString()).tr,
    description: json["description"] == null ? null : json["description"],
    gpa: json["gpa"] == null ? "0" : json["gpa"].toString(),
    semesterCourse: json["SemesterCourse"] == null ? null : List<dynamic>.from(json["SemesterCourse"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "gpa": gpa == null ? "0" : gpa,
    "SemesterCourse": semesterCourse == null ? null : List<dynamic>.from(semesterCourse!.map((x) => x)),
  };
}
