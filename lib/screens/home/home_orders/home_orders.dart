import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/home_order_item.dart';
import 'package:provider/widgets/refresh_view.dart';

import '../../../core/theme/dark_theme.dart';
import '../../../utils/common.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_show_modal_bottom_sheet.dart';
import '../chat/chat.dart';
import '../order_details/order_details.dart';
import 'home_orders_controller.dart';

class HomeOrders extends StatefulWidget {
  const HomeOrders({Key? key}) : super(key: key);

  @override
  State<HomeOrders> createState() => _HomeOrdersState();
}

class _HomeOrdersState extends State<HomeOrders> {
  Color? color = primaryColor.withOpacity(0.2);
  Color? color2;
  int id = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeOrdersController>(
            init: HomeOrdersController(),
            builder: (controller) => controller.isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                :  Padding(
              padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              color = Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2);
                              color2 = null;
                              id = 0;
                            });
                            controller.is_completed = 0;
                            controller.page = 1;
                            controller.update();
                            controller.getOrdersData();
                          },
                          child: Container(
                            width: Get.width/2.2,
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 25.w,
                            ),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: CustomTextAuto(
                                text: 'Current orders'.tr,
                                maxLine: 1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.5.sp,
                                  color: color != null
                                      ? Theme.of(context)
                                      .primaryColor
                                      : Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.color,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              color = null;
                              color2 = Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2);
                              id = 1;
                            });
                            controller.is_completed = 1;
                            controller.page = 1;
                            controller.update();
                            controller.getOrdersData();
                          },
                          child: Container(
                            width: Get.width/2.3,
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 25.w,
                            ),
                            decoration: BoxDecoration(
                              color: color2,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: CustomTextAuto(
                                text: 'Previous orders'.tr,
                                textAlign: TextAlign.center,
                                maxLine: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.5.sp,
                                  color: color2 != null
                                      ? Theme.of(context)
                                      .primaryColor
                                      : Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.color,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),



                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {

                          if(controller.fromformattedDate == null &&
                              controller.toformattedDate != null){
                            controller.toformattedDate = null;
                          }
                          if(controller.fromformattedDate != null &&
                              controller.toformattedDate == null){
                            controller.fromformattedDate = null;

                          }
                          buildShowModalBottomSheet(
                              context: context,
                              widget: Builder(
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState) {
                                      return SizedBox(
                                        // height: Get.height / 2.7,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              16.0),
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 51.w,
                                                child: const Divider(
                                                  thickness: 4,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              CustomText(
                                                  text:
                                                  "Filter Orders"
                                                      .tr,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                    fontWeight:
                                                    FontWeight
                                                        .w600,
                                                    fontSize:
                                                    18.sp,
                                                  )),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              CustomText(
                                                  text:
                                                  "Select date range to filter orders"
                                                      .tr,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .displayMedium
                                                      ?.copyWith(
                                                    fontWeight:
                                                    FontWeight
                                                        .w400,
                                                    fontSize:
                                                    14.sp,
                                                  )),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        CustomText(
                                                            text: "From"
                                                                .tr,
                                                            style: Theme.of(
                                                                context)
                                                                .textTheme
                                                                .displayLarge
                                                                ?.copyWith(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize:
                                                              14.sp,
                                                            )),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller.selectDate(
                                                                context,
                                                                true,
                                                                setState);
                                                          },
                                                          child:
                                                          Container(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                15),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Common.getDarkMode()
                                                                  ? primaryDarkColor.withOpacity(0.05)
                                                                  : inputPrimBackgroundColor,
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                            ),
                                                            child:
                                                            Row(
                                                              children: [
                                                                CustomText(
                                                                    text: controller.fromformattedDate != null ? controller.fromformattedDate!.value.toString() : "",
                                                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 14.sp,
                                                                    )),
                                                                SizedBox(
                                                                  width:
                                                                  10.w,
                                                                ),
                                                                const Icon(
                                                                  Icons.calendar_today,
                                                                  color:
                                                                  Color(0xFF7D7D7D),
                                                                  size:
                                                                  18,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        CustomText(
                                                            text: "To"
                                                                .tr,
                                                            style: Theme.of(
                                                                context)
                                                                .textTheme
                                                                .displayLarge
                                                                ?.copyWith(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize:
                                                              14.sp,
                                                            )),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller.selectDate(
                                                                context,
                                                                false,
                                                                setState);
                                                          },
                                                          child:
                                                          Container(
                                                            padding: EdgeInsets
                                                                .all(15
                                                                .w),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Common.getDarkMode()
                                                                  ? primaryDarkColor.withOpacity(0.05)
                                                                  : inputPrimBackgroundColor,
                                                              borderRadius:
                                                              BorderRadius.circular(8.r),
                                                            ),
                                                            child:
                                                            Row(
                                                              children: [
                                                                CustomText(
                                                                    text: controller.toformattedDate != null ? controller.toformattedDate!.value.toString() : "",
                                                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 14.sp,
                                                                    )),
                                                                SizedBox(
                                                                  width:
                                                                  10.w,
                                                                ),
                                                                const Icon(
                                                                  Icons.calendar_today,
                                                                  size:
                                                                  18,
                                                                  color:
                                                                  Color(0xFF7D7D7D),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 25.h),
                                              Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    60.w),
                                                child: CustomButton(
                                                  onPressed: () {
                                                    controller
                                                        .searchByFillter();
                                                  },
                                                  text:
                                                  "Submit Filter"
                                                      .tr,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                      fontSize:
                                                      18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )));





                        },
                        child: Container(
                          width: 82.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: controller.fromformattedDate != null &&
                                controller.toformattedDate != null
                                ? Colors.redAccent
                                : Color(0xFFADB5BD).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/filter_icon.svg",
                                height: 11.h,
                                width: 13.w,
                                color: controller.fromformattedDate !=
                                    null &&
                                    controller.toformattedDate != null
                                    ? Colors.white
                                    : null,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              CustomText(
                                text: "Filter".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                  color: Common.getDarkMode()
                                      ? secondTextColor
                                      : controller.fromformattedDate !=
                                      null &&
                                      controller
                                          .toformattedDate !=
                                          null
                                      ? Colors.white
                                      : const Color(0xFFADB5BD),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      controller.fromformattedDate != null &&
                          controller.toformattedDate != null
                          ? GestureDetector(
                        onTap: () {
                          controller.clearFillter();
                        },
                        child: Container(
                          height: 21,
                          width: 21,
                          margin:
                          EdgeInsets.symmetric(horizontal: 8),
                          child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 11,
                              )),
                        ),
                      )
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),


                  controller.msgCurrentLocationPref != null &&
                      controller.msgCurrentLocationPref.isNotEmpty
                      ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 0, right: 0, top: 16),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),

                          border: Border.all(
                            width: 0.3,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_disabled,
                            color: Get.theme.primaryColor,
                            size: 32,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width - 100,
                                child: Text("" +
                                    controller.msgCurrentLocationPref
                                        .toString()),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.handleLocationPermissionTap();
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2),
                                      shape: BoxShape.rectangle),
                                  child: Text(
                                    "retry".tr,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                      : Container(),

                  controller.ordersList.isEmpty
                      ? Expanded(
                        child: Container(
                    margin: EdgeInsets.only(top: Get.height / 7),
                    child: Center(
                        child: Lottie.asset(
                          Common.getDarkMode() == true
                              ? 'assets/json/cart_empty_dark.json'
                              : 'assets/json/cart_empty.json',
                          repeat: false,
                        ),
                    ),
                  ),
                      )
                      : Expanded(
                        child: LayoutBuilder(
                    builder: (context, index) => RefreshView(
                        onLoading: controller.onLoading,
                        onRefresh: controller.onRefresh,
                        isLoadMore: controller.isLoadMore,
                        refreshController:
                        controller.refreshController,
                        enablePullDown: true,
                        enablePullUp: controller.paginate != null &&
                            controller.paginate!.total! >
                                controller.ordersList.length
                            ? true
                            : false,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              GestureDetector(
                                onTap: () async {
                                  bool isUpdate = false;
                                  isUpdate = await Get.to(
                                          () => OrderDetails(
                                        index: controller
                                            .ordersList[index]
                                            .id,
                                        UserId: controller
                                            .ordersList[index]
                                            .userId,
                                      ),
                                      transition:
                                      Transition.rightToLeft,
                                      arguments: [controller
                                          .ordersList[index]
                                          .id, true],
                                      duration: const Duration(
                                          milliseconds: 300)) ??
                                      false;
                                  if (isUpdate == true) {
                                    controller.getOrdersData();
                                  }
                                },
                                child: HomeOrderItem(
                                  text:
                                  '${controller.getKeyForValue(controller.ordersList[index].status)}',
                                  status: controller
                                      .ordersList[index].status,
                                  color: const Color(0xFF44B75D),
                                  serviceName:
                                  '${controller.ordersList[index].user!.name.toString()}',
                                  address:
                                  '${controller.ordersList[index].address}',
                                  date:
                                  controller.ordersList[index].date,
                                  timeString:
                                  controller.ordersList[index].time,
                                ),
                              ),
                          itemCount: controller.ordersList.length,
                        ),
                    ),
                  ),
                      ),
                ],
              ),
            )),
      ),
    );
  }
}
