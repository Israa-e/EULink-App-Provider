
import 'dart:convert';

class City {
  City({
    this.id,
    this.name,
  });

  int? id;
  String? name;
  bool isSelect = false ;

  City copyWith({
    int? id,
    String? name,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}