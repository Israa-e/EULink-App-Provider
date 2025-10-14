// To parse this JSON data, do
//
//     final mapStreetModel = mapStreetModelFromMap(jsonString);

import 'dart:convert';

class MapStreetModel {
  MapStreetModel({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.displayName,
    this.address,
    this.boundingbox,
  });

    int? placeId;
    String? licence;
    String? osmType;
    int? osmId;
    String? lat;
    String? lon;
    String? displayName;
    Address? address;
    List<String>? boundingbox;

  MapStreetModel copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    String? displayName,
    Address? address,
    List<String>? boundingbox,
  }) =>
      MapStreetModel(
        placeId: placeId ?? this.placeId,
        licence: licence ?? this.licence,
        osmType: osmType ?? this.osmType,
        osmId: osmId ?? this.osmId,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        displayName: displayName ?? this.displayName,
        address: address ?? this.address,
        boundingbox: boundingbox ?? this.boundingbox,
      );

  factory MapStreetModel.fromJson(String str) => MapStreetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MapStreetModel.fromMap(Map<String, dynamic> json) => MapStreetModel(
    placeId: json["place_id"] == null ? null : json["place_id"],
    licence: json["licence"] == null ? null : json["licence"],
    osmType: json["osm_type"] == null ? null : json["osm_type"],
    osmId: json["osm_id"] == null ? null : json["osm_id"],
    lat: json["lat"] == null ? null : json["lat"],
    lon: json["lon"] == null ? null : json["lon"],
    displayName: json["display_name"] == null ? null : json["display_name"],
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
    boundingbox: json["boundingbox"] == null ? null : List<String>.from(json["boundingbox"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "place_id": placeId == null ? null : placeId,
    "licence": licence == null ? null : licence,
    "osm_type": osmType == null ? null : osmType,
    "osm_id": osmId == null ? null : osmId,
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
    "display_name": displayName == null ? null : displayName,
    "address": address == null ? null : address!.toMap(),
    "boundingbox": boundingbox == null ? null : List<dynamic>.from(boundingbox!.map((x) => x)),
  };
}

class Address {
  Address({
    this.city,
    this.state,
    this.country,
    this.countryCode,
    this.iso31662Lvl4,
  });

    String? city;
    String? state;
    String? country;
    String? countryCode;
  String? iso31662Lvl4;

  Address copyWith({
    String? city,
    String? state,
    String? country,
    String? countryCode,
    String? iso31662Lvl4,
  }) =>
      Address(
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
        iso31662Lvl4: iso31662Lvl4 ?? this.iso31662Lvl4,
      );

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"] == null ? null : json["country"],
    countryCode: json["country_code"] == null ? null : json["country_code"],
    iso31662Lvl4: json["ISO3166-2-lvl4"] == null ? null :json["ISO3166-2-lvl4"],
  );

  Map<String, dynamic> toMap() => {
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "country": country == null ? null : country,
    "country_code": countryCode == null ? null : countryCode,
    "ISO3166-2-lvl4": iso31662Lvl4 == null ? null :iso31662Lvl4,
  };
}
