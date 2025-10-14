import 'dart:async';
 import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:provider/core/connection_service/DioExceptions.dart';
import 'package:provider/models/install/faqs_response.dart';
import 'package:provider/models/install/info_response.dart';
import 'package:provider/models/install/social_response.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/config.dart';

import '../../../models/splash/splash_response.dart';

class InfoApi {
  final Dio dio;

  InfoApi({required this.dio});

  Future<Either<dynamic, FaqsResponse>> getFagsList(
      {required int page,
      required int per_page,
      String? q,
      int? category_id,
      int? sub_category_id,
      int? child_sub_category_id,
      int? sort}) async {
    String newURL= confing.UrlFaqs +"?page"+page.toString() +"&per_page="+per_page.toString() ;




    try {
      var url = newURL;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(FaqsResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }



  Future<Either<dynamic, InfoResponse>> policy() async {
    String newURL= confing.UrlPolicy   ;




    try {
      var url = newURL;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(InfoResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, InfoResponse>> terms() async {
    String newURL= confing.UrlTerms   ;




    try {
      var url = newURL;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(InfoResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, SocialResponse>> socialLink() async {
    String newURL= confing.UrlSocial   ;




    try {
      var url = newURL;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(SocialResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic,SplashResponse>> splash()async{
    String newURL= confing.baseUrl+'api/user/splash' ;

    try {
      var url = newURL;
      print("splash ## "+ url.toString());
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      print("splash ## "+ response.data.toString());
      return Right(SplashResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }


 }
