import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/utils/preferences_select_time.dart';
import 'package:provider/widgets/custom_show_modal_bottom_sheet.dart';

import '../../../core/connection_service/api/menu_api.dart';
import '../../../models/menu/show_schedules_response.dart';
import '../../../models/menu/update_schedules_response.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';

class WorkTimeController extends GetxController {
  var timeOfDay = TimeOfDay(hour: 10, minute: 00).obs;
  var hours;
  var isLoading;
  var minute;
  int? indexTap;
  RxString? formattedTime;
  RxString? formattedTimeTo;
  RxBool? is_available = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ShowSchedulesData();
  }

  var newTime;

  pickTimeHours(
    context,
  ) async {
    newTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay.value,
    );
    if (newTime == null) return;
    timeOfDay.value = newTime;

    update();
    return newTime;
  }

  Future selectTime(
      BuildContext context, bool isFrom, selectedTime, state) async {
    TimeOfDay time =
        TimeOfDay.fromDateTime(DateTime.parse("2023-01-01 " + selectedTime));
    // Get.to(PreferencesSelectTime("",time,(v){}));

    buildShowModalBottomSheetWhite(

        context: context,
        widget: Builder(
            builder: (context) => StatefulBuilder(builder: (context, setState) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        height: Get.height / 4,
                        child: PreferencesSelectTime(
                            (isFrom == true ? formattedTime.toString() : formattedTimeTo.toString()), time, (v) {
                          time = v;
                          update();
                          time =
                              TimeOfDay(hour: time.hour, minute: time.minute);

                          if (isFrom == true) {
                            formattedTime = ((time.hour > 9
                                        ? time.hour.toString()
                                        : "0" + time.hour.toString()) +
                                    ":" +
                                    (time.minute > 9
                                        ? time.minute.toString()
                                        : "0" + time.minute.toString()))
                                .obs;
                          } else {
                            formattedTimeTo = ((time.hour > 9
                                        ? time.hour.toString()
                                        : "0" + time.hour.toString()) +
                                    ":" +
                                    (time.minute > 9
                                        ? time.minute.toString()
                                        : "0" + time.minute.toString()))
                                .obs;
                          }
                          if (isFrom == true) {
                            formattedTime = DateFormat('HH:mm ')
                                .format(DateTime(
                                  2021,
                                  1,
                                  1,
                                  time.hour,
                                  time.minute,
                                ))
                                .obs;
                          } else {
                            formattedTimeTo = DateFormat('HH:mm ')
                                .format(DateTime(
                                  2021,
                                  1,
                                  1,
                                  time.hour,
                                  time.minute,
                                ))
                                .obs;
                          }

                          state(() {});
                          update();
                        })),
                  );
                })));

    /**
        final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: time,
        );
        if (newTime != null) {
        time = newTime;
        time = TimeOfDay(hour: time.hour, minute: time.minute);

        if(isFrom ==true){

        formattedTime = ((time.hour > 9
        ? time.hour.toString()
        : "0" + time.hour.toString()) +
        ":" +
        (time.minute > 9
        ? time.minute.toString()
        : "0" + time.minute.toString())).obs;
        }else {
        formattedTimeTo  = ((time.hour > 9
        ? time.hour.toString()
        : "0" + time.hour.toString()) +
        ":" +
        (time.minute > 9
        ? time.minute.toString()
        : "0" + time.minute.toString())).obs;
        }
        update();
        }

        /**  if(isFrom ==true){

        formattedTime = DateFormat('hh:mm a').format(
        DateTime(
        2021,
        1,
        1,
        time.hour,
        time.minute,
        )
        ).obs ;
        }else{

        formattedTimeTo = DateFormat('hh:mm a').format(
        DateTime(
        2021,
        1,
        1,
        time.hour,
        time.minute,
        )
        ).obs ;
        }*/

        setState((){});
        return   DateFormat('hh:mm a').format(
        DateTime(
        2021,
        1,
        1,
        time.hour,
        time.minute,
        )
        );
     */
  }

  Future<void> updateTimeForDay() async {
    int id = schedules![indexTap!].id;
    String from = formattedTime!.value.toString();
    String to = formattedTimeTo!.value.toString();

    update();
    await Get.find<MenuApi>().updateSchedules(
      start_at: to.toString(),
      end_at: from.toString(),
      is_available: is_available!.value,
      id: id,
    )
      ..fold(onErrorSchedulesUpdate, onSuccessSchedulesUpdate);
  }

  Future ShowSchedulesData() async {
    isLoading = true.obs;
    print("Hi ::::::::");
    update();
    return await Get.find<MenuApi>().showSchedulesData()
      ..fold(onErrorSchedules, onSuccessSchedules);
  }

  onErrorSchedules(failure) async {
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

  List<ProviderSchedule>? schedules;

  onSuccessSchedules(ShowSchedulesResponse data) async {
    isLoading = false.obs;

    print(Common.getUser()?.data!.login!.accessToken);
    update();
    if (data.success != false) {
      schedules = data.data.providerSchedule;
    } else {}
    update();
    update();
  }

  Future UpdateSchedulesData() async {
    update();
  }

  onErrorSchedulesUpdate(failure) async {
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

  var schedule;

  onSuccessSchedulesUpdate(UpdateSchedulesResponse data) async {
    update();
    if (data.success != false) {
      schedule = data.data.schedule;
      ShowSchedulesData();
    } else {}
    update();
    update();
  }

  String? getKeyForValue(int? value) {
    Map<String, dynamic>? map = Common.getSplash()?.data.enums.dayEnum.toJson();
    for (String key in map!.keys) {
      if (map[key] == value) {
        return key.tr;
      }
    }
    return null; // Value not found in map
  }
}
