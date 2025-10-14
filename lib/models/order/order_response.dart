// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/auth/user.dart';
import 'package:provider/models/authentication/show_services_response.dart';

import '../authentication/provider.dart';
import '../splash/splash_response.dart';
import 'show_messages_response.dart';

class   OrderResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  OrderResponse({
    this.success,
    this.message,
    this.data,
  });

  OrderResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      OrderResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OrderResponse.fromJson(String str) => OrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromMap(Map<String, dynamic> json) => OrderResponse(
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
  OrdersCollection? ordersCollection;

  Data({
    this.ordersCollection,
  });

  Data copyWith({
    OrdersCollection? ordersCollection,
  }) =>
      Data(
        ordersCollection: ordersCollection ?? this.ordersCollection,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    ordersCollection: json["Order"] == null ? null : OrdersCollection.fromMap(json["Order"]),
  );

  Map<String, dynamic> toMap() => {
    "Order": ordersCollection?.toMap(),
  };
}

class OrdersCollection {
  List<Orders>? orders;
  Pagination? pagination;

  OrdersCollection({
    this.orders,
    this.pagination,
  });

  OrdersCollection copyWith({
    List<Orders>? orders,
    Pagination? pagination,
  }) =>
      OrdersCollection(
        orders: orders ?? this.orders,
        pagination: pagination ?? this.pagination,
      );

  factory OrdersCollection.fromJson(String str) => OrdersCollection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrdersCollection.fromMap(Map<String, dynamic> json) => OrdersCollection(
    orders: json["Orders"] == null ? [] : List<Orders>.from(json["Orders"]!.map((x) => Orders.fromMap(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "Orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toMap())),
    "pagination": pagination?.toMap(),
  };
}

class Orders {
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

  Orders({
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

  Orders copyWith({
    int? id,
    int? userId,
    User? user,
    int? providerId,
    Provider ? provider,
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
      Orders(
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

  factory Orders.fromJson(String str) => Orders.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Orders.fromMap(Map<String, dynamic> json) => Orders(
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
    latitude:json["latitude"],
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

