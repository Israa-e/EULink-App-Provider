import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/main.dart';
import 'package:provider/utils/call_back_notification.dart';
import 'package:provider/utils/dialog_utils.dart';

import '../../../core/connection_service/api/order_api.dart';
import '../../../models/order/showOrderByIdResponse.dart';
import '../../../models/order/show_user_response.dart';
import '../../../models/order/update_order_response.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';
import 'package:map_launcher/map_launcher.dart';

class OrderDetailsController extends GetxController {
  var isLoading;
  var id;

  bool isUpdate = false;
  bool canBack = true;

  OrderDetailsController({required this.id});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    if(Get.arguments != null) {
      if (Get.arguments[0] != null) {
        id = Get.arguments[0];
      }
      if (Get.arguments != null && Get.arguments[1] != null &&
          Get.arguments[1] is bool) {
        canBack = Get.arguments[1];

        update();
      }
    }
    ShowOrderData(id);
  }

  @override
  void onReady() {
    super.onReady();
    changeOrderController = StreamController<ListinOrderNotification>();
    changeOrderController.stream.listen((e) {
      print(e.toString() +"notiiiiii orders");
      ShowOrderData(id);
      isUpdate =true ;
      update();
    });



  }


  Future ShowUserData(id) async {
     update();
    return await Get.find<OrderApi>().ShowUserData(id: id)
      ..fold(onError, onSuccess);
  }

  onError(failure) async {
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
        } else {
          // internet=false.obs;
          update();
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: 'no_internet'.tr,
          );
        }
      });
    } else {
      log("Error $failure");

      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: failure.toString(),
      );
    }
     update();
  }

  // User? userOrder;
  var paginationList;

  onSuccess(ShowUserResponse data) async {
    print(Common.getUser()!.data!.login!.accessToken);
    update();
    String? key = getKeyForValue(1);
     if (data.success != false) {
      // userOrder = data.data.user;
       // print('data.data?.toJson() ${userOrder?.name}');
    } else {}
    update();
    update();
  }

  Future ShowOrderData(id) async {
    isLoading = true.obs;
    print("Hi ::::::::");
    update();
    return await Get.find<OrderApi>().ShowOrderDataById(id: id)
      ..fold(onErrorOrder, onSuccessOrder);
  }

  onErrorOrder(failure) async {
    isLoading = false.obs;
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
        } else {
          // internet=false.obs;
          update();
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: 'no_internet'.tr,
          );
        }
      });
    } else {
      log("Error $failure");

      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: failure.toString(),
      );
    }
    // int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  Order? orderList;
  String? formattedDate = '';

  onSuccessOrder(ShowOrderByIdResponse data) async {
    isLoading = false.obs;
    print(Common.getUser()!.data!.login!.accessToken);
    update();
    String? key = getKeyForValue(1);
     if (data.success != false) {
      print(formattedDate);
      orderList = data.data!.order!;
      //orderList!.rate =0.toString();
      formattedDate =
          DateFormat('d MMMM y', 'en_US').format(data.data!.order!.date!);

      // print('data.data?.toJson() ${data.data.toJson()}');
      // print('data.data?.toJson() ${userOrder?.name}');
    } else {}
    update();
    update();
  }

  Future UpdateOrderData({required id, status}) async {
    isLoading = true.obs;
    update();
    return await Get.find<OrderApi>()
        .UpdateOrderDataById(id: id, status: status)
      ..fold(onErrorOrderUpdate, onSuccessOrderUpdate);
  }

  onErrorOrderUpdate(failure) async {
    isLoading = false.obs;
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
        } else {
          // internet=false.obs;
          update();
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: 'no_internet'.tr,
          );
        }
      });
    } else {
      log("Error $failure");

      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: failure.toString(),
      );
    }
    // int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  onSuccessOrderUpdate(ShowOrderByIdResponse data) async {
    print(Common.getUser()!.data!.login!.accessToken);
    update();
    String? key = getKeyForValue(1);
     if (data.success != false) {
      isUpdate = true;

      orderList = data.data!.order!;
      formattedDate =
          DateFormat('d MMMM y', 'en_US').format(data.data!.order!.date!);
    } else {}
    update();
    isLoading = false.obs;
    update();
  }

  String? getKeyForValue(int? value) {
    Map<String, dynamic>? map =
        Common.getSplash()?.data.enums.orderStatusEnum.toJson();
    for (String key in map!.keys) {
      if (map[key] == value) {
        return key;
      }
    }
    return null; // Value not found in map
  }


  void rejectOrder() {
    var context = Get.context as BuildContext;
    DialogUtils.showCustomDialogDelete(context, () {
      UpdateOrderData(id: id ,status:Common.getSplash()
          ?.data
          .enums
          .orderStatusEnum
          .rejected);

    }, "Reject order".tr, "msg_reject_order".tr);
  }


  void acceptOrder() {
    var context = Get.context as BuildContext;
    DialogUtils.showCustomDialogTowAction(context, () {
      UpdateOrderData(id:id ,status:Common.getSplash()
          ?.data
          .enums
          .orderStatusEnum
          .approved);

    }, "Accept order".tr, "msg_accept_order".tr);
  }


  void InProgressOrder() {
    var context = Get.context as BuildContext;
    DialogUtils.showCustomDialogTowAction(context, () {
      UpdateOrderData(id:id ,status:Common.getSplash()
          ?.data
          .enums
          .orderStatusEnum
          .inProgress);

    }, "In Progress".tr, "msg_In_Progress".tr);
  }
  void CompletedOrder() {
    var context = Get.context as BuildContext;
    DialogUtils.showCustomDialogTowAction(context, () {
      UpdateOrderData(id:id ,status:Common.getSplash()
          ?.data
          .enums
          .orderStatusEnum
          .completed);

    }, "Completed".tr, "msg_Completed".tr);
  }
  void caseIssueOrder() {
    var context = Get.context as BuildContext;
    DialogUtils.showCustomDialogDelete(context, () {
      UpdateOrderData(id:id ,status:Common.getSplash()!.data.enums.orderStatusEnum.caseIssue);

    }, "CaseIssue".tr, "msg_caseIssue".tr);
  }
  Future<void> GoToMap(String address, double lat, double lng) async {
    if (lat != null && lng != null) {
         final availableMaps = await MapLauncher.installedMaps;
         print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

         await availableMaps.first.showMarker(
           coords: Coords(lat, lng),
           title: address.toString(),
         );

      //;
    } else {
      ScaffoldMessenger.of(Get.context as BuildContext)
          .showSnackBar(SnackBar(content: new Text('Could not launch')));
    }
  }

}
