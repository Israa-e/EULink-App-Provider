import 'dart:convert';

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic? prev;
  dynamic? next;

  Links copyWith({
    String? first,
    String? last,
    dynamic? prev,
    dynamic? next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
    first: json["first"] == null ? null : json["first"],
    last: json["last"] == null ? null : json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toMap() => {
    "first": first == null ? null : first,
    "last": last == null ? null : last,
    "prev": prev,
    "next": next,
  };
}
