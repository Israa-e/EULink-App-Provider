// To parse this JSON data, do
//
//     final getSubscriptionResponse = getSubscriptionResponseFromJson(jsonString);

import 'dart:convert';

GetSubscriptionResponse getSubscriptionResponseFromJson(String str) => GetSubscriptionResponse.fromJson(json.decode(str));

String getSubscriptionResponseToJson(GetSubscriptionResponse data) => json.encode(data.toJson());

class GetSubscriptionResponse {
  GetSubscriptionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory GetSubscriptionResponse.fromJson(Map<String, dynamic> json) => GetSubscriptionResponse(
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
    required this.subscription,
  });

  Subscription subscription;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    subscription: Subscription.fromJson(json["Subscription"]),
  );

  Map<String, dynamic> toJson() => {
    "Subscription": subscription.toJson(),
  };
}

class Subscription {
  Subscription({
    required this.id,
    required this.name,
    required this.billingDays,
    required this.price,
    required this.ordersCount,
    required this.balance,
    required this.orderPrice,
    required this.startedAt,
    required this.expireAt,
    required this.features,
    this.plan,
    this.status,

  });

  int id;
  String name;
  int billingDays;
  double price;
  int ordersCount;
  String? balance;
  double orderPrice;
  DateTime? startedAt;
  DateTime? expireAt;
  List<String>? features = [];
  Subscription? plan ;
  int?status ;
      factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"],
    name: json["name"],
    billingDays: json["billing_days"],
    price: json["price"]?.toDouble(),
    ordersCount: json["orders_count"],
    balance: json["balance"] !=null  ?json["balance"] .toString() :"",
    orderPrice: json["order_price"]?.toDouble(),
    startedAt: json["started_at"] != null ? DateTime.parse(json["started_at"]):null,
    expireAt: json["expire_at"] != null ?  DateTime.parse(json["expire_at"]):null,
    features:json["features"] == null ? [] :List<String>.from(json["features"].map((x) => x)),
     plan: json["Plan"] == null ? null : Subscription.fromJson(json["Plan"]),

          status: json["status"] !=null  ?json["status"]  :0,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "billing_days": billingDays,
    "price": price,
    "orders_count": ordersCount,
    "balance": balance != null ? balance.toString() :null,
    "order_price": orderPrice,
    "started_at":startedAt != null ? startedAt!.toIso8601String() : null,
    "expire_at":expireAt != null ? expireAt!.toIso8601String(): null,
    "features": features == null ? []:  List<String>.from(features!.map((x) => x)),
    "Plan": plan?.toJson(),
    "status": status != null ? status   :0 ,
  };
}
