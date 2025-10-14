// To parse this JSON data, do
//
//     final chatsResponse = chatsResponseFromMap(jsonString);

import 'dart:convert';

import '../install/paging_model.dart';
import 'message_model.dart';

class ChatsResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  ChatsResponse({
    this.success,
    this.message,
    this.data,
  });

  ChatsResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      ChatsResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ChatsResponse.fromJson(String str) => ChatsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatsResponse.fromMap(Map<String, dynamic> json) => ChatsResponse(
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
  ChatsCollection? chatsCollection;

  Data({
    this.chatsCollection,
  });

  Data copyWith({
    ChatsCollection? chatsCollection,
  }) =>
      Data(
        chatsCollection: chatsCollection ?? this.chatsCollection,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    chatsCollection: json["ChatsCollection"] == null ? null : ChatsCollection.fromMap(json["ChatsCollection"]),
  );

  Map<String, dynamic> toMap() => {
    "ChatsCollection": chatsCollection?.toMap(),
  };
}

class ChatsCollection {
  List<Chat>? chats;
  Pagination? pagination;

  ChatsCollection({
    this.chats,
    this.pagination,
  });

  ChatsCollection copyWith({
    List<Chat>? chats,
    Pagination? pagination,
  }) =>
      ChatsCollection(
        chats: chats ?? this.chats,
        pagination: pagination ?? this.pagination,
      );

  factory ChatsCollection.fromJson(String str) => ChatsCollection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatsCollection.fromMap(Map<String, dynamic> json) => ChatsCollection(
    chats: json["Chats"] == null ? [] : List<Chat>.from(json["Chats"]!.map((x) => Chat.fromMap(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "Chats": chats == null ? [] : List<dynamic>.from(chats!.map((x) => x.toMap())),
    "pagination": pagination?.toMap(),
  };
}


