// To parse this JSON data, do
//
//     final updateProviderResponse = updateProviderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:provider/models/authentication/provider.dart';

UpdateProviderResponse updateProviderResponseFromJson(String str) => UpdateProviderResponse.fromJson(json.decode(str));

String updateProviderResponseToJson(UpdateProviderResponse data) => json.encode(data.toJson());

class UpdateProviderResponse {
  UpdateProviderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<String> message;
  Data data;

  factory UpdateProviderResponse.fromJson(Map<String, dynamic> json) => UpdateProviderResponse(
    success: json["success"],
    message: List<String>.from(json["message"].map((x) => x)),
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
    required this.provider,
  });

  Provider provider;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    provider: Provider.fromJson(json["Provider"]),
  );

  Map<String, dynamic> toJson() => {
    "Provider": provider.toJson(),
  };
}




