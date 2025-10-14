import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';
import 'package:provider/main.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/models/order/show_messages_response.dart';
import 'package:provider/utils/call_back_notification.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/widgets/notificationDialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/connection_service/api/notification_api.dart';
import '../../models/notification/notification_model.dart';
import '../../models/notification/notifications_read_response.dart';
import '../../models/notification/notifications_response.dart';
import '../../utils/helper.dart';

class NotificationsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotificationsData();

  }


  @override
  void onReady() {
    super.onReady();
    if(Common.getUser() != null) {
      changeAlertController = StreamController<ListinAlertNotification>();
      changeAlertController.stream.listen((e) {
        page = 1;
        getNotificationsData();
      });
      changeOrderController = StreamController<ListinOrderNotification>();
      changeOrderController.stream.listen((e) {
        print(e.toString() + "notiiiiii orders");
        page = 1;
        getNotificationsData();
      });
      changeMessageController = StreamController<ListinMessageNotification>();
      changeMessageController.stream.listen((e) {
        page = 1;
        getNotificationsData();
      });

    }
  }

  var isLoading = false.obs ;
  Future getNotificationsData()async{
    if (page == 1) {
      isLoading = false.obs;
    } else {
      isLoadMore = true.obs;
    }
    update();
    return await Get.find<NotificationApi>().getNotificationsList(per_page: per_page, page: page)
      ..fold(onError, onSuccess);
  }
  onError(failure) async {
    isLoadMore = false.obs;
    if (page == 1) {
      isLoading = true.obs;
    }
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet != null && intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
        } else {

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
    int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }
  onSuccess(NotificationResponse data) async {
    isLoadMore = false.obs;
    if (page == 1) {
      isLoading = true.obs;
    }
    update();

    if (data != null) {
      if(data.data!.notificationCollection!=null)

        paginate = data.data!.notificationCollection!.pagination;
      if (page == 1) {
        if(data.data!.notificationCollection!.notifications != null)
          notifications = data.data!.notificationCollection!.notifications!;
        if (notifications
            .where((element) =>
        element.isRead == null || element.isRead == false)
            .length >
            0) {
          notificationsReadAll();
        }
      } else {
        notifications.addAll(data.data!.notificationCollection!.notifications!);
      }

    } else {}
    update();
    update();
  }
  // List<Orders>? ordersList = [];
  var paginationList;
  List<Notification>  notifications = [];


  Future notificationsReadAll() async {
    return await Get.find<NotificationApi>().notificationsReadAll()
      ..fold(onError, onSuccessCreate);
  }

  bool isUpdate = false;

  onSuccessCreate(RootResponse data) async {
    if (data.success  == true) {

      isUpdate = true;

    }

    update();
  }

  onErrorCreate(failure) async {
    update();
  }





  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
  int page =1 ;
  int per_page = 10;
  //loade more and refresh
  Rx<ScrollController> scrollController = new ScrollController().obs;
  Pagination? paginate = null;
  RxBool isLoadMore = false.obs;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch

    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    notifications = [];
    paginate = null;
    page = 1;
    getNotificationsData();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()


    if (!isLoadMore.value &&
        notifications!.length > 0 &&
        paginate != null &&
        paginate!.total! > notifications!.length) {
      if (!isLoadMore.value && !isLoadMore.value) {
        page++;
        getNotificationsData();
      }
      update();
    }
    refreshController.loadComplete();
  }
  onClickNotification(Notification item ,NotificationsController  controller) {
    print("item ref # "+ item.refType.toString());
    if (item.refType.toString() == "0") {
      // comment
      showGeneralDialog(
        context: (Get.context as BuildContext),
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
            backgroundColor: Colors.black12, body: NotificationDialog(item)),
      );
    }  else if (item.refType.toString() == "1") {
      //orderDetails
        goToOrderDetailsViewNotClose(item.refId!);
    } else if (item.refType.toString() == "2") {
      //Chat
      goToMassegeViewNotClose( item.refId! );
    }
  }

}