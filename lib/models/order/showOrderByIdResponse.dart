// To parse this JSON data, do
//
//     final showOrderByIdResponse = showOrderByIdResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/auth/user.dart';
import 'package:provider/models/authentication/show_services_response.dart';
import 'package:provider/models/order/order_response.dart';

import '../authentication/provider.dart';

// To parse this JSON data, do
//
//     final showOrderByIdResponse = showOrderByIdResponseFromMap(jsonString);

import 'dart:convert';

class ShowOrderByIdResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  ShowOrderByIdResponse({
    this.success,
    this.message,
    this.data,
  });

  ShowOrderByIdResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      ShowOrderByIdResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShowOrderByIdResponse.fromJson(String str) => ShowOrderByIdResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShowOrderByIdResponse.fromMap(Map<String, dynamic> json) => ShowOrderByIdResponse(
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
  Order? order;

  Data({
    this.order,
  });

  Data copyWith({
    Order? order,
  }) =>
      Data(
        order: order ?? this.order,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    order: json["Order"] == null ? null : Order.fromMap(json["Order"]),
  );

  Map<String, dynamic> toMap() => {
    "Order": order?.toMap(),
  };
}

class Order {
  int? id;
  int? userId;
  User? user;
  int? providerId;
  Provider? provider;
  int? serviceId;
  Service? service;
  DateTime? date;
  String? time;
  String? address;
  String? latitude;
  String? longitude;
  String? name;
  String? mobile;
  int? status;
  dynamic rate;
  dynamic review;

  Order({
    this.id,
    this.userId,
    this.user,
    this.providerId,
    this.provider,
    this.serviceId,
    this.service,
    this.date,
    this.time,
    this.address,
    this.latitude,
    this.longitude,
    this.name,
    this.mobile,
    this.status,
    this.rate,
    this.review,
  });

