import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/models/menu/get_subscription_response.dart';
import 'package:provider/screens/pager/pager.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/formatters.dart';
import 'package:provider/widgets/custom_show_modal_bottom_sheet.dart';
import 'package:provider/widgets/custom_text.dart';

import '../../../core/connection_service/api/menu_api.dart';
import '../../../models/menu/plans_response.dart';
import '../../../models/menu/subscribe_response.dart';
import '../../../utils/helper.dart';
import '../../../utils/loading.dart';

class SubscriptionController extends GetxController {
  bool canSkip = false;

  var isLoading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null && Get.arguments[0] != null) {
      canSkip = Get.arguments[0];
    }
    if (Common.getUser() != null &&
        Common.getUser()!.data != null &&
        Common.getUser()!.data!.provider != null) {
      subscription = Common.getUser()!.data!.provider!.subscription;
      update();
    }
    getPlansData();
  }

  Future postSubscribe(id) async {
    Loading.show();

    update();
    return await Get.find<MenuApi>().subscribe(plan_id: id)
      ..fold(onError, onSuccess);
  }

  onError(failure) async {
    Loading.hide();
    isLoading = false.obs;
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet != null && intenet) {
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
    int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  Subscription? subscription;

  onSuccess(SubscribeResponse data) async {
    Loading.hide();
    isLoading = false.obs;
    update();

    await Future.delayed(Duration(seconds: 1));

    if (data != null) {
      subscription = data.data.subscription;
      if (canSkip == true) {
        await Common.setSubscription(true);
        openDialgPayment();
        // Get.offAll(() => const Pager(selected: 0), transition: Transition.fade);
      } else {
        await Common.setSubscription(true);
        print("iam heere");
        openDialgPayment();
        //Get.back(result: true);
      }
    } else {}
    update();
    update();
  }

  Future getPlansData() async {
    isLoading = true.obs;
    update();
    return await Get.find<MenuApi>().getPlansData()
      ..fold(onErrorPlans, onSuccessPlans);
  }

  onErrorPlans(failure) async {
    isLoading = false.obs;
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet != null && intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
        } else {
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

  List<Plan> plansList = [];

  onSuccessPlans(PlansResponse data) async {
    isLoading = false.obs;
    update();
    if (data != null) {
      plansList = data.data.plans;
    } else {}
    update();
    update();
  }

  openDialgPayment() {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: Get.context as BuildContext,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(Get.context as BuildContext)
                      .viewInsets
                      .bottom),
              child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(), child: payment(setState)),
            );
          });
        });
  }

  Future<void> onPay(context) async {
    if (FormKey.currentState!.validate()) {
      Get.back();
      pay(plansList[indexTaped].id);
      // Make a CardInfo from the controllers
      /** CardInfo card = CardInfo(
          holder: holderNameController.text,
          cardNumber: cardNumberController.text.replaceAll(' ', ''),
          cvv: cvvController.text,
          expiryMonth: expiryController.text.split('/')[0],
          expiryYear: '20' + expiryController.text.split('/')[1],
          );*/
    }
  }

  Future pay(id) async {
    Loading.show();

    update();
    return await Get.find<MenuApi>().pay(
        id: id.toString(),
        name: holderNameController.value.text.toString(),
        card: cardNumberController.value.text.toString().replaceAll(' ', ''),
        cvc: cvvController.value.text.toString(),
        year: "20" + expiryController.text.split('/')[1],
        month: expiryController.text.split('/')[0])
      ..fold(onErrorPay, onSuccessPay);
  }

  onErrorPay(failure) async {
    Loading.hide();
    isLoading = false.obs;
    update();
    await Future.delayed(Duration(seconds: 1));
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet != null && intenet) {
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
    int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  onSuccessPay(SubscribeResponse data) async {
    Loading.hide();
    isLoading = false.obs;
    update();

    await Future.delayed(Duration(seconds: 1));

    if (data != null && data.success == true) {
      if (canSkip == true) {
        await Common.setSubscription(true);
        Get.offAll(() => const Pager(selected: 0), transition: Transition.fade);
      } else {
        await Common.setSubscription(true);
        print("iam heere");
        Get.back(result: true);
        Helper.ShowSnackbarSuccess(
          title: "Success".tr,
          body: data.getMessageList(),
        );
      }
    } else {
      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: data.message.toString(),
      );
    }
    update();
  }

  int indexTaped = 0;

  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  TextEditingController holderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Widget payment(var setState) {
    var context = Get.context as BuildContext;

    return Form(
      autovalidateMode: autovalidateMode,
      key: FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: Get.width / 8,
              margin: EdgeInsets.only(bottom: 16),
              child: Divider(
                height: 3,
                thickness: 4,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: "Payment".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: "Complete your Payment Process".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            height: 3,
          ),
          const SizedBox(height: 10),
          // Number
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomText(
              text: "Card Number".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,

              decoration: _inputDecoration(
                //  label: "Card Number",
                hint: "0000 0000 0000 0000",
                icon: Icons.credit_card,
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "enter".tr + " " + "Card Number".tr + " " + "please".tr;
                } else {
                  if (val.replaceAll(' ', '').toString().length != 16) {
                    return "enter 16 Number".tr;
                  }
                }

                return null;
              },
              onChanged: (value) {},
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter()
              ],
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width / 2.5,
                  alignment: AlignmentDirectional.topStart,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Expiry date
                      Container(
                        width: Get.width / 2.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CustomText(
                            text: "Expiry Date".tr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: expiryController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          //   label: "Expiry Date",
                          hint: "MM/YY",
                          icon: Icons.date_range_rounded,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardMonthInputFormatter(),
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "enter".tr +
                                " " +
                                "Expiry Date".tr +
                                " " +
                                "please".tr;
                          } else {
                            return validateDate(val ?? "");
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width / 2.5,
                  alignment: AlignmentDirectional.topStart,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // CVV

                      Container(
                        width: Get.width / 2.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CustomText(
                            text: "CVV",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          // label: "CVV",
                          hint: "000",
                          icon: Icons.confirmation_number_rounded,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "enter".tr +
                                " " +
                                "CVV ".toString() +
                                " " +
                                "please".tr;
                          } else {
                            if (val.length < 3 || val.length > 4) {
                              return "CVV is invalid";
                            }
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const SizedBox(height: 30),
          SizedBox(
           width: double.infinity,
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                      return EdgeInsets.only(top: 12, bottom: 12,left: 24,right: 24);
                    },
                  ),
                ),
                onPressed: () {
                  onPay(context);
                },
                child: Text(
                  "Pay".tr,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

InputDecoration _inputDecoration({String? label, String? hint, dynamic icon}) {
  return InputDecoration(
    hintText: hint,
    labelText: label,
    filled: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(width: 0.2, color: Get.theme.primaryColorDark),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    fillColor: (Common.getDarkMode()
        ? Theme.of(Get.context as BuildContext)
            .primaryColorDark
            .withOpacity(0.05)
        : Colors.grey.shade100),
    prefixIcon: icon is IconData
        ? Icon(icon)
        : Container(
            padding: const EdgeInsets.all(6),
            width: 10,
            child: Image.asset(icon),
          ),
  );
}
