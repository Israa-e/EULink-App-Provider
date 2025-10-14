// To parse this JSON data, do
//
//     final socialResponse = socialResponseFromMap(jsonString);

import 'dart:convert';

class SocialResponse {
  SocialResponse({
    this.data,
  });

  List<Social>? data;

  SocialResponse copyWith({
    List<Social>? data,
  }) =>
      SocialResponse(
        data: data ?? this.data,
      );

  factory SocialResponse.fromJson(String str) => SocialResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialResponse.fromMap(Map<String, dynamic> json) => SocialResponse(
    data: json["data"] == null ? null : List<Social>.from(json["data"].map((x) => Social.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Social {
  Social({
    this.title,
    this.url,
    this.icon,
  });

  String? title;
  String? url;
  String? icon;

  Social copyWith({
    String? title,
    String? url,
    String? icon,
  }) =>
      Social(
        title: title ?? this.title,
        url: url ?? this.url,
        icon: icon ?? this.icon,
      );

  factory Social.fromJson(String str) => Social.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Social.fromMap(Map<String, dynamic> json) => Social(
    title: json["title"] == null ? null : json["title"],
    url: json["url"] == null ? null : json["url"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "title": title == null ? null : title,
    "url": url == null ? null : url,
    "icon": icon == null ? null : icon,
  };
}
