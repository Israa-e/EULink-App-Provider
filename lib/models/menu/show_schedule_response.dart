// To parse this JSON data, do
//
//     final showScheduleResponse = showScheduleResponseFromMap(jsonString);

import 'dart:convert';

class ShowScheduleResponse {
  bool? success;
  List<dynamic>? message;
  Data? data;

  ShowScheduleResponse({
    this.success,
    this.message,
    this.data,
  });

  ShowScheduleResponse copyWith({
    bool? success,
    List<dynamic>? message,
    Data? data,
  }) =>
      ShowScheduleResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShowScheduleResponse.fromJson(String str) => ShowScheduleResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShowScheduleResponse.fromMap(Map<String, dynamic> json) => ShowScheduleResponse(
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
  Schedule? schedule;

  Data({
    this.schedule,
  });

  Data copyWith({
    Schedule? schedule,
  }) =>
      Data(
        schedule: schedule ?? this.schedule,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    schedule: json["Schedule"] == null ? null : Schedule.fromMap(json["Schedule"]),
  );

  Map<String, dynamic> toMap() => {
    "Schedule": schedule?.toMap(),
  };
}

class Schedule {
  int? id;
  int? day;
  String? startAt;
  String? endAt;
  int? hourlyRate;
  bool? isAvailable;

  Schedule({
    this.id,
    this.day,
    this.startAt,
    this.endAt,
    this.hourlyRate,
    this.isAvailable,
  });

  Schedule copyWith({
    int? id,
    int? day,
    String? startAt,
    String? endAt,
    int? hourlyRate,
    bool? isAvailable,
  }) =>
      Schedule(
        id: id ?? this.id,
        day: day ?? this.day,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        isAvailable: isAvailable ?? this.isAvailable,
      );

  factory Schedule.fromJson(String str) => Schedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
    id: json["id"],
    day: json["day"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    hourlyRate: json["hourly_rate"],
    isAvailable: json["is_available"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "day": day,
    "start_at": startAt,
    "end_at": endAt,
    "hourly_rate": hourlyRate,
    "is_available": isAvailable,
  };
}
