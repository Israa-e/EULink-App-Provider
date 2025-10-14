// To parse this JSON data, do
//
//     final offersResponse = offersResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/brand/brand_model.dart';


class Offer {
  Offer({
    this.id,
    this.brand,
    this.name,
    this.description,
    this.image,
    this.startAt,
    this.expireAt,
    this.website,
    this.isFavourite,
    this.reuseHour,
    this.reuseDay,
    this.favoritesCount,
    this.type ,
  });

  int? id;
  Brand? brand;
  String? name;
  String? description;
  String? image;
  DateTime? startAt;
  DateTime? expireAt;
  String? website;
  bool? isFavourite;
  int? reuseHour;
  int? reuseDay;
  int? favoritesCount;
  String? type;

  Offer copyWith({
    int? id,
    Brand? brand,
    String? name,
    String? description,
    String? image,
    DateTime? startAt,
    DateTime? expireAt,
    String? website,
    bool? isFavourite,
    int? reuseHour,
    int? reuseDay,
    int? favoritesCount,
    String? type,
  }) =>
      Offer(
        id: id ?? this.id,
        brand: brand ?? this.brand,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        startAt: startAt ?? this.startAt,
        expireAt: expireAt ?? this.expireAt,
        website: website ?? this.website,
        isFavourite: isFavourite ?? this.isFavourite,
        reuseHour: reuseHour ?? this.reuseHour,
        reuseDay: reuseDay ?? this.reuseDay,
        favoritesCount: favoritesCount ?? this.favoritesCount,
        type: type ?? this.type,
      );

  factory Offer.fromJson(String str) => Offer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Offer.fromMap(Map<String, dynamic> json) => Offer(
    id: json["id"] == null ? null : json["id"],
    brand: json["brand"] == null ? null : Brand.fromMap(json["brand"]),
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    startAt: json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
    expireAt: json["expire_at"] == null ? null : DateTime.parse(json["expire_at"]),
    website: json["website"] == null ? null : json["website"],
    isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
    reuseHour: json["reuse_hour"] == null ? null : json["reuse_hour"],
    reuseDay: json["reuse_day"] == null ? null : json["reuse_day"],
    favoritesCount: json["favorites_count"] == null ? null : json["favorites_count"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "brand": brand == null ? null : brand!.toMap(),
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
    "start_at": startAt == null ? null : "${startAt!.year.toString().padLeft(4, '0')}-${startAt!.month.toString().padLeft(2, '0')}-${startAt!.day.toString().padLeft(2, '0')}",
    "expire_at": expireAt == null ? null : "${expireAt!.year.toString().padLeft(4, '0')}-${expireAt!.month.toString().padLeft(2, '0')}-${expireAt!.day.toString().padLeft(2, '0')}",
    "website": website == null ? null : website,
    "is_favourite": isFavourite == null ? null : isFavourite,
    "reuse_hour": reuseHour == null ? null : reuseHour,
    "reuse_day": reuseDay == null ? null : reuseDay,
    "favorites_count": favoritesCount == null ? null : favoritesCount,
    "type": type == null ? null : type,
  };
}

