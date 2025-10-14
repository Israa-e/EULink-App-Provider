import 'dart:convert';

class Slider {
  Slider({
    this.id,
    this.title,
    this.image,
    this.link,
    this.button_text ,
  });

  int? id;
  String? title;
  String? image;
  String? link;
  String? type ;
  String? button_text ;

  Slider copyWith({
    int? id,
    String? title,
    String? image,
    String? link,
    String? button_text,
  }) =>
      Slider(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        link: link ?? this.link,
        button_text: button_text ?? this.button_text,
      );

  factory Slider.fromJson(String str) => Slider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Slider.fromMap(Map<String, dynamic> json) => Slider(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
    link: json["link"] == null ? null : json["link"],
    button_text: json["button_text"] == null ? null : json["button_text"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "link": link == null ? null : link,
    "button_text": button_text == null ? null : button_text,
  };
}
