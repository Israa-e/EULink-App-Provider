

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Form {
  Form({
    this.id,
    this.serviceId,
    this.key,
    this.name,
    this.parentId,
    this.child,
    this.isRequired,
    this.active,
    this.valueList,
    this.value,
  });

  int? id;
  int? serviceId;
  String? key;
  String? name;
  int? parentId;
  List<Form>? child;
  bool? isRequired;
  bool? active;
  bool IsSelect =false ;
  List<dynamic>? valueList  = [];
  List<String>? value;
  Rx<TextEditingController> ? editTextController  ;
  Form copyWith({
    int? id,
    int? serviceId,
    String? key,
    String? name,
    int? parentId,
    List<Form>? child,
    bool? isRequired,
    bool? active,
    List<dynamic>? valueList,
    List<String>? value,
  }) =>
      Form(
        id: id ?? this.id,
        serviceId: serviceId ?? this.serviceId,
        key: key ?? this.key,
        name: name ?? this.name,
        parentId: parentId ?? this.parentId,
        child: child ?? this.child,
        isRequired: isRequired ?? this.isRequired,
        active: active ?? this.active,
        valueList: valueList ?? this.valueList,
        value: value ?? this.value,
      );

  factory Form.fromJson(String str) => Form.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Form.fromMap(Map<String, dynamic> json) => Form(
    id: json["id"] == null ? null : json["id"],
    serviceId: json["service_id"] == null ? null : json["service_id"],
    key: json["key"] == null ? null : json["key"].toString(),
    name: json["name"] == null ? null : json["name"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    child: json["child"] == null ? null : List<Form>.from(json["child"].map((x) => Form.fromMap(x))),
    isRequired: json["is_required"] == null ? false : json["is_required"],
    active: json["active"] == null ? null : json["active"],
    valueList:[],
    value: json["value"] == null ? null : List<String>.from(json["value"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "service_id": serviceId == null ? null : serviceId,
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "parent_id": parentId == null ? null : parentId,
    "child": child == null ? null : List<dynamic>.from(child!.map((x) => x.toMap())),
    "is_required": isRequired == null ? null : isRequired,
    "active": active == null ? null : active,
    "valueList":valueList == null ? [] : valueList ,
    "value": value == null ? null : List<dynamic>.from(value!.map((x) => x)),
};
}
