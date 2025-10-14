// To parse this JSON data, do
//
//     final showMessagesResponse = showMessagesResponseFromJson(jsonString);

import 'dart:convert';

ShowMessagesResponse showMessagesResponseFromJson(String str) => ShowMessagesResponse.fromJson(json.decode(str));

String showMessagesResponseToJson(ShowMessagesResponse data) => json.encode(data.toJson());

class ShowMessagesResponse {
  ShowMessagesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory ShowMessagesResponse.fromJson(Map<String, dynamic> json) => ShowMessagesResponse(
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
    required this.chatsCollection,
  });

  ChatsCollection chatsCollection;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    chatsCollection: ChatsCollection.fromJson(json["ChatsCollection"]),
  );

  Map<String, dynamic> toJson() => {
    "ChatsCollection": chatsCollection.toJson(),
  };
}

class ChatsCollection {
  ChatsCollection({
    required this.chats,
    required this.pagination,
  });

  List<Chat> chats;
  Pagination pagination;

  factory ChatsCollection.fromJson(Map<String, dynamic> json) => ChatsCollection(
    chats: List<Chat>.from(json["Chats"].map((x) => Chat.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "Chats": List<dynamic>.from(chats.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Chat {
  Chat({
    required this.id,
    required this.senderType,
    required this.senderId,
    required this.message,
  });

  int id;
  int senderType;
  int senderId;
  String message;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    senderType: json["sender_type"],
    senderId: json["sender_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_type": senderType,
    "sender_id": senderId,
    "message": message,
  };
}

class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  Pagination copyWith({
    int? total,
    int? perPage,
    int? currentPage,
    int? lastPage,
  }) =>
      Pagination(
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
      );

  factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toMap() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
  };
}
