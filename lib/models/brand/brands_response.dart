// To parse this JSON data, do
//
//     final brandsResponse = brandsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/base/links.dart';
import 'package:provider/models/base/meta.dart';

import 'brand_model.dart';

class BrandsResponse {
  BrandsResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<Brand>? data;
  Links? links;
  Meta? meta;
  BrandsResponse copyWith({
    List<Brand>? data,
    Links? links,
    Meta? meta,
  }) =>
      BrandsResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory BrandsResponse.fromJson(String str) => BrandsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandsResponse.fromMap(Map<String, dynamic> json) => BrandsResponse(
    data: json["data"] == null ? null : List<Brand>.from(json["data"].map((x) => Brand.fromMap(x))),
    links: json["links"] == null ? null : Links.fromMap(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
    "links": links == null ? null : links!.toMap(),
    "meta": meta == null ? null : meta!.toMap(),
  };
}


