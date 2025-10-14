// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromMap(jsonString);

import 'dart:convert';

import 'category_model.dart';

class CategoriesResponse {
  CategoriesResponse({
    this.data,
  });

  List<Category>? data;

  CategoriesResponse copyWith({
    List<Category>? data,
  }) =>
      CategoriesResponse(
        data: data ?? this.data,
      );

  factory CategoriesResponse.fromJson(String str) => CategoriesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesResponse.fromMap(Map<String, dynamic> json) => CategoriesResponse(
    data: json["data"] == null ? null : List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

