

import 'dart:convert';

class Course {
  Course({
    this.id,
    this.semesterId,
    this.name,
    this.credit,
    this.grade,
    this.gpa,
  });

  int? id;
  int? semesterId;
  String? name;
  int? credit;
  String? grade;
  dynamic? gpa;

  Course copyWith({
    int? id,
    int? semesterId,
    String? name,
    int? credit,
    String? grade,
    dynamic? gpa,
  }) =>
      Course(
        id: id ?? this.id,
        semesterId: semesterId ?? this.semesterId,
        name: name ?? this.name,
        credit: credit ?? this.credit,
        grade: grade ?? this.grade,
        gpa: gpa ?? this.gpa,
      );

  factory Course.fromJson(String str) => Course.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Course.fromMap(Map<String, dynamic> json) => Course(
    id: json["id"] == null ? null : json["id"],
    semesterId: json["semester_id"] == null ? null : json["semester_id"],
    name: json["name"] == null ? null : json["name"],
    credit: json["credit"] == null ? null : json["credit"],
    grade: json["grade"] == null ? null : json["grade"],
    gpa: json["gpa"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "semester_id": semesterId == null ? null : semesterId,
    "name": name == null ? null : name,
    "credit": credit == null ? null : credit,
    "grade": grade == null ? null : grade,
    "gpa": gpa,
  };
}
