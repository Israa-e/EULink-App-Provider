import 'dart:convert';

class Settings {
  Settings({
    this.privacy,
    this.about,
    this.terms,
    this.facebook,
    this.instagram,
    this.email,
    this.mobile,
    this.maxOrderTime,
    this.splash1,
    this.splash2,
    this.splash3,
  });

  String? privacy;
  String? about;
  String? terms;
  String? facebook;
  String? instagram;
  String? email;
  String? mobile;
  String? maxOrderTime;
  String? splash1;
  String? splash2;
  String? splash3;

  Settings copyWith({
    String? privacy,
    String? about,
    String? terms,
    String? facebook,
    String? instagram,
    String? email,
    String? mobile,
    String? maxOrderTime,
    String? splash1,
    String? splash2,
    String? splash3,
  }) =>
      Settings(
        privacy: privacy ?? this.privacy,
        about: about ?? this.about,
        terms: terms ?? this.terms,
        facebook: facebook ?? this.facebook,
        instagram: instagram ?? this.instagram,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        maxOrderTime: maxOrderTime ?? this.maxOrderTime,
        splash1: splash1 ?? this.splash1,
        splash2: splash2 ?? this.splash2,
        splash3: splash3 ?? this.splash3,
      );

  factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
    privacy: json["privacy"],
    about: json["about"],
    terms: json["terms"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    email: json["email"],
    mobile: json["mobile"],
    maxOrderTime: json["max_order_time"],
    splash1: json["splash_1"],
    splash2: json["splash_2"],
    splash3: json["splash_3"],
  );

  Map<String, dynamic> toMap() => {
    "privacy": privacy,
    "about": about,
    "terms": terms,
    "facebook": facebook,
    "instagram": instagram,
    "email": email,
    "mobile": mobile,
    "max_order_time": maxOrderTime,
    "splash_1": splash1,
    "splash_2": splash2,
    "splash_3": splash3,
  };
}
