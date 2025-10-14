
import 'dart:convert';

class Category {
  Category({
    this.id,
    this.name,

  });

  int? id;
  String? name;
  bool isSelect = false ;
  Category copyWith({
    int? id,
    String? name,

  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,

      );

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) =>
      Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],

      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "name": name == null ? null : name,

      };
}
