
import 'dart:convert';

import 'package:provider/models/universitie/universitie_model.dart';

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.university,
    this.collageStudentNumber,
    this.collageStudentEmail,
    this.collageGraduationYears,
    this.gpaGradeType,
    this.gpaScaleType,
    this.gpa,
    this.image,
    this.lastLoginAt,
    this.emailVerifiedAt,
    this.isActive,
    this.isVerified,
    this.notificationCount,
    this.accessToken,
    this.regionCode ,
    this.country_id
  });




  int? id;
  String? name;
  String? email;
  String? mobile;
  University? university;
  String? collageStudentNumber;
  String? collageStudentEmail;
  String? collageGraduationYears;
  String? country_id='1';
  int? gpaGradeType;
  int? gpaScaleType;
  double? gpa;
  dynamic? image;
  DateTime? lastLoginAt;
  dynamic? emailVerifiedAt;
  int? isActive;
  bool? isVerified;
  int? notificationCount;
  String? accessToken;
  String? regionCode ;


  User copyWith({
    int? id,
    String? name,
    String? email,
    String? mobile,
    University? university,
    String? collageStudentNumber,
    String? collageStudentEmail,
    String? collageGraduationYears,
    int? gpaGradeType,
    int? gpaScaleType,
    double? gpa,
    dynamic? image,
    DateTime? lastLoginAt,
    dynamic? emailVerifiedAt,
    int? isActive,
    bool? isVerified,
    int? notificationCount,
    String? accessToken,
    String? regionCode ,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        university: university ?? this.university,
        collageStudentNumber: collageStudentNumber ?? this.collageStudentNumber,
        collageStudentEmail: collageStudentEmail ?? this.collageStudentEmail,
        collageGraduationYears: collageGraduationYears ?? this.collageGraduationYears,
        gpaGradeType: gpaGradeType ?? this.gpaGradeType,
        gpaScaleType: gpaScaleType ?? this.gpaScaleType,
        gpa: gpa ?? this.gpa,
        image: image ?? this.image,
        country_id: country_id??this.country_id,
        lastLoginAt: lastLoginAt ?? this.lastLoginAt,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        isActive: isActive ?? this.isActive,
        isVerified: isVerified ?? this.isVerified,
        notificationCount: notificationCount ?? this.notificationCount,
        accessToken: accessToken ?? this.accessToken,
          regionCode: regionCode ?? this.regionCode ,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    university: json["university"] == null ? null : University.fromMap(json["university"]),
    collageStudentNumber: json["student_number"],
    country_id: json["country_id"].toString(),
    collageStudentEmail: json["student_email"] == null ? null : json["student_email"],
    collageGraduationYears: json["graduation_years"] == null ? null : json["graduation_years"].toString(),
    gpaGradeType: json["gpa_grade_type"] == null ? 2 :int.tryParse( json["gpa_grade_type"].toString())??2,
    gpaScaleType: json["gpa_scale_type"] == null ? 4 : int.tryParse( json["gpa_scale_type"].toString())??4,
    gpa: json["gpa"] == null ? 0.0 : double.tryParse(json["gpa"].toString())??0 ,
    image: json["avatar"]  == null ? null : json["avatar"],
    lastLoginAt: json["last_login_at"] == null ? null : DateTime.parse(json["last_login_at"]),
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"] == null ? 0 : json["is_active"] is bool ?json["is_active"] == true ? 1:0 : json["is_active"],
    isVerified: json["is_verified"] == null ? false : json["is_verified"],
    notificationCount: json["notification_count"] == null ? null : json["notification_count"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    regionCode : json["region_code"] == null ? null : json["region_code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "mobile": mobile == null ? null : mobile,
    "university": university == null ? null : university!.toMap(),
    "student_number": collageStudentNumber,
    "student_email": collageStudentEmail == null ? null : collageStudentEmail,
    "graduation_years": collageGraduationYears,
    "gpa_grade_type": gpaGradeType ==null  ? 2 : int.tryParse(gpaGradeType.toString())??2 ,
    "gpa_scale_type": gpaScaleType == null  ? 4 : int.tryParse(gpaScaleType.toString())??4 ,
    "gpa": gpa == null ? 0 : double.tryParse(gpa.toString())??0 ,
    "avatar": image == null ? null : image,
    "last_login_at": lastLoginAt == null ? null : lastLoginAt!.toIso8601String(),
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt  ,
    "is_active": isActive == null ? null : isActive,
    "is_verified": isVerified == null ? null : isVerified,
    "notification_count": notificationCount == null ? null : notificationCount,
    "access_token": accessToken == null ? null : accessToken,
    "region_code": regionCode == null ? null : regionCode,
  };
}

