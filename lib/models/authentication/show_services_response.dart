// To parse this JSON data, do
//
//     final showServicesResponse = showServicesResponseFromMap(jsonString);

import 'dart:convert';

class ShowServicesResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  ShowServicesResponse({
    this.success,
    this.message,
    this.data,
  });

  ShowServicesResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      ShowServicesResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShowServicesResponse.fromJson(String str) => ShowServicesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShowServicesResponse.fromMap(Map<String, dynamic> json) => ShowServicesResponse(
    success: json["success"],
    message: json["message"] == null ? [] : List<dynamic>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data?.toMap(),
  };
}

class Data {
  List<Service>? services;

  Data({
    this.services,
  });

  Data copyWith({
    List<Service>? services,
  }) =>
      Data(
        services: services ?? this.services,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    services: json["Services"] == null ? [] : List<Service>.from(json["Services"]!.map((x) => Service.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toMap())),
  };
}

class Service {
  int? id;
  String? name;
  String? image;
  String? description;
  bool? isActive;
  int? orders;
  int? workers;

  Service({
    this.id,
    this.name,
    this.image,
    this.description,
    this.isActive,
    this.orders,
    this.workers,
  });

  Service copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    bool? isActive,
    int? orders,
    int? workers,
  }) =>
      Service(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        orders: orders ?? this.orders,
        workers: workers ?? this.workers,
      );

  factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Service.fromMap(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    isActive: json["is_active"],
    orders: json["orders"],
    workers: json["workers"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "is_active": isActive,
    "orders": orders,
    "workers": workers,
  };
}
