import 'dart:convert';

import 'package:provider/models/install/status_root.dart';

import 'category_model.dart';
import 'country_model.dart';

// To parse this JSON data, do
//
//     final rootResponse = rootResponseFromMap(jsonString);

import 'dart:convert';

class RootResponse {
  bool? success;
  List<String>? message;
  List<dynamic>? data;

  RootResponse({
    this.success,
    this.message,
    this.data,
  });

  RootResponse copyWith({
    bool? success,
    List<String>? message,
    List<dynamic>? data,
  }) =>
      RootResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RootResponse.fromJson(String str) => RootResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RootResponse.fromMap(Map<String, dynamic> json) => RootResponse(
    success: json["success"],
    message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
  String getMessageList(){
    String msg = "";
    for(int i =0 ; i <message!.length ;i++){
      msg += message![i].toString() +" ";
    }

    return msg ;
  }

}






