// To parse this JSON data, do
//
//     final avatarsResponse = avatarsResponseFromMap(jsonString);

import 'dart:convert';

class AvatarsResponse {
  AvatarsResponse({
    this.data,
  });

  List<Avatar>? data;

  AvatarsResponse copyWith({
    List<Avatar>? data,
  }) =>
      AvatarsResponse(
        data: data ?? this.data,
      );

  factory AvatarsResponse.fromJson(String str) => AvatarsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AvatarsResponse.fromMap(Map<String, dynamic> json) => AvatarsResponse(
    data: json["data"] == null ? null : List<Avatar>.from(json["data"].map((x) => Avatar.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Avatar {
  Avatar({
    this.id,
    this.image,
  });

  int? id;
  String? image;
  bool isSelect =false ;

  Avatar copyWith({
    int? id,
    String? image,
  }) =>
      Avatar(
        id: id ?? this.id,
        image: image ?? this.image,
      );

  factory Avatar.fromJson(String str) => Avatar.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Avatar.fromMap(Map<String, dynamic> json) => Avatar(
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "image": image == null ? null : image,
  };
}
