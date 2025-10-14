// To parse this JSON data, do
//
//     final activationModel = activationModelFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/install/status_root.dart';





class ActivationModel {
  ActivationModel({
    this.status,
    this.data,
  });

  Status? status;
  Data? data;

  ActivationModel copyWith({
    Status? status,
    Data? data,
  }) =>
      ActivationModel(
        status: status ?? this.status,
        data: data == null && data.toString() == "[]" ? null : this.data,
      );

  factory ActivationModel.fromJson(String str) =>
      ActivationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActivationModel.fromMap(Map<String, dynamic> json) => ActivationModel(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : json["data"].toString() == "[]"
                ? null
                : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.code,
  });

  String? code;

  Data copyWith({
    String? code,
  }) =>
      Data(
        code: code ?? this.code,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
      };
}
