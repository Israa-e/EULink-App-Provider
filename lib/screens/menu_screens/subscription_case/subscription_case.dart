import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/screens/menu_screens/subscription/subscription.dart';
import 'package:provider/screens/menu_screens/subscription_case/subscription_case_controller.dart';
import 'package:provider/screens/pager/pager.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:provider/widgets/custom_text.dart';

import '../../../utils/common.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/dot_widget.dart';

class SubscriptionCase extends StatefulWidget {
  const SubscriptionCase({Key? key}) : super(key: key);

  @override
  State<SubscriptionCase> createState() => _SubscriptionCaseState();
}

class _SubscriptionCaseState extends State<SubscriptionCase> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionCaseController>(
        init: SubscriptionCaseController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () {
              if (controller.canSkip == true) {
                Get.offAll(() => const Pager(selected: 0),
                    transition: Transition.fade);
              } else {
                Get.back();
              }
              return Future.value(false);
            },
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
                    elevation: 0,
                    leading: CustomAppBar(context)),
                body: controller.isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.subscription != null
                        ? Stack(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0.w),
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Center(
                                      child: CustomText(
                                          text: "Current orders"
                                                  .tr
                                                  .toString()
                                                  .split(" ")
                                                  .first
                                                  .toString() +
                                              " " +
                                              "Subscription".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                              )),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Center(
                                      child: CustomText(
                                          text:
                                              " ${controller.subscription?.name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22.sp,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => Subscription(),
                                            transition: Transition.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            arguments: [false]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                                text: "See All Plans".tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.sp,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium
                                                            ?.color
                                                            ?.withOpacity(
                                                                0.5))),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.color
                                                  ?.withOpacity(0.5),
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).cardTheme.color,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                offset: const Offset(0, 0),
                                                blurRadius: 10)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              text: "Remaining Orders".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.sp,
                                                  )),
                                          CustomText(
                                              text:
                                                  "${controller.subscription?.balance}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.sp,
                                                  )),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).cardTheme.color,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                offset: const Offset(0, 0),
                                                blurRadius: 10)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              text: controller.subscription !=
                                                          null &&
                                                      controller.subscription!
                                                              .status! ==
                                                          0
                                                  ? "Draft Subscription".tr
                                                  : controller.subscription !=
                                                              null &&
                                                          controller
                                                                  .subscription!
                                                                  .status! ==
                                                              3
                                                      ? "Expired".tr
                                                      : "Until".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                  )),
                                          controller.subscription != null &&
                                                  (controller.subscription!
                                                          .status! !=
                                                      1)
                                              ? Container()
                                              : CustomText(
                                                  text:
                                                      " ${controller.formattedDate}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 12.sp,
                                                      )),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              if (controller.subscription !=
                                                  null)
                                                controller
                                                    .cancelSubscriptionsWebService(
                                                        controller
                                                            .subscription!.id);
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFBD0F0F)
                                                            .withOpacity(0.05),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                width: 63.w,
                                                height: 30.h,
                                                child: Center(
                                                    child: CustomText(
                                                        text: "Cancel".tr,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 10.sp,
                                                                color: const Color(
                                                                    0xFFBD0F0F))))),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).cardTheme.color,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                offset: const Offset(0, 0),
                                                blurRadius: 10)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              text: "Features".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12.sp,
                                                  )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: Get.height / 3,
                                            child: ListView.separated(
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return DotWidget(
                                                    widget: CustomText(
                                                        text: controller
                                                                .subscription!
                                                                .plan!
                                                                .features![index]
                                                                .toString() +
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium
                                                            ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 11.sp,
                                                            )),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                    height: 10.h,
                                                  );
                                                },
                                                itemCount: controller
                                                            .subscription!
                                                            .plan !=
                                                        null
                                                    ? controller.subscription!
                                                        .plan!.features!.length
                                                    : 0),
                                          ),
                                        ],
                                      ),
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
                                                    fontSize: 14.sp),
                                            onPressed: () {
                                              controller.openDialgPayment();
                                            },
                                            text: "Pay".tr),
                                      ),
                                    )
                                  : Container(),
                              controller.subscription != null &&
                                      controller.subscription!.status! == 3
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
                                                    fontSize: 14.sp),
                                            onPressed: () {
                                              controller.reNewPay();
                                            },
                                            text: "Re-New".tr),
                                      ),
                                    )
                                  : Container()
                            ],
                          )
                        : Container(
                  height: Get.height/2,
                            child: Center(
                              child: Icon(
                                Icons.error_outline,
                                size: 128,
                              ),
                            ),
                          )),
          );
        });
  }
}
