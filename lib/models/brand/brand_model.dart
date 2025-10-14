// To parse this JSON data, do
//
//     final brandsResponse = brandsResponseFromMap(jsonString);

import 'dart:convert';

import '../install/category_model.dart';


class Brand {
  Brand({
    this.id,
    this.name,
    this.image,
    this.extra_image ,
    this.category,
  });

  int? id;
  String? name;
  String? image;
  String? extra_image;
  Category? category;
  bool isSelect =false ;

  Brand copyWith({
    int? id,
    String? name,
    String? image,
    Category? category,
  }) =>
      Brand(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        extra_image: extra_image ?? this.extra_image,
        category: category ?? this.category,
      );

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    extra_image: json["extra_image"] == null ? null : json["extra_image"],
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "extra_image": extra_image == null ? null : extra_image,
    "category": category == null ? null : category!.toMap(),
  };
}



