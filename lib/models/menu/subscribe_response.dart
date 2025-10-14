// To parse this JSON data, do
//
//     final subscribeResponse = subscribeResponseFromJson(jsonString);

import 'dart:convert';

import 'get_subscription_response.dart';

SubscribeResponse subscribeResponseFromJson(String str) => SubscribeResponse.fromJson(json.decode(str));

String subscribeResponseToJson(SubscribeResponse data) => json.encode(data.toJson());

class SubscribeResponse {
  SubscribeResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool? success;
  List<dynamic> message;
  Data data;

  factory SubscribeResponse.fromJson(Map<String, dynamic> json) => SubscribeResponse(
    success: json["success"],
    message: List<dynamic>.from(json["message"].map((x) => x)),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": data.toJson(),
  };

  String getMessageList(){
    String msg = "";
    for(int i =0 ; i <message.length ;i++){
      msg += message[i].toString() +" ";
    }

    return msg ;
  }
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
/**
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
  });

  int id;
  String name;
  int billingDays;
  double price;
  int ordersCount;
  int balance;
  double orderPrice;
  DateTime startedAt;
  DateTime expireAt;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"],
    name: json["name"],
    billingDays: json["billing_days"],
    price: json["price"]?.toDouble(),
    ordersCount: json["orders_count"],
    balance: json["balance"],
    orderPrice: json["order_price"]?.toDouble(),
    startedAt: DateTime.parse(json["started_at"]),
    expireAt: DateTime.parse(json["expire_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "billing_days": billingDays,
    "price": price,
    "orders_count": ordersCount,
    "balance": balance,
    "order_price": orderPrice,
    "started_at": startedAt.toIso8601String(),
    "expire_at": expireAt.toIso8601String(),
  };
}
*/