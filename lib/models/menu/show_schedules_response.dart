// To parse this JSON data, do
//
//     final showSchedulesResponse = showSchedulesResponseFromJson(jsonString);

import 'dart:convert';

ShowSchedulesResponse showSchedulesResponseFromJson(String str) => ShowSchedulesResponse.fromJson(json.decode(str));

String showSchedulesResponseToJson(ShowSchedulesResponse data) => json.encode(data.toJson());

class ShowSchedulesResponse {
  ShowSchedulesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory ShowSchedulesResponse.fromJson(Map<String, dynamic> json) => ShowSchedulesResponse(
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
    required this.providerSchedule,
  });

  List<ProviderSchedule> providerSchedule;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    providerSchedule: List<ProviderSchedule>.from(json["ProviderSchedule"].map((x) => ProviderSchedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ProviderSchedule": List<dynamic>.from(providerSchedule.map((x) => x.toJson())),
  };
}

class ProviderSchedule {
  ProviderSchedule({
    required this.id,
    required this.day,
    required this.startAt,
    required this.endAt,
    required this.hourlyRate,
    required this.isAvailable,
  });

  int id;
  int day;
  String startAt;
  String endAt;
  int? hourlyRate;
  bool isAvailable;

  factory ProviderSchedule.fromJson(Map<String, dynamic> json) => ProviderSchedule(
    id: json["id"],
    day: json["day"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    hourlyRate: json["hourly_rate"],
    isAvailable: json["is_available"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "start_at": startAt,
    "end_at": endAt,
    "hourly_rate": hourlyRate,
    "is_available": isAvailable,
  };
}
