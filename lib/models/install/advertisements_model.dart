import 'dart:convert';

class Advertisement {
  Advertisement({
    this.id,
    this.title,
    this.image,
    this.description,
  });

  int? id;
  String? title;
  String? image;
  String? description;

  Advertisement copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
  }) =>
      Advertisement(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        description: description ?? this.description,
      );

  factory Advertisement.fromJson(String str) => Advertisement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Advertisement.fromMap(Map<String, dynamic> json) => Advertisement(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "description": description == null ? null : description,
  };
}
