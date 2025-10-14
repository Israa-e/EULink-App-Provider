
import 'dart:convert';

import '../splash/splash_response.dart';
import 'city_model.dart';

class Country {
  int? id;
  String? name;
  String? code;
  String? flag;
  int? currencyId;
  Currency? currency;
  int? localeId;
  Locales? locale;
  bool? isActive;

  Country({
    this.id,
    this.name,
    this.code,
    this.flag,
    this.currencyId,
    this.currency,
    this.localeId,
    this.locale,
    this.isActive,
  });

  Country copyWith({
    int? id,
    String? name,
    String? code,
    String? flag,
    int? currencyId,
    Currency? currency,
    int? localeId,
    Locales? locale,
    bool? isActive,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        flag: flag ?? this.flag,
        currencyId: currencyId ?? this.currencyId,
        currency: currency ?? this.currency,
        localeId: localeId ?? this.localeId,
        locale: locale ?? this.locale,
        isActive: isActive ?? this.isActive,
      );

  factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    flag: json["flag"],
    currencyId: json["currency_id"],
    currency: json["Currency"] == null ? null : Currency.fromMap(json["Currency"]),
    localeId: json["locale_id"],
    locale: json["Locale"] == null ? null : Locales.fromMap(json["Locale"]),
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "code": code,
    "flag": flag,
    "currency_id": currencyId,
    "Currency": currency?.toMap(),
    "locale_id": localeId,
    "Locale": locale?.toMap(),
    "is_active": isActive,
  };
}

