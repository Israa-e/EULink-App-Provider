import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/models/menu/show_schedule_response.dart';
import 'package:provider/utils/config.dart';


import '../../../models/authentication/info_response.dart';
import '../../../models/menu/contact_response.dart';
import '../../../models/menu/get_subscription_response.dart';
import '../../../models/menu/plans_response.dart';
import '../../../models/menu/show_schedules_response.dart';
import '../../../models/menu/subscribe_response.dart';
import '../../../models/menu/update_schedules_response.dart';
import '../../../utils/common.dart';
import '../DioExceptions.dart';

class MenuApi {
  final Dio dio;

  MenuApi({required this.dio});

  /**Future<Either<dynamic, OrderResponse>> getSubscriptionData() async {
    try {
      var url = confing.UrlMembershipsSubscription;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(OrderResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
   */

  Future<Either<dynamic, PlansResponse>> getPlansData() async {
    try {
      var url = confing.UrlMembershipsPlans;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(PlansResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, InfoResponse>> infoProviderData() async {
    try {
      var url = confing.UrlMe;
      print("url ## "+url.toString());
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );
      print("url ## "+response.data.toString());

      return Right(InfoResponse.fromMap(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, SubscribeResponse>> subscribe(
      {plan_id}) async {
    try {
      var url = confing.UrlMembershipsSubscribe;
      dio.options.headers = Common.headers();
      var data = {
        "plan_id": plan_id,
      };
      print("url ## "+url.toString());
      print("url ## "+data.toString());
      final response = await dio.post(
        url,
        data: data,
      );

      print("url ## "+response.data.toString());
      return Right(SubscribeResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, GetSubscriptionResponse>> getSubscribe(
      {plan_id}) async {
    try {
      var url = confing.UrlMembershipsSubscription;
      print("urll ##"+url.toString());
      dio.options.headers = Common.headers();

      final response = await dio.get(
        url,
      );
      print("urll ##"+response.data.toString());

      return Right(GetSubscriptionResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, UpdateSchedulesResponse>> updateSchedules(
      {required String start_at,required String end_at,String? hourly_rate, required int id ,required bool is_available}) async {
    try {
      var url = confing.UrlSchedulesUpdate+id.toString();
      dio.options.headers = Common.headers();
      var data = {
        '_method': 'PUT',
        'start_at':start_at,
        'end_at':end_at,
        'is_available': is_available,
        //'hourly_rate':hourly_rate,
      };
      final response = await dio.post(
        url,
        data: data,
      );

      return Right(UpdateSchedulesResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, RootResponse>> cancelSubscriptions(
      {id}) async {
    try {
      var url = confing.UrlSubscriptions+id.toString()+'/cancel';
      dio.options.headers = Common.headers();
      final response = await dio.post(
        url,
      );

      print("resss # "+response.data.toString());
      return Right(RootResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }



  Future<Either<dynamic, SubscribeResponse>> pay(
      {required String id ,required String name ,required String card , required String month,required String year ,required String cvc}) async {
    try {
      var url = confing.UrlSubscriptions+""+'pay';
      print("url "+url);
      dio.options.headers = Common.headers();
      final response = await dio.post(
        url,
        data: {
          "name":""+name.toString(),
          "card":""+card.toString(),
          "month":""+month.toString(),
          "year":""+year.toString(),
          "cvc":""+cvc.toString(),

        }
      );

      print("resss # "+response.data.toString());
      return Right(SubscribeResponse.fromJson( response.data ));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }


  Future<Either<dynamic, SubscribeResponse>> reNewPay() async {
    try {
      var url = confing.UrlSubscriptions+""+'renew';
      print("url "+url);
      dio.options.headers = Common.headers();
      final response = await dio.post(
          url,

      );

      print("resss # "+response.data.toString());
      return Right(SubscribeResponse.fromJson( response.data ));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }




  // //Notifications
  // Future<Either<dynamic, NotificationsResponse>> getNotificationsData() async {
  //   try {
  //     var url = confing.UrlNotifications;
  //     dio.options.headers = Common.headers();
  //     final response = await dio.get(
  //       url,
  //     );
  //
  //     return Right(NotificationsResponse.fromJson(response.data));
  //   } on DioError catch (e) {
  //     var errorMessage = DioExceptions.fromDioError(e);
  //     return Left(errorMessage);
  //   }
  // }

  // Future<Either<dynamic, NotificationsResponse>> readNotificationsDataById({id}) async {
  //   try {
  //     var url = confing.UrlNotifications+"/"+id.toString()+"/read";
  //     dio.options.headers = Common.headers();
  //     final response = await dio.post(
  //       url,
  //     );
  //     return Right(NotificationsResponse.fromJson(response.data));
  //   } on DioError catch (e) {
  //     var errorMessage = DioExceptions.fromDioError(e);
  //     return Left(errorMessage);
  //   }
  // }

  //// address
  // Future<Either<dynamic, AddressesResponse>> getAddressData() async {
  //   try {
  //     var url = confing.UrlMyAddress;
  //     dio.options.headers = Common.headers();
  //     final response = await dio.get(
  //       url,
  //     );
  //     return Right(AddressesResponse.fromJson(response.data));
  //   } on DioError catch (e) {
  //     var errorMessage = DioExceptions.fromDioError(e);
  //     return Left(errorMessage);
  //   }
  // }

  // Future<Either<dynamic, deletedAddressesResponse>> destroyAddressDataById({id}) async {
  //   try {
  //     var url = confing.UrlAddressDestroy+"/"+id.toString();
  //     dio.options.headers = Common.headers();
  //     final response = await dio.delete(
  //       url,
  //     );
  //     return Right(deletedAddressesResponse.fromJson(response.data));
  //   } on DioError catch (e) {
  //     var errorMessage = DioExceptions.fromDioError(e);
  //     return Left(errorMessage);
  //   }
  // }

  // Future<Either<dynamic, StoreAddresses>> storeAddressData({
  //  required latitude,
  //  required longitude,
  //  required name,
  //  required address,}) async {
  //   try {
  //     var url = confing.UrlMyAddress;
  //     dio.options.headers = Common.headers();
  //     var data={
  //       'latitude': latitude,
  //       'longitude': longitude,
  //       'name': name,
  //       'address': address
  //     };
  //     final response = await dio.post(
  //       url,
  //       data: data
  //     );
  //     return Right(StoreAddresses.fromJson(response.data));
  //   } on DioError catch (e) {
  //     var errorMessage = DioExceptions.fromDioError(e);
  //     return Left(errorMessage);
  //   }
  // }

  // Future<Either<dynamic, StoreAddresses>> updateAddressData({
  //  required name,
  //  required address,required id}) async {
  //   try {
  //     var url = confing.UrlMyAddress+"/"+id.toString();
  //     dio.options.headers = Common.headers();
  //     var data={
  //       '_method': 'PUT',
  //       'latitude': 'abc',
  //       'longitude': 'abc',
  //       'name': name,
  //       'address': address,
  //       'is_default':'1'
  //     };
  //     final response = await dio.post(
  //       url,
  //       data: data
  //     );
  //     return Right(StoreAddresses.fromJson(response.data));
  //   } on DioError catch (e) {
  //     var errorMessage = DioExceptions.fromDioError(e);
  //     return Left(errorMessage);
  //   }
  // }

  //contact
  Future<Either<dynamic, ContactResponse>> contactData({
    required country_id,
    required message,
    required name,
    required mobile,}) async {
    try {
      var url = confing.UrlContact;
      dio.options.headers = Common.headers();
      var data={
        'name': name,
        'mobile': mobile,
        'country_id': country_id,
        'message': message
      };
      final response = await dio.post(
          url,
          data: data
      );
      return Right(ContactResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, ShowSchedulesResponse>> showSchedulesData() async {
    try {
      var url = confing.UrlShowSchedules;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );
      return Right(ShowSchedulesResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
  Future<Either<dynamic, ShowScheduleResponse>> updateSchedulesData(id , {required String from ,required String to}) async {
    try {
      var url = confing.UrlShowSchedulesUpdate+"/"+id.toString();
      dio.options.headers = Common.headers();
      final response = await dio.post(
        url,
        data: {
          "_method":"PUT" ,
          "start_at":from ,
          "end_at":to ,

        }
      );
      return Right(ShowScheduleResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

}
