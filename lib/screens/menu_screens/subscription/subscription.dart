import 'package:flutter/services.dart';
import 'package:provider/core/theme/light_theme.dart';
import 'package:provider/screens/menu_screens/subscription/subscription_controller.dart';
import 'package:provider/screens/menu_screens/subscription_case/subscription_case.dart';
import 'package:provider/screens/pager/pager.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/helper.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/subscription_item.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
      init: SubscriptionController(),
      builder: (controller) =>  WillPopScope(
        onWillPop: () {
          if(controller.canSkip == true){
            Get.offAll(() => const Pager(selected: 0), transition: Transition.fade);

          }else{
            Get.back();
          }
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
              leading: CustomAppBar(context, onTapBack: () {
                if (controller.canSkip == true) {
                  Get.offAll(() => const Pager(selected: 0),
                      transition: Transition.fade);
                } else {
                  Get.back();
                }
              }),
              actions: [
                controller.canSkip == true
                    ? Container(
                        margin: EdgeInsetsDirectional.only(end: 16),
                        child: GestureDetector(
                          onTap: () {
                            Get.offAll(() => const Pager(selected: 0),
                                transition: Transition.fade);
                          },
                          child: Center(
                            child: Text(
                              "skip".tr,
                              style: TextStyle(
                                  color: Common.getDarkMode() ==true ? Colors.white54: Theme.of(context).dividerColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            body: controller.plansList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0.w, vertical: 10.h),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/Subscription.png",
                              height: 37.h,
                              width: 64.w,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomText(
                                text: 'Choose your plan'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    )),
                            SizedBox(
                              height: 16.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: CustomText(
                                text:
                                    'Pay only when you use the app, you can cancel this subscription'
                                        .tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        height: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            controller.subscription != null
                                ? Container()
                                : Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              controller.indexTaped = index;
                                            });
                                            controller.update();
                                          },
                                          child: SubscriptionItem(
                                              title: controller
                                                  .plansList[index].name,
                                              text1: controller
                                                  .plansList[index].features,
                                              pris: controller
                                                  .plansList[index].price
                                                  .toString(),
                                              text2: controller.plansList[index]
                                                  .features.length,
                                              select:
                                                  index == controller.indexTaped
                                                      ? true
                                                      : false),
                                        ),
                                        itemCount: controller.plansList.length,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 33.h,
                            ),
                            Common.getUser() != null &&
                                    Common.getUser()!.data != null &&
                                    Common.getUser()!.data!.provider != null &&
                                    Common.getUser()!
                                            .data!
                                            .provider!
                                            .subscriptionStatus ==
                                        true
                                ? Container()
                                : controller.subscription != null
                                    ? Container(
                                        child: SubscriptionItem(
                                            title: controller.subscription!.name,
                                            text1:
                                                controller.subscription!.features,
                                            pris: controller.subscription!.price
                                                .toString(),
                                            text2: controller
                                                .subscription!.features!.length,
                                            select: true),
                                      )
                                    : Container(
                                        //height: 47.h,
                                        width: 195.w,
                                        margin: EdgeInsets.only(bottom: 33),
                                        child: CustomButton(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                            color: Common.getDarkMode() ==true ? Colors.white:null ),
                                            onPressed: () {
                                              if (controller.indexTaped != null) {
                                                //  controller.openDialgPayment();
                                                controller.postSubscribe(
                                                    controller
                                                        .plansList[
                                                            controller.indexTaped]
                                                        .id);
                                              } else {
                                                Helper.ShowSnackbarFailureCenter(
                                                  title:
                                                      "You should select one of the plans"
                                                          .tr,
                                                  body:
                                                      'You should select one of the plans'
                                                          .tr,
                                                );
                                              }
                                            },
                                            text: "Confirm".tr),
                                      ),
                          ],
                        ),
                      ),
                      controller.subscription != null &&
                              controller.subscription!.status! == 0
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                //height: 47.h,
                                width: 195.w,
                                margin: EdgeInsets.only(bottom: 24),
                                child: CustomButton(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp ,color: Common.getDarkMode() ==true ? Colors.white:null ),
                                    onPressed: () {
                                      controller.openDialgPayment();
                                    },
                                    text: "Pay".tr),
                              ),
                            )
                          : Container()
                    ],
                  )),
      ),
    );
  }
}
