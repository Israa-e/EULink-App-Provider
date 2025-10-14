
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/core/connection_service/api/chat_api.dart';
import 'package:provider/core/connection_service/api/info_api.dart';
import 'package:provider/core/connection_service/api/install_api.dart';
import 'package:provider/core/connection_service/api/notification_api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:provider/utils/config.dart';

import '../api/menu_api.dart';
import '../api/order_api.dart';



class InitialBinding extends Bindings {
  @override
  void dependencies() {
    var dio = Dio()
      ..options.baseUrl = confing.baseUrlPublic
      ..interceptors.add(interceptorsWrapper());

    Get.put(dio);
     Get.lazyPut<InstallApi>(() => InstallApi(dio: Get.find()), fenix: true);
    Get.lazyPut<AuthApi>(() => AuthApi(dio: Get.find()), fenix: true);
    Get.lazyPut<InfoApi>(() => InfoApi(dio: Get.find()), fenix: true);
    Get.lazyPut<MenuApi>(() => MenuApi(dio: Get.find()), fenix: true);
    Get.lazyPut<OrderApi>(() => OrderApi(dio: Get.find()), fenix: true);
    Get.lazyPut<ChatApi>(() => ChatApi(dio: Get.find()), fenix: true);





     Get.lazyPut<NotificationApi>(() => NotificationApi(dio: Get.find()),
        fenix: true);
  }

  InterceptorsWrapper interceptorsWrapper() {
    return InterceptorsWrapper(onRequest: (options, handler) {

      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {

      if (e.response != null && e.response!.data != null) {}
      return handler.next(e); //continue
    });
  }
}

