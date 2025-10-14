import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/widgets/app_loader_widget.dart';
import 'package:provider/widgets/refresh_view.dart';

import '../../widgets/notifications_item.dart';
import 'notifications_controller.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
        init: NotificationsController(),
    builder: (controller) {
    return Scaffold(
        body:SafeArea(
          child: controller.isLoading == false ?

          AppLoaderWidget()
              :  Container(
            margin: EdgeInsets.only(top: 24),
                child: RefreshView(
            onLoading: controller.onLoading,
            onRefresh: controller.onRefresh,
            isLoadMore: controller.isLoadMore,
            refreshController: controller.refreshController,
            enablePullDown: true,
            enablePullUp: controller.paginate != null &&
                  controller.paginate!.total! >
                      controller.notifications.length
                  ? true
                  : false,
            child:controller.notifications.length > 0
                  ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return NotificationsItem(
                      controller.notifications[index], () {
                    controller.onClickNotification(
                        controller.notifications[index],
                        controller);
                  });
                },
            ): Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                        child: Lottie.asset(
                          'assets/json/no_notifications.json',
                        ),
                        height: Get.height / 2,
                      )),
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                      child: Text(
                        "empty_notifications".tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
            ),
          ),
              ) ,
        ),
      );
    }
    );
  }
}
