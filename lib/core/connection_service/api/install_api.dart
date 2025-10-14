import 'dart:async';
 import 'dart:convert';


 import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:provider/core/connection_service/DioExceptions.dart';
import 'package:provider/models/brand/brand_response.dart';
import 'package:provider/models/brand/brands_response.dart';
import 'package:provider/models/install/pages_response.dart';
import 'package:provider/models/install/sliders_response.dart';

import '../../../models/install/category_response.dart';
import '../../../models/install/install_response.dart';
import '../../../utils/common.dart';
 import 'package:provider/utils/config.dart';

class InstallApi {
  final Dio dio;

  InstallApi({required this.dio});
  Future<Either<dynamic, PagesResponse>> getPagesByKey({required String key}) async {
    try {
      var url =  "page?key="+key;
      print( url.toString());
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      print("about # "+response.data.toString());
      return Right(PagesResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      print("about # "+e.toString());
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }










}
