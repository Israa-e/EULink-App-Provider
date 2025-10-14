// To parse this JSON data, do
//
//     final plansResponse = plansResponseFromJson(jsonString);

import 'dart:convert';

PlansResponse plansResponseFromJson(String str) => PlansResponse.fromJson(json.decode(str));

String plansResponseToJson(PlansResponse data) => json.encode(data.toJson());

class PlansResponse {
  PlansResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory PlansResponse.fromJson(Map<String, dynamic> json) => PlansResponse(
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
    required this.plans,
  });

  List<Plan> plans;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    plans: List<Plan>.from(json["Plans"].map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Plans": List<dynamic>.from(plans.map((x) => x.toJson())),
  };
}

class Plan {
  Plan({
    required this.id,
    required this.type,
    required this.name,
    required this.billingDays,
    required this.price,
    required this.features,
    required this.orderPrice,
    required this.ordersCount,
    required this.isActive,
  });

  int id;
  int type;
  String name;
  int billingDays;
  double price;
  List<String> features;
  double orderPrice;
  int ordersCount;
  bool isActive;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    billingDays: json["billing_days"],
    price: json["price"]?.toDouble(),
    features: List<String>.from(json["features"].map((x) => x)),
    orderPrice: json["order_price"]?.toDouble(),
    ordersCount: json["orders_count"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "billing_days": billingDays,
    "price": price,
    "features": List<dynamic>.from(features.map((x) => x)),
    "order_price": orderPrice,
    "orders_count": ordersCount,
    "is_active": isActive,
  };
}
