// To parse this JSON data, do
//
//     final offersResponse = offersResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/base/links.dart';
import 'package:provider/models/base/meta.dart';

import 'offer_model.dart';

class OffersResponse {
  OffersResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<Offer>? data;
  Links? links;
  Meta? meta;
  OffersResponse copyWith({
    List<Offer>? data,
    Links? links,
    Meta? meta,
  }) =>
      OffersResponse(
        data: data ?? this.data,

        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory OffersResponse.fromJson(String str) => OffersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OffersResponse.fromMap(Map<String, dynamic> json) => OffersResponse(
    data: json["data"] == null ? null : List<Offer>.from(json["data"].map((x) => Offer.fromMap(x))),
    links: json["links"] == null ? null : Links.fromMap(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
    "links": links == null ? null : links!.toMap(),
    "meta": meta == null ? null : meta!.toMap(),
  };
}

