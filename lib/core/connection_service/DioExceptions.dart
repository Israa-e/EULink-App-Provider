import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/utils/helper.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    if (dioError.response != null &&
        dioError.response!.data != null &&
        dioError.response!.data["message"] != null) {
      message = dioError.response!.data["message"].toString();

      if (dioError.response!.data["errors"] != null) {
        String error = dioError.response!.data["errors"].toString();

        Map<String, dynamic> decoded =
            json.decode(jsonEncode(dioError.response!.data["errors"]));
        List<String> str = [];
        decoded.forEach((key, value) {
          if (value != null) {
            value = value.toString().replaceAll("]", "");
            value = value.toString().replaceAll("[", "");
            value = value.toString().replaceAll(",", "\n");

            str.add(value + "");
            // message  += "\n"+value.toString();
          }
        });

        message = "" + str.join("\n").toString();
      }
    } else {
      switch (dioError.type) {
        case DioErrorType.cancel:
          message = "Request API an celled".tr;
          break;
        case DioErrorType.connectTimeout:
          message = "Connection timeout".tr;
          break;
        case DioErrorType.receiveTimeout:
          message = "Receive timeout".tr;
          break;
        case DioErrorType.response:
          message = _handleError(
              dioError.response!.statusCode!, dioError.response!.data!);
          break;
        case DioErrorType.sendTimeout:
          message = "send timeout".tr;
          break;
        case DioErrorType.other:
          message = dioError.message.toString();

          break;
        default:
          message = dioError.message != null
              ? !dioError.message.toString().contains("60204")
                  ? dioError.message.toString()
                  : 'no_internet'.tr
              : 'internal server error'.tr;
          break;
      }
    }
  }

  dynamic message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'bad_request'.tr;
      case 404:
        return error["message"];
      case 401:
        return error["message"];
      case 403:
        return error["message"];
      case 402:
        return error["message"];
      case 500:
        return 'internal server error'.tr;
      default:
        return error["message"] != null
            ?   !error["message"].toString().contains("60204")
            ? error["message"].message.toString()
            : 'no_internet'.tr
            : 'internal server error'.tr;
    }
  }

  @override
  String toString() => message;
}
