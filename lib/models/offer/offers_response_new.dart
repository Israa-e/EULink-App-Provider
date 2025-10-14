// To parse this JSON data, do
//
//     final offersResponseNew = offersResponseNewFromMap(jsonString);

import 'dart:convert';

class OffersResponseNew {
  OffersResponseNew({
    this.data,
  });

  Data? data;

  OffersResponseNew copyWith({
    Data? data,
  }) =>
      OffersResponseNew(
        data: data ?? this.data,
      );

  factory OffersResponseNew.fromJson(String str) => OffersResponseNew.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OffersResponseNew.fromMap(Map<String, dynamic> json) => OffersResponseNew(
    data: json["data"]== null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.image,
    this.category,
    this.offers,
  });

  int? id;
  String? name;
  String? image;
  Category? category;
  List<OfferNew?>? offers;

  Data copyWith({
    int? id,
    String? name,
    String? image,
    Category? category,
    List<OfferNew?>? offers,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        category: category ?? this.category,
        offers: offers ?? this.offers,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    category:  json["category"]== null ? null : Category.fromMap(json["category"]),
    offers: json["offers"] == null ? [] : json["offers"] == null ? [] : List<OfferNew?>.from(json["offers"]!.map((x) => OfferNew.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image": image,
    "category": category == null ? null : category!.toMap() ,
    "offers": offers == null ? [] : offers == null ? [] : List<dynamic>.from(offers!.map((x) => x!.toMap())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int? id;
  String? name;

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

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}

class OfferNew {
  OfferNew({
    this.id,
    this.name,
    this.description,
    this.image,
    this.startAt,
    this.expireAt,
    this.website,
    this.type,
    this.reuseHour,
    this.reuseDay,
  });

  int? id;
  String? name;
  String? description;
  String? image;
  DateTime? startAt;
  DateTime? expireAt;
  String? website;
  String? type;
  int? reuseHour;
  int? reuseDay;
  OfferNew copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    DateTime? startAt,
    DateTime? expireAt,
    String? website,
    String? type,
    int? reuseHour,
    int? reuseDay,
  }) =>
      OfferNew(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        startAt: startAt ?? this.startAt,
        expireAt: expireAt ?? this.expireAt,
        website: website ?? this.website,
        type: type ?? this.type,
        reuseHour: reuseHour ?? this.reuseHour,
        reuseDay: reuseDay ?? this.reuseDay,
      );

  factory OfferNew.fromJson(String str) => OfferNew.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfferNew.fromMap(Map<String, dynamic> json) => OfferNew(
    id: json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    startAt: json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
    expireAt: json["expire_at"] == null ? null : DateTime.parse(json["expire_at"]),
    website: json["website"] == null ? null : json["website"],
    type: json["type"] == null ? null : json["type"],
    reuseHour: json["reuse_hour"] == null ? null : json["reuse_hour"],
    reuseDay: json["reuse_day"] == null ? null : json["reuse_day"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
    "start_at": startAt == null ? null : "${startAt!.year.toString().padLeft(4, '0')}-${startAt!.month.toString().padLeft(2, '0')}-${startAt!.day.toString().padLeft(2, '0')}",
    "expire_at": expireAt == null ? null : "${expireAt!.year.toString().padLeft(4, '0')}-${expireAt!.month.toString().padLeft(2, '0')}-${expireAt!.day.toString().padLeft(2, '0')}",
    "website": website == null ? null : website,
    "type": type == null ? null : type,
    "reuse_hour": reuseHour == null ? null : reuseHour,
    "reuse_day": reuseDay == null ? null : reuseDay,
  };
}
