import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/screens/home/chat/chat.dart';
import 'package:provider/screens/pager/pager.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/utils/helper.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:provider/widgets/custom_show_modal_bottom_sheet.dart';
import 'package:provider/widgets/custom_text.dart';

import '../../../utils/common.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_bottom_sheets_content.dart';
import '../../../widgets/image_person.dart';
import 'order_details_controller.dart';

class OrderDetails extends StatelessWidget {
  final int? index;
  final int? UserId;

  const OrderDetails({Key? key, required this.index, required this.UserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(id: index),
      builder: (controller) => WillPopScope(
        onWillPop: () {
          if (controller.canBack == true) {
            Get.back(result : controller.isUpdate);
          } else {
            Get.offAll(Pager(
              selected: 0,
            ));
          }
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
            leading: CustomAppBar(context, onTapBack: () {
              // Get.back(result: controller.isUpdate);

              if (controller.canBack == true) {
                Get.back(result: controller.isUpdate);
              } else {
                Get.offAll(Pager(
                  selected: 0,
                ));
              }
            }),
            actions: [
              if (controller.orderList != null &&
                  controller.orderList!.status != null &&
                  (controller.orderList!.status.toString() == "2" ||
                      controller.orderList!.status.toString() == "5" // ||
                 //     controller.orderList!.status.toString() == "6" ||
                   //   controller.orderList!.status.toString() == "7"
                  ))
                Container(
                    padding: const EdgeInsets.only(
                        top: 9, left: 11, right: 12, bottom: 8.75),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => Chat(),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            arguments: [controller.orderList, true]);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/chat_icon.svg",
                        color: Common.getDarkMode()
                            ? Theme.of(context).textTheme.headlineMedium?.color
                            : Theme.of(context).textTheme.displayMedium?.color,
                      ),
                    )),
            ],
          ),
          body: controller.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : WillPopScope(
                  onWillPop: () {
                    Get.back(result: controller.isUpdate);
                    return Future.value(false);
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: Get.height / 8.4,
                            width: Get.width / 2.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                '${controller.orderList?.service!.image}',
                                height: 72.63.h,
                                width: 58.67.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomText(
                              text: "${controller.orderList?.service!.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  )),
                          SizedBox(
                            height: 10.h,
                          ),
                          viewStatusOrder(controller.orderList!.status!, 0),
                          /**
                            Container(
                            margin: const EdgeInsets.only(right: 15),
                            padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                            color: const Color(0xFF44B75D).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                            ),
                            child: CustomText(
                            text:
                            "${controller.getKeyForValue(controller.orderList?.status)}",
                            style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: const Color(0xFF44B75D),
                            )),
                            ),*/
                          SizedBox(
                            height: 15.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("hhh");
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.r),
                                        topRight: Radius.circular(25.r))),
                                builder: (context) => orderDetailBottomSheets(
                                    context: context,
                                    name: '${controller.orderList?.user!.name}',
                                    mobile:
                                    controller.orderList!.user!.country!=null ?   controller.orderList!.user!.country!.code.toString()+ " "
                                             + controller.orderList!.user!.mobile.toString() :
                                    controller.orderList!.user!.mobile.toString()  ,
                                    address: '${controller.orderList?.address}',
                                    img: (controller.orderList?.user!.avatar
                                                .toString()) ==
                                            confing.baseUrl
                                        ? null
                                        : '${controller.orderList?.user!.avatar.toString()}'),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 23, vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardTheme.color,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: "Customer".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                          )),
                                  Spacer(),
                                  Row(
                                    children: [
                                      ImagePerson(
                                          height: 25.h,
                                          width: 25.h,
                                          img: (controller
                                                      .orderList!.user!.avatar
                                                      .toString()) ==
                                                  confing.baseUrl
                                              ? null
                                              : '${controller.orderList!.user!.avatar.toString()}'),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Container(
                                        constraints: BoxConstraints(minWidth: 20, maxWidth: Get.width/2.4  ,),
                                        child: CustomText(
                                            text:
                                                '${controller.orderList!.user!.name.toString()}',
                                            maxLine: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.2.sp,
                                                )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 23, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardTheme.color,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: "Location".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                            )),
                                   GestureDetector (
                                     onTap: (){
                                       controller.GoToMap(controller.orderList!.address.toString() ,
                                       double.tryParse(controller.orderList!.latitude.toString())??0 ,
                                           double.tryParse(controller.orderList!.longitude.toString())??0
                                       );
                                     },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 28,
                                              width: 28,
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(0),
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.grey ,
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(4),
                                                    child: Image.asset("assets/images/map_directions.png")),
                                              ),
                                            ),
                                            Container(
                                              height: 28,
                                              width: 28,
                                              margin: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(0),
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.grey ,
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(4),
                                                    child: Image.asset("assets/images/map_google.jpeg")),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_sharp,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: CustomText(
                                            text:
                                                "${controller.orderList?.address}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 9.sp,
                                                )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "Date&Time".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: CustomText(
                                            text: "${controller.formattedDate}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    const Icon(
                                      Icons.access_time_rounded,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: CustomText(
                                          text:
                                              "${DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse('${controller.orderList?.time ?? '00:00:00'}'))}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                              )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // controller.orderList!.status! == 0  ||

                          controller.orderList!.status! == 1
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 35.0),
                                      child: CustomButton(
                                        onPressed: () async {
                                          controller.acceptOrder();
                                          /**controller.UpdateOrderData(
                                      id: index,
                                      status: Common.getSplash()
                                      ?.data
                                      .enums
                                      .orderStatusEnum
                                      .approved);*/
                                        },
                                        text: "Accept order"
                                            .tr
                                            .toString()
                                            .toUpperCase(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        //  Get.back();
                                        /**   controller.UpdateOrderData(
                                    id: index,
                                    status: Common.getSplash()
                                    ?.data
                                    .enums
                                    .orderStatusEnum
                                    .rejected);*/
                                        controller.rejectOrder();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: CustomText(
                                            text: "Reject order"
                                                .tr
                                                .toString()
                                                .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium
                                                        ?.color
                                                        ?.withOpacity(0.5))),
                                      ),
                                    ),
                                  ],
                                )
                              : controller.orderList?.status == 2
                                  ? Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 35.0, vertical: 24),
                                        child: CustomButton(
                                          onPressed: () async {
                                             controller.InProgressOrder();
                                           /** controller.UpdateOrderData(
                                                id: index,
                                                status: Common.getSplash()
                                                    ?.data
                                                    .enums
                                                    .orderStatusEnum
                                                    .inProgress);
                                          */
                                          },
                                          text: "In Progress"
                                              .tr
                                              .toString()
                                              .toUpperCase(),
                                        ),
                                      ),
                                    )
                                  : controller.orderList?.status == 5
                                      ? Container(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 35.0, vertical: 24),
                                            child: CustomButton(
                                              onPressed: () async {
                                                controller.CompletedOrder();
                                                /**
                                                controller.UpdateOrderData(
                                                    id: index,
                                                    status: Common.getSplash()
                                                        ?.data
                                                        .enums
                                                        .orderStatusEnum
                                                        .completed);*/
                                              },
                                              text: "Completed"
                                                  .tr
                                                  .toString()
                                                  .toUpperCase(),
                                            ),
                                          ),
                                        )
                                      : controller.orderList!.status! == 0
                                          ? Container()
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                          blurRadius: 5,
                                                          offset: const Offset(
                                                              0, 0),
                                                        )
                                                      ],
                                                      color: Theme.of(context)
                                                          .cardTheme
                                                          .color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                          text: "Rating".tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayLarge
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12.sp,
                                                                  )),
                                                      controller.orderList!
                                                                  .rate !=
                                                              null
                                                          ? Row(
                                                              children: [
                                                                Row(
                                                                  children: List<
                                                                          Widget>.generate(
                                                                      int.tryParse(controller
                                                                              .orderList!
                                                                              .rate
                                                                              .toString()) ??
                                                                          0,
                                                                      (index) =>
                                                                          Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                Theme.of(context).primaryColor,
                                                                          )),
                                                                ),
                                                                Row(
                                                                  children: List<
                                                                          Widget>.generate(
                                                                      5 -
                                                                          (int.tryParse(controller.orderList!.rate.toString()) ??
                                                                              0),
                                                                      (index) =>
                                                                          Icon(
                                                                            Icons.star_rounded,
                                                                            color:
                                                                                const Color(0xFFD6DADE),
                                                                          )),
                                                                ),
                                                              ],
                                                            )
                                                          : Text(
                                                              "There is no rating"
                                                                  .tr)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),


                          controller.orderList!.status! == 5    ?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: CustomButtonNew(
                              onPressed: () {
                                // controller.UpdateOrderData(status:Common.getSplash()!.data.enums.orderStatusEnum.caseIssue);
                                controller.caseIssueOrder();

                              },
                              backgroundColor: Colors.redAccent,
                              text: "CaseIssue".tr.toString().toUpperCase(),
                            ),
                          )
                              :Container(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
