
import 'dart:convert';

import '../install/country_model.dart';

SplashResponse splashResponseFromJson(String str) => SplashResponse.fromJson(json.decode(str));

String splashResponseToJson(SplashResponse data) => json.encode(data.toJson());

class SplashResponse {
  SplashResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  List<dynamic> message;
  Data data;

  factory SplashResponse.fromJson(Map<String, dynamic> json) => SplashResponse(
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
    required this.enums,
    required this.setting,
    required this.locales,
    required this.countries,
  });

  Enums enums;
  Setting setting;
  List<Locales> locales;
  List<Country> countries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    enums: Enums.fromJson(json["Enums"]),
    setting: Setting.fromJson(json["Setting"]),
    locales: json["Locales"] == null ? [] : List<Locales>.from(json["Locales"]!.map((x) => Locales.fromMap(x))),
    countries: json["Countries"] == null ? [] : List<Country>.from(json["Countries"]!.map((x) => Country.fromMap(x))),
  );

  Map<String, dynamic> toJson() => {
    "Enums": enums.toJson(),
    "Setting": setting.toJson(),
    "Locales": locales == null ? [] : List<dynamic>.from(locales!.map((x) => x.toMap())),
    "Countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toMap())),
  };
}


class Currency {
  int? id;
  String? name;
  String? code;
  String? symbol;
  bool? isActive;

  Currency({
    this.id,
    this.name,
    this.code,
    this.symbol,
    this.isActive,
  });

  Currency copyWith({
    int? id,
    String? name,
    String? code,
    String? symbol,
    bool? isActive,
  }) =>
      Currency(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
        isActive: isActive ?? this.isActive,
      );

  factory Currency.fromJson(String str) => Currency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Currency.fromMap(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "code": code,
    "symbol": symbol,
    "is_active": isActive,
  };
}
class Locales {
  int? id;
  String? name;
  String? locale;
  bool? isActive;
  bool isSelect = false ;

  Locales({
    this.id,
    this.name,
    this.locale,
    this.isActive,
  });

  Locales copyWith({
    int? id,
    String? name,
    String? locale,
    bool? isActive,
  }) =>
      Locales(
        id: id ?? this.id,
        name: name ?? this.name,
        locale: locale ?? this.locale,
        isActive: isActive ?? this.isActive,
      );

  factory Locales.fromJson(String str) => Locales.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Locales.fromMap(Map<String, dynamic> json) => Locales(
    id: json["id"],
    name: json["name"],
    locale: json["locale_code"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "locale_code": locale,
    "is_active": isActive,
  };
}

class Enums {
  Enums({
    required this.appMode,
    required this.dayEnum,
    required this.inputType,
    required this.notificationDestinationType,
    required this.notificationRefType,
    required this.orderStatusEnum,
    required this.pointRefType,
    required this.pointType,
    required this.senderType,
    required this.subscriptionStatus,
    required this.verificationRefType,
  });

  AppMode appMode;
  DayEnum dayEnum;
  InputType inputType;
  Type notificationDestinationType;
  NotificationRefType notificationRefType;
  OrderStatusEnum orderStatusEnum;
  PointRefType pointRefType;
  PointType pointType;
  Type senderType;
  SubscriptionStatus subscriptionStatus;
  Type verificationRefType;

  factory Enums.fromJson(Map<String, dynamic> json) => Enums(
    appMode: AppMode.fromJson(json["AppMode"]),
    dayEnum: DayEnum.fromJson(json["DayEnum"]),
    inputType: InputType.fromJson(json["InputType"]),
    notificationDestinationType: Type.fromJson(json["NotificationDestinationType"]),
    notificationRefType: NotificationRefType.fromJson(json["NotificationRefType"]),
    orderStatusEnum: OrderStatusEnum.fromJson(json["OrderStatusEnum"]),
    pointRefType: PointRefType.fromJson(json["PointRefType"]),
    pointType: PointType.fromJson(json["PointType"]),
    senderType: Type.fromJson(json["SenderType"]),
    subscriptionStatus: SubscriptionStatus.fromJson(json["SubscriptionStatus"]),
    verificationRefType: Type.fromJson(json["VerificationRefType"]),
  );

  Map<String, dynamic> toJson() => {
    "AppMode": appMode.toJson(),
    "DayEnum": dayEnum.toJson(),
    "InputType": inputType.toJson(),
    "NotificationDestinationType": notificationDestinationType.toJson(),
    "NotificationRefType": notificationRefType.toJson(),
    "OrderStatusEnum": orderStatusEnum.toJson(),
    "PointRefType": pointRefType.toJson(),
    "PointType": pointType.toJson(),
    "SenderType": senderType.toJson(),
    "SubscriptionStatus": subscriptionStatus.toJson(),
    "VerificationRefType": verificationRefType.toJson(),
  };
}

class AppMode {
  AppMode({
    required this.lightMode,
    required this.darkMode,
    required this.dimMode,
  });

