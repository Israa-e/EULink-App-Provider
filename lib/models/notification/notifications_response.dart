// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/order/show_messages_response.dart';

import '../order/order_response.dart';
import 'notification_model.dart';


class NotificationResponse {
    bool? success;
    List<dynamic>? message;
    Data? data;

    NotificationResponse({
        this.success,
        this.message,
        this.data,
    });

    NotificationResponse copyWith({
        bool? success,
        List<dynamic>? message,
        Data? data,
    }) =>
        NotificationResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory NotificationResponse.fromJson(String str) => NotificationResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NotificationResponse.fromMap(Map<String, dynamic> json) => NotificationResponse(
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
    NotificationCollection? notificationCollection;

    Data({
        this.notificationCollection,
    });

    Data copyWith({
        NotificationCollection? notificationCollection,
    }) =>
        Data(
            notificationCollection: notificationCollection ?? this.notificationCollection,
        );

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        notificationCollection: json["NotificationCollection"] == null ? null : NotificationCollection.fromMap(json["NotificationCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "NotificationCollection": notificationCollection?.toMap(),
    };
}


class NotificationCollection {
    List<Notification>? notifications;
    Pagination? pagination;

    NotificationCollection({
        this.notifications,
        this.pagination,
    });

    NotificationCollection copyWith({
        List<Notification>? notifications,
        Pagination? pagination,
    }) =>
        NotificationCollection(
            notifications: notifications ?? this.notifications,
            pagination: pagination ?? this.pagination,
        );

    factory NotificationCollection.fromJson(String str) => NotificationCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NotificationCollection.fromMap(Map<String, dynamic> json) => NotificationCollection(
        notifications: json["Notifications"] == null ? [] : List<Notification>.from(json["Notifications"]!.map((x) => Notification.fromMap(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
    );

    Map<String, dynamic> toMap() => {
        "Notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toMap())),
        "pagination": pagination?.toMap(),
    };
}

