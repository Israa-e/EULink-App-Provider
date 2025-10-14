import 'dart:convert';

class Media {
  Media({
    this.id,
    this.file,
  });

  int? id;
  String? file;

  Media copyWith({
    int? id,
    String? file,
  }) =>
      Media(
        id: id ?? this.id,
        file: file ?? this.file,
      );

  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    id: json["id"] == null ? null : json["id"],
    file: json["file"] == null ? null : json["file"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "file": file == null ? null : file,
  };
}