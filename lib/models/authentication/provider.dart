// To parse this JSON data, do
//
//     final providerResponse = providerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/authentication/show_services_response.dart';
import 'package:provider/models/menu/get_subscription_response.dart';

import '../install/city_model.dart';
import '../install/country_model.dart';

ProviderResponse providerResponseFromJson(String str) => ProviderResponse.fromJson(json.decode(str));

String providerResponseToJson(ProviderResponse data) => json.encode(data.toJson());

class ProviderResponse {

  bool? success;
  List<dynamic>? message;
  Data? data;

  ProviderResponse({
    this.success,
    this.message,
    this.data,
  });

  ProviderResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      ProviderResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProviderResponse.fromJson(String str) => ProviderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProviderResponse.fromMap(Map<String, dynamic> json) => ProviderResponse(
    success: json["success"],
    message: json["message"] == null ? [] : List<dynamic>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data?.toMap(),
  };

  String getMessageList(){
    String msg = "";
    for(int i =0 ; i <message!.length ;i++){
      msg += message![i].toString() +" ";
    }

    return msg ;
  }
}
class Data {
  Provider? provider;
  Login? login;

  Data({
    this.provider,
    this.login,
  });

  Data copyWith({
    Provider? provider,
    Login? login,
  }) =>
      Data(
        provider: provider ?? this.provider,
        login: login ?? this.login,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    provider: json["Provider"] == null ? null : Provider.fromMap(json["Provider"]),
    login: json["Login"] == null ? null : Login.fromMap(json["Login"]),
  );

  Map<String, dynamic> toMap() => {
    "Provider": provider!.toMap(),
    "Login": login != null ?  login!.toMap() : null,
  };
}

class Login {
  String? tokenType;
  String? accessToken;

  Login({
    this.tokenType,
    this.accessToken,
  });

  Login copyWith({
    String? tokenType,
    String? accessToken,
  }) =>
      Login(
        tokenType: tokenType ?? this.tokenType,
        accessToken: accessToken ?? this.accessToken,
      );

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Login.fromMap(Map<String, dynamic> json) => Login(
    tokenType: json["token_type"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toMap() => {
    "token_type": tokenType,
    "access_token": accessToken,
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
  dynamic taxId;
  String? latitude;
  String? longitude;
  dynamic address;
  dynamic rate;
  List<Service>? services;
  int? type;
  bool? subscriptionStatus;
  Subscription?  subscription ;
  String? identity ;

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
    this.services,
    this.type,
    this.subscriptionStatus ,
    this.subscription ,
    this.identity ,
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
    dynamic taxId,
    String? latitude,
    String? longitude,
    dynamic address,
    dynamic rate,
    List<Service>? services,
    int? type,
    bool? subscriptionStatus ,
    Subscription? subscription ,
    String?identity ,
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
        hourlyRate: hourlyRate ?? this.hourlyRate,
        avatar: avatar ?? this.avatar,
        taxId: taxId ?? this.taxId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
        rate: rate ?? this.rate,
        services: services ?? this.services,
        type: type ?? this.type,
          subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
          subscription :subscription  ?? this.subscription ,
          identity: identity?? this.identity ,
      );

  factory Provider.fromJson(String str) => Provider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<String, dynamic> json) => Provider(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    countryId: json["country_id"],
    country: json["Country"] == null ? null : Country.fromMap(json["Country"]),
    cityId: json["city_id"] != null ? int.tryParse(json["city_id"].toString() )??0: null,
    city: json["City"] == null ? null : City.fromMap(json["City"]),
    localeId: json["locale_id"] != null ? int.tryParse(json["locale_id"].toString())??0 : null,
    locale: json["Locale"] == null ? null : City.fromMap(json["Locale"]),
    appMode: json["app_mode"],
    hourlyRate: json["hourly_rate"] !=null ? json["hourly_rate"] .toString() : null,
    avatar: json["avatar"],
    taxId: json["tax_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    rate: json["rate"],
    services: json["Services"] == null ? [] : List<Service>.from(json["Services"]!.map((x) => Service.fromMap(x))),
    type: json["type"],
    subscriptionStatus: json["subscription_status"] == null ? false : json["subscription_status"] ,
    subscription: json["Subscription"] == null ? null : Subscription.fromJson(json["Subscription"]),
      identity : json["identity"]== null ? null : json["identity"],
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
    "hourly_rate": hourlyRate != null ? hourlyRate.toString() : null,
    "avatar": avatar,
    "tax_id": taxId,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "rate": rate,
    "Services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toMap())),
    "type": type,
    "subscription_status": subscriptionStatus == null ? false :subscriptionStatus ,
    "Subscription":subscription == null ? null: subscription!.toJson(),
    "identity":identity ==null  ? null : identity ,
   };
}


class Currency {
  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.isActive,
  });

  int id;
  String name;
  String code;
  String symbol;
  bool isActive;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "symbol": symbol,
    "is_active": isActive,
  };
}

