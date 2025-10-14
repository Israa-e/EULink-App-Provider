import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../models/order/order_response.dart';
import '../../../models/order/send_message_response.dart';
import '../../../models/order/showOrderByIdResponse.dart';
import '../../../models/order/show_messages_response.dart';
import '../../../models/order/show_user_response.dart';
import '../../../models/order/update_order_response.dart';
import '../../../utils/common.dart';
import 'package:provider/utils/config.dart';

import '../DioExceptions.dart';


class OrderApi {
  final Dio dio;

  OrderApi({required this.dio});

  Future<Either<dynamic, OrderResponse>> getOrderData({status ,required int page ,
  required int per_page  , String? from ,String? to,required int is_completed}) async {
    try {

      String fillter = "";
      if(from != null && to != null && from.isNotEmpty && to.isNotEmpty){
        fillter = "&from="+from.toString()+"&to="+to.toString() ;
      }
      var url = confing.UrlOrders+"?page="+page.toString() +"&per_page="+per_page.toString()+fillter+"&is_completed="+is_completed.toString();
      print("url ### "+url.toString());
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
        queryParameters: {
          'status': status,
          // 'from': '2023-3-14', 'to': '2023-3-14'
        }
      );
      print("url ### "+response.data.toString());

      return Right(OrderResponse.fromMap(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, ShowUserResponse>> ShowUserData({id}) async {
    try {
      var url = confing.UrlShow+"/"+id.toString();
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );
      return Right(ShowUserResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, ShowOrderByIdResponse>> ShowOrderDataById({id}) async {
    try {
      var url = confing.UrlOrders+"/"+id.toString();
      print("url xxx "+url);
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );
      print("url xxx "+response.data.toString());
      return Right(ShowOrderByIdResponse.fromMap(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, ShowOrderByIdResponse>> UpdateOrderDataById({id,status}) async {
    try {
      var url = confing.UrlOrders+"/"+id.toString();
      print("urlxxx "+url);
      print("urlxxx "+status.toString());
      dio.options.headers = Common.headers();
      var data={
        '_method': 'PUT',
        'status': status,
      };
      final response = await dio.post(
        url,
        data: data
      );
      print("urlxxx "+data.toString());
      print("urlxxx "+response.data.toString());
      return Right(ShowOrderByIdResponse.fromMap(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, ShowMessagesResponse>> showChatById({id}) async {
    try {
      var url = confing.UrlOrders+"/"+id.toString()+"/"+confing.UrlChat;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(ShowMessagesResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, SendMessageResponse>> sendChatById({id,message,order_id}) async {
    try {
      var url = confing.UrlOrders+"/"+id.toString()+"/"+confing.UrlChatSend;
      dio.options.headers = Common.headers();
      var data = {
        "order_id": order_id,
        "message": message,
      };
      final response = await dio.post(
        url,
        data: data,
      );

      return Right(SendMessageResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
}
