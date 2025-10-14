import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/screens/menu_screens/work_times/work_times_controller.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/work_times_item.dart';

import '../../../core/theme/light_theme.dart';
import '../../../utils/common.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_show_modal_bottom_sheet.dart';

class WorkTimes extends StatefulWidget {
  const WorkTimes({Key? key}) : super(key: key);

  @override
  State<WorkTimes> createState() => _WorkTimesState();
}

class _WorkTimesState extends State<WorkTimes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
            elevation: 0,
            leading: CustomAppBar(context)),
        body: GetBuilder<WorkTimeController>(
            init: WorkTimeController(),
            builder: (controller) => controller.isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => WorkTimesItem(
                      text:
                          "${controller.getKeyForValue(controller.schedules?[index].day)}",
                      from: "${controller.schedules?[index].startAt}",
                      to: "${controller.schedules?[index].endAt}",
                      onTap: () {
                        if (controller.indexTap == null) {
                          controller.indexTap = index;

                          controller.update();
                        } else {
                          controller.indexTap = null;
                          controller.update();
                        }
                      },
                      onTapImage: () {
                        controller.indexTap = index;
                        controller.update();

                        controller.formattedTime = controller
                            .schedules![controller.indexTap!].endAt
                            .toString()
                            .substring(0, 5)
                            .obs;

                        controller.formattedTimeTo = controller
                            .schedules![controller.indexTap!].startAt
                            .toString()
                            .substring(0, 5)
                            .obs;

                        controller.is_available = controller
                            .schedules![controller.indexTap!].isAvailable.obs;

                        controller.update();

                        buildShowModalBottomSheet(
                            context: context,
                            widget: Builder(
                                builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 51.w,
                                                child: const Divider(
                                                  thickness: 4,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              CustomText(
                                                  text: "Date And Time".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18.sp,
                                                      )),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              CustomText(
                                                  text: "Select date range".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.sp,
                                                      )),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                          text: "From".tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14.sp,
                                                                  )),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(13),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .scaffoldBackgroundColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            await controller
                                                                .selectTime(
                                                                    context,
                                                                    false,
                                                                    controller
                                                                        .schedules?[
                                                                            index]
                                                                        .endAt,
                                                                    setState);
                                                            print(controller
                                                                .formattedTimeTo);
                                                            controller.update();
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              CustomText(
                                                                  text:
                                                                      "${controller.formattedTimeTo}",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displayMedium
                                                                      ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: const Color(
                                                                            0xFF7D7D7D),
                                                                      )),
                                                              SizedBox(
                                                                width: 40.w,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .access_time_outlined,
                                                                color: Color(
                                                                    0xFF7D7D7D),
                                                                size: 18,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                          text: "To".tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16.sp,
                                                                  )),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await controller
                                                              .selectTime(
                                                                  context,
                                                                  true,
                                                                  controller
                                                                      .schedules?[
                                                                          index]
                                                                      .endAt,
                                                                  setState);
                                                          print(controller
                                                              .formattedTime);
                                                          controller.update();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(13),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .scaffoldBackgroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              CustomText(
                                                                  text:
                                                                      "${controller.formattedTime}  ",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displayMedium
                                                                      ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            12.sp,
                                                                        color: const Color(
                                                                            0xFF7D7D7D),
                                                                      )),
                                                              SizedBox(
                                                                width: 40.w,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .access_time_outlined,
                                                                color: Color(
                                                                    0xFF7D7D7D),
                                                                size: 18,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 20.h),
                                              Container(
                                                width: double.infinity,
                                                child: CustomText(
                                                    text: "is_available_work"
                                                        .tr
                                                        .split(" ")
                                                        .first
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14.sp,
                                                        )),
                                              ),
                                              SizedBox(height: 8.h),
                                              SizedBox(
                                                //height: 22.h,
                                                //width: 50.w,

                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(13),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      //  SizedBox(width: 24,),
                                                      Text("is_available_work"
                                                          .tr),
                                                      Spacer(),
                                                      FlutterSwitch(
                                                        value: controller
                                                            .is_available!
                                                            .value,
                                                        activeColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        inactiveTextColor:
                                                            secondTextColor,
                                                        inactiveColor:
                                                            secondTextColor
                                                                .withOpacity(
                                                                    0.2),
                                                        toggleSize: 20,
                                                        width: 45,
                                                        height: 22,
                                                        padding: 2,
                                                        duration: Duration(
                                                            milliseconds: 200),
                                                        onToggle: (bool value) {
                                                          setState(() {
                                                            controller
                                                                .is_available!
                                                                .value = value;
                                                            controller.update();
                                                          });
                                                        },
                                                      ),
                                                      //     SizedBox(width: 24,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 57.w),
                                                child: CustomButton(
                                                    onPressed: () {
                                                      Get.back();
                                                      controller
                                                          .updateTimeForDay();
                                                    },
                                                    text: "Submit".tr),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })));
                      },
                      isTapped:
                          controller.schedules![index].isAvailable == true ??
                              false,
                    ),
                    itemCount: controller.schedules?.length,
                  )));
  }
}
