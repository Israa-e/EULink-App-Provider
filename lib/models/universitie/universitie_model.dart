// To parse this JSON data, do
//
//     final universitiesResponse = universitiesResponseFromMap(jsonString);

import 'dart:convert';


class University {
  University({
    this.id,
    this.name,
  });

  int? id;
  String? name;
  bool isSelect = false ;

  University copyWith({
    int? id,
    String? name,
  }) =>
      University(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory University.fromJson(String str) => University.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory University.fromMap(Map<String, dynamic> json) => University(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
