import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:provider/core/connection_service/DioExceptions.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/models/notification/notifications_response.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/config.dart';

import '../../../models/notification/notifications_read_response.dart';

class NotificationApi {
  final Dio dio;

  NotificationApi({required this.dio});

  Future<Either<dynamic, NotificationResponse>> getNotificationsList({required int page,
    required int per_page,}) async {
    try {
      var url = confing.UrlNotifications+"/?" "per_page=" + per_page.toString()+"&page=" + page.toString();
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(NotificationResponse.fromMap(response.data ));
    } on DioError catch (e) {

      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, NotificationsReadResponse>> postNotificationsRead({id}) async {
    try {
      var url = confing.UrlNotifications+"/"+id.toString()+"/"+"read";
      dio.options.headers = Common.headers();
      final response = await dio.post(
        url,
      );

      return Right(NotificationsReadResponse.fromJson(response.data));
    } on DioError catch (e) {

      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, RootResponse>>  notificationsReadAll() async {
    try {
      var url = confing.UrlNotificationsReadAll;
      dio.options.headers = Common.headers();
      final response = await dio.post(
        url,
      );

      return Right(RootResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
}
