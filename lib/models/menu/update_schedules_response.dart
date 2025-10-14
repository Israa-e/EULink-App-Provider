// To parse this JSON data, do
//
//     final updateSchedulesResponse = updateSchedulesResponseFromJson(jsonString);

import 'dart:convert';

UpdateSchedulesResponse updateSchedulesResponseFromJson(String str) => UpdateSchedulesResponse.fromJson(json.decode(str));

String updateSchedulesResponseToJson(UpdateSchedulesResponse data) => json.encode(data.toJson());

class UpdateSchedulesResponse {
  UpdateSchedulesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory UpdateSchedulesResponse.fromJson(Map<String, dynamic> json) => UpdateSchedulesResponse(
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
    required this.schedule,
  });

  Schedule schedule;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    schedule: Schedule.fromJson(json["Schedule"]),
  );

  Map<String, dynamic> toJson() => {
    "Schedule": schedule.toJson(),
  };
}

class Schedule {
  Schedule({
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
  String hourlyRate;
  bool isAvailable;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["id"],
    day: json["day"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    hourlyRate: json["hourly_rate"] != null  ?json["hourly_rate"]  : "",
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
