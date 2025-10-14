import 'dart:convert';

class Chat {
  int? id;
  int? senderType;
  int? senderId;
  String? message;
  int? message_type ;
  DateTime? createdAt;

  Chat({
    this.id,
    this.senderType,
    this.senderId,
    this.message,
    this.message_type,
    this.createdAt,
  });

  Chat copyWith({
    int? id,
    int? senderType,
    int? senderId,
    String? message,
    int? message_type,
    DateTime? createdAt,
  }) =>
      Chat(
        id: id ?? this.id,
        senderType: senderType ?? this.senderType,
        senderId: senderId ?? this.senderId,
        message: message ?? this.message,
        message_type: message_type ?? this.message_type,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Chat.fromJson(String str) => Chat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Chat.fromMap(Map<String, dynamic> json) => Chat(
    id: json["id"],
    senderType: json["sender_type"],
    senderId: json["sender_id"],
    message: json["message"],
    message_type: json["message_type"] == null ?0: json["message_type"] ,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "sender_type": senderType,
    "sender_id": senderId,
    "message": message,
    "message_type": message_type == null ?0 : message_type,
    "created_at": createdAt?.toIso8601String(),
  };
}
