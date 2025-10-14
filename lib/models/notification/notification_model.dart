
import 'dart:convert';

import 'package:provider/utils/config.dart';

class Notification {
  int? id;
  int? refType;
  int? refId;
  dynamic chat;
  dynamic order;
  String? title;
  String? message;
  bool? isRead;
  DateTime? createdAt;
  String? avatar ;

  Notification({
    this.id,
    this.refType,
    this.refId,
    this.chat,
    this.order,
    this.title,
    this.message,
    this.isRead,
    this.createdAt,
    this.avatar,
  });

  Notification copyWith({
    int? id,
    int? refType,
    int? refId,
    dynamic chat,
    dynamic order,
    String? title,
    String? message,
    bool? isRead,
    DateTime? createdAt,
    String? avatar,
  }) =>
      Notification(
        id: id ?? this.id,
        refType: refType ?? this.refType,
        refId: refId ?? this.refId,
        chat: chat ?? this.chat,
        order: order ?? this.order,
        title: title ?? this.title,
        message: message ?? this.message,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
        avatar: avatar ?? this.avatar,
      );

  factory Notification.fromJson(String str) => Notification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
    id: json["id"],
    refType: json["ref_type"],
    refId: json["ref_id"],
    chat: json["Chat"],
    order: json["Order"],
    title: json["title"],
    message: json["message"],
    isRead: json["is_read"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    avatar: json["avatar"] == null ? null : json["avatar"].toString().contains(confing.baseUrl ) ?json["avatar"].toString() :
    confing.baseUrl +  json["avatar"].toString(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "ref_type": refType,
    "ref_id": refId,
    "Chat": chat,
    "Order": order,
    "title": title,
    "message": message,
    "is_read": isRead,
    "created_at": createdAt?.toIso8601String(),
    "avatar": avatar ==null ? null : avatar.toString().contains(confing.baseUrl ) ?avatar.toString() :
    confing.baseUrl +  avatar.toString(),
  };
}