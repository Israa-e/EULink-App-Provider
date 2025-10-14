import 'dart:convert';

class Status {
  Status({
    this.status,
    this.message,
    this.code,
  });

  String? status;
  List<dynamic>?message;
  int? code;

  Status copyWith({
    String? status,
    List<dynamic>? message,
    int? code,
  }) =>
      Status(
        status: status ?? this.status,
        message: message ?? this.message ,
        code: code ?? this.code,
      );

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
    status: json["status"],
    message: List<dynamic>.from(json["message"].map((x) => x)),
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": List<String>.from(message!.map((x) => x)),
    "code": code,
  };
  String getmessageList(){
    String msg = "";
    for(int i =0 ; i <message!.length ;i++){
      msg += message![i].toString() +" ";
    }

    return msg ;
  }
}
