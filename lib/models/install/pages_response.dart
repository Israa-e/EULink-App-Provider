// To parse this JSON data, do
//
//     final pagesResponse = pagesResponseFromMap(jsonString);

import 'dart:convert';

class PagesResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  PagesResponse({
    this.success,
    this.message,
    this.data,
  });

  PagesResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      PagesResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PagesResponse.fromJson(String str) => PagesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PagesResponse.fromMap(Map<String, dynamic> json) => PagesResponse(
    success: json["success"],
    message: json["message"] == null ? [] : List<dynamic>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data?.toMap(),
  };
}

class Data {
  Page? page;

  Data({
    this.page,
  });

  Data copyWith({
    Page? page,
  }) =>
      Data(
        page: page ?? this.page,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    page: json["Page"] == null ? null : Page.fromMap(json["Page"]),
  );

  Map<String, dynamic> toMap() => {
    "Page": page?.toMap(),
  };
}

class Page {
  int? id;
  String? key;
  String? name;
  String? description;
  String? content;
  String? image;
  bool? isActive;

  Page({
    this.id,
    this.key,
    this.name,
    this.description,
    this.content,
    this.image,
    this.isActive,
  });

  Page copyWith({
    int? id,
    String? key,
    String? name,
    String? description,
    String? content,
    String? image,
    bool? isActive,
  }) =>
      Page(
        id: id ?? this.id,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        content: content ?? this.content,
        image: image ?? this.image,
        isActive: isActive ?? this.isActive,
      );

  factory Page.fromJson(String str) => Page.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Page.fromMap(Map<String, dynamic> json) => Page(
    id: json["id"],
    key: json["key"],
    name: json["name"],
    description: json["description"],
    content: json["summary"],
    image: json["image"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "key": key,
    "name": name,
    "description": description,
    "summary": content,
    "image": image,
    "is_active": isActive,
  };
}