  Order copyWith({
    int? id,
    int? userId,
    User? user,
    int? providerId,
    Provider? provider,
    int? serviceId,
    Service? service,
    DateTime? date,
    String? time,
    String? address,
    String? latitude,
    String? longitude,
    String? name,
    String? mobile,
    int? status,
    dynamic rate,
    dynamic review,
  }) =>
      Order(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        user: user ?? this.user,
        providerId: providerId ?? this.providerId,
        provider: provider ?? this.provider,
        serviceId: serviceId ?? this.serviceId,
        service: service ?? this.service,
        date: date ?? this.date,
        time: time ?? this.time,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
        rate: rate ?? this.rate,
        review: review ?? this.review,
      );

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    user: json["User"] == null ? null : User.fromMap(json["User"]),
    providerId: json["provider_id"],
    provider: json["Provider"] == null ? null : Provider.fromMap(json["Provider"]),
    serviceId: json["service_id"],
    service: json["Service"] == null ? null : Service.fromMap(json["Service"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    name: json["name"],
    mobile: json["mobile"],
    status: json["status"],
    rate: json["rate"],
    review: json["review"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "User": user?.toMap(),
    "provider_id": providerId,
    "Provider": provider?.toMap(),
    "service_id": serviceId,
    "Service": service?.toMap(),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "mobile": mobile,
    "status": status,
    "rate": rate,
    "review": review,
  };
}

class Provider {
  int? id;
  String? name;
  String? mobile;
  int? countryId;
  Country? country;
  int? cityId;
  City? city;
  int? localeId;
  City? locale;
  int? appMode;
  String? hourlyRate;
  String? avatar;
  String? taxId;
  String? latitude;
  String? longitude;
  dynamic address;
  dynamic rate;
  int? type;

  Provider({
    this.id,
    this.name,
    this.mobile,
    this.countryId,
    this.country,
    this.cityId,
    this.city,
    this.localeId,
    this.locale,
    this.appMode,
    this.hourlyRate,
    this.avatar,
    this.taxId,
    this.latitude,
    this.longitude,
    this.address,
    this.rate,
    this.type,
  });

  Provider copyWith({
    int? id,
    String? name,
    String? mobile,
    int? countryId,
    Country? country,
    int? cityId,
    City? city,
    int? localeId,
    City? locale,
    int? appMode,
    String? hourlyRate,
    String? avatar,
    String? taxId,
    String? latitude,
    String? longitude,
    dynamic address,
    dynamic rate,
    int? type,
  }) =>
      Provider(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        countryId: countryId ?? this.countryId,
        country: country ?? this.country,
        cityId: cityId ?? this.cityId,
        city: city ?? this.city,
        localeId: localeId ?? this.localeId,
        locale: locale ?? this.locale,
        appMode: appMode ?? this.appMode,
        hourlyRate: hourlyRate ?? this.hourlyRate.toString(),
        avatar: avatar ?? this.avatar,
        taxId: taxId ?? this.taxId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
        rate: rate ?? this.rate,
        type: type ?? this.type,
      );

  factory Provider.fromJson(String str) => Provider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<String, dynamic> json) => Provider(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    countryId: json["country_id"],
    country: json["Country"] == null ? null : Country.fromMap(json["Country"]),
    cityId: json["city_id"],
    city: json["City"] == null ? null : City.fromMap(json["City"]),
    localeId: json["locale_id"],
    locale: json["Locale"] == null ? null : City.fromMap(json["Locale"]),
    appMode: json["app_mode"],
    hourlyRate: json["hourly_rate"] !=null ? json["hourly_rate"] .toString() : null,
    avatar: json["avatar"],
    taxId: json["tax_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    rate: json["rate"],
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "country_id": countryId,
    "Country": country?.toMap(),
    "city_id": cityId,
    "City": city?.toMap(),
    "locale_id": localeId,
    "Locale": locale?.toMap(),
    "app_mode": appMode,
    "hourly_rate": hourlyRate,
    "avatar": avatar,
    "tax_id": taxId,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "rate": rate,
    "type": type,
  };
}

class City {
  int? id;
  String? name;
  int? countryId;
  bool? isActive;
  String? locale;

  City({
    this.id,
    this.name,
    this.countryId,
    this.isActive,
    this.locale,
  });

  City copyWith({
    int? id,
    String? name,
    int? countryId,
    bool? isActive,
    String? locale,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        countryId: countryId ?? this.countryId,
        isActive: isActive ?? this.isActive,
        locale: locale ?? this.locale,
      );

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    isActive: json["is_active"],
    locale: json["locale"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "is_active": isActive,
    "locale": locale,
  };
}

class Country {
  int? id;
  String? name;
  String? code;
  String? flag;
  int? currencyId;
  Currency? currency;
  int? localeId;
  City? locale;
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
    City? locale,
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
    locale: json["Locale"] == null ? null : City.fromMap(json["Locale"]),
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

class Currency {
  int? id;
  String? name;
  String? code;
  String? symbol;
  bool? isActive;

  Currency({
    this.id,
    this.name,
    this.code,
    this.symbol,
    this.isActive,
  });

  Currency copyWith({
    int? id,
    String? name,
    String? code,
    String? symbol,
    bool? isActive,
  }) =>
      Currency(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
        isActive: isActive ?? this.isActive,
      );

  factory Currency.fromJson(String str) => Currency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Currency.fromMap(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "code": code,
    "symbol": symbol,
    "is_active": isActive,
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

class User {
  int? id;
  String? name;
  dynamic email;
  String? mobile;
  int? countryId;
  dynamic cityId;
  dynamic localeId;
  int? appMode;
  String? avatar;
  bool? subscriptionStatus;
  Country? country;
  dynamic city;
  dynamic locale;

  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.countryId,
    this.cityId,
    this.localeId,
    this.appMode,
    this.avatar,
    this.subscriptionStatus,
    this.country,
    this.city,
    this.locale,
  });

  User copyWith({
    int? id,
    String? name,
    dynamic email,
    String? mobile,
    int? countryId,
    dynamic cityId,
    dynamic localeId,
    int? appMode,
    String? avatar,
    bool? subscriptionStatus,
    Country? country,
    dynamic city,
    dynamic locale,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        countryId: countryId ?? this.countryId,
        cityId: cityId ?? this.cityId,
        localeId: localeId ?? this.localeId,
        appMode: appMode ?? this.appMode,
        avatar: avatar ?? this.avatar,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        country: country ?? this.country,
        city: city ?? this.city,
        locale: locale ?? this.locale,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    localeId: json["locale_id"],
    appMode: json["app_mode"],
    avatar: json["avatar"],
    subscriptionStatus: json["subscription_status"],
    country: json["Country"] == null ? null : Country.fromMap(json["Country"]),
    city: json["City"],
    locale: json["Locale"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "country_id": countryId,
    "city_id": cityId,
    "locale_id": localeId,
    "app_mode": appMode,
    "avatar": avatar,
    "subscription_status": subscriptionStatus,
    "Country": country?.toMap(),
    "City": city,
    "Locale": locale,
  };
}