  int lightMode;
  int darkMode;
  int dimMode;

  factory AppMode.fromJson(Map<String, dynamic> json) => AppMode(
    lightMode: json["LightMode"],
    darkMode: json["DarkMode"],
    dimMode: json["DimMode"],
  );

  Map<String, dynamic> toJson() => {
    "LightMode": lightMode,
    "DarkMode": darkMode,
    "DimMode": dimMode,
  };
}

class DayEnum {
  DayEnum({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;

  factory DayEnum.fromJson(Map<String, dynamic> json) => DayEnum(
    sunday: json["Sunday"],
    monday: json["Monday"],
    tuesday: json["Tuesday"],
    wednesday: json["Wednesday"],
    thursday: json["Thursday"],
    friday: json["Friday"],
    saturday: json["Saturday"],
  );

  Map<String, dynamic> toJson() => {
    "Sunday": sunday,
    "Monday": monday,
    "Tuesday": tuesday,
    "Wednesday": wednesday,
    "Thursday": thursday,
    "Friday": friday,
    "Saturday": saturday,
  };
}

class InputType {
  InputType({
    required this.textBox,
    required this.textArea,
    required this.image,
    required this.checkBox,
  });

  int textBox;
  int textArea;
  int image;
  int checkBox;

  factory InputType.fromJson(Map<String, dynamic> json) => InputType(
    textBox: json["TextBox"],
    textArea: json["TextArea"],
    image: json["Image"],
    checkBox: json["CheckBox"],
  );

  Map<String, dynamic> toJson() => {
    "TextBox": textBox,
    "TextArea": textArea,
    "Image": image,
    "CheckBox": checkBox,
  };
}

class Type {
  Type({
    required this.user,
    required this.provider,
  });

  int user;
  int provider;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    user: json["User"],
    provider: json["Provider"],
  );

  Map<String, dynamic> toJson() => {
    "User": user,
    "Provider": provider,
  };
}

class NotificationRefType {
  NotificationRefType({
    required this.order,
    required this.chat,
  });

  int order;
  int chat;

  factory NotificationRefType.fromJson(Map<String, dynamic> json) => NotificationRefType(
    order: json["Order"],
    chat: json["Chat"],
  );

  Map<String, dynamic> toJson() => {
    "Order": order,
    "Chat": chat,
  };
}

class OrderStatusEnum {
  OrderStatusEnum({
    required this.orderStatusEnumNew,
    required this.pending,
    required this.approved,
    required this.canceled,
    required this.rejected,
    required this.inProgress,
    required this.completed,
    required this.caseIssue,
  });

  int orderStatusEnumNew;
  int pending;
  int approved;
  int canceled;
  int rejected;
  int inProgress;
  int completed;
  int caseIssue;

  factory OrderStatusEnum.fromJson(Map<String, dynamic> json) => OrderStatusEnum(
    orderStatusEnumNew: json["New"],
    pending: json["Pending"],
    approved: json["Approved"],
    canceled: json["Canceled"],
    rejected: json["Rejected"],
    inProgress: json["InProgress"],
    completed: json["Completed"],
    caseIssue: json["CaseIssue"],
  );

  Map<String, dynamic> toJson() => {
    "New": orderStatusEnumNew,
    "Pending": pending,
    "Approved": approved,
    "Canceled": canceled,
    "Rejected": rejected,
    "InProgress": inProgress,
    "Completed": completed,
    "CaseIssue": caseIssue,
  };
}

class PointRefType {
  PointRefType({
    required this.order,
  });

  int order;

  factory PointRefType.fromJson(Map<String, dynamic> json) => PointRefType(
    order: json["Order"],
  );

  Map<String, dynamic> toJson() => {
    "Order": order,
  };
}

class PointType {
  PointType({
    required this.deposit,
    required this.withdraw,
  });

  int deposit;
  int withdraw;

  factory PointType.fromJson(Map<String, dynamic> json) => PointType(
    deposit: json["Deposit"],
    withdraw: json["Withdraw"],
  );

  Map<String, dynamic> toJson() => {
    "Deposit": deposit,
    "Withdraw": withdraw,
  };
}

class SubscriptionStatus {
  SubscriptionStatus({
    required this.subscriptionStatusNew,
  });

  int? subscriptionStatusNew;

  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) => SubscriptionStatus(
    subscriptionStatusNew: json["New"],
  );

  Map<String, dynamic> toJson() => {
    "New": subscriptionStatusNew,
  };
}

class Setting {
  Setting({
    required this.appVersion,
    required this.maintenanceMode,
  });

  String appVersion;
  String maintenanceMode;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    appVersion: json["app_version"],
    maintenanceMode: json["maintenance_mode"],
  );

  Map<String, dynamic> toJson() => {
    "app_version": appVersion,
    "maintenance_mode": maintenanceMode,
  };
}
