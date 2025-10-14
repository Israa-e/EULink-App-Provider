// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromJson(jsonString);

import 'dart:convert';

CitiesResponse citiesResponseFromJson(String str) => CitiesResponse.fromJson(json.decode(str));

String citiesResponseToJson(CitiesResponse data) => json.encode(data.toJson());

class CitiesResponse {
  CitiesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory CitiesResponse.fromJson(Map<String, dynamic> json) => CitiesResponse(
    success: json["success"],
    message: List<dynamic>.from(json["message"].map((x) => x)),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.cities,
  });

  List<City> cities;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cities: List<City>.from(json["Cities"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Cities": List<dynamic>.from(cities.map((x) => x.toJson())),
  };
}

class City {
  City({
    required this.id,
    required this.name,
    this.countryId,
    required this.isActive,
  });

  int id;
  String name;
  int? countryId;
  bool isActive;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "is_active": isActive,
  };
}
