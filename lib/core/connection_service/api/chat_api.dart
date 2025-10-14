import 'dart:async';
 import 'dart:convert';


 import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:provider/core/connection_service/DioExceptions.dart';
import 'package:provider/models/chat/chat_response.dart';
import 'package:provider/models/chat/chats_response.dart';
import 'package:provider/utils/config.dart';

import '../../../models/install/category_response.dart';
import '../../../models/install/install_response.dart';
import '../../../utils/common.dart';

class ChatApi {
  final Dio dio;

  ChatApi({required this.dio});
  Future<Either<dynamic, ChatsResponse>> getChatMessagesByOrderId({required int id,
  required page ,required per_page}) async {
    try {
      var url = confing.UrlOrders+"/"+id.toString()+"/chat?page="+page.toString()+"&per_page="+per_page.toString();
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(ChatsResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, ChatResponse>> sendMessageByOrderId({required int id,required String message, type} ) async {
    try {
      var url = confing  .UrlOrders+"/"+id.toString() +"/chat/send";
      dio.options.headers = Common.headers();
      final response = await dio.post(
        url,
        data: {
          "order_id":id,
          "message":message.toString(),
          "message_type": type.toString()
        }
      );

      return Right(ChatResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, ChatResponse>> sendMessageByOrderIdFile({required int id,required String message,type} ) async {
    try {
      var url = confing.UrlOrders+"/"+id.toString() +"/chat/send";
      print("url XX "+url);
      dio.options.headers = Common.headers();


      final   response = await dio.post(
        url,
        data: FormData.fromMap({
          "order_id": id,
          "message_type": type.toString(),
          "message":
          await MultipartFile.fromFile(message , filename: "image.jpg"),
        }),
      );
      print("ressx "+message + "msg _type "+type.toString());


      print("resxx "+response.data.toString());
      return Right(ChatResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      print("resxx "+e.toString());
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }




}
