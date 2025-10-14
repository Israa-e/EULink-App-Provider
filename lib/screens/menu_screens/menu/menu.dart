import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/screens/menu_screens/contact_us/contact_us.dart';
import 'package:provider/screens/menu_screens/setting/settings.dart';
import 'package:provider/screens/menu_screens/subscription/subscription.dart';
import 'package:provider/screens/menu_screens/work_times/work_times.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/custom_text_form_field.dart';
import 'package:provider/widgets/image_person.dart';
import 'package:provider/widgets/menu_item.dart';

import '../../../models/authentication/cities_response.dart';
import '../../../models/install/country_model.dart';
import '../../../widgets/menu_person.dart';
import '../../../widgets/settings_item.dart';
import '../setting/settings_controller.dart';
import '../subscription_case/subscription_case.dart';
import 'menu_controller.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List list = [
    "Membership",
    "Work times",
    "Choose services",
    "Contact Us",
    "Settings"
  ];
  List listImages = [
    "membership_icon",
    "Work_times_icon",
    "choose_services",
    "contact_us_icon",
    "settings_icon"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MenuScreenController>(
          init: MenuScreenController(),
          builder: (controller) => controller.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: controller.provider == null
                      ? Container(
                          height: Get.height,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 48,
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(controller.msgError.toString()),
                                Container(
                                  width: Get.width / 1.5,
                                  margin: EdgeInsets.only(top: 24),
                                  child: SettingsItem(
                                    text: "log_out".tr,
                                    h: 20.h,
                                    w: 20.h,
                                    image: "assets/icons/ic_log_out_new.svg",
                                    onTap: () {
                                      controller.LogOut();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            topRight: Radius.circular(25.r)),
                                      ),
                                      builder: (context) => Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Container(
                                              //height: Get.height / 2.5,
                                              child: Wrap(
                                                children: [
                                                  Container(
                                                    height: 20.h,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      width: 51.w,
                                                      child: const Divider(
                                                        thickness: 4,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    margin: EdgeInsets.only(
                                                        top: 16),
                                                    child: Column(
                                                      children: [
                                                        ImagePerson(
                                                          height: 60.h,
                                                          width: 60.h,
                                                          img: Common.getUser()!
                                                                      .data!
                                                                      .provider!
                                                                      .avatar ==
                                                                  confing
                                                                      .baseUrl
                                                              ? null
                                                              : Common.getUser()!
                                                                  .data!
                                                                  .provider!
                                                                  .avatar,
                                                        ),
                                                        Container(
                                                          height: 10.h,
                                                        ),
                                                        CustomText(
                                                            text: controller
                                                                        .user !=
                                                                    null
                                                                ? controller
                                                                    .user!.name
                                                                : "Visitor".tr,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall
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
                                                        Directionality(
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          child: CustomText(
                                                              text: Common.getUser()!
                                                                          .data!
                                                                          .provider!
                                                                          .country !=
                                                                      null
                                                                  ? Common.getUser()!
                                                                          .data!
                                                                          .provider!
                                                                          .country!
                                                                          .code
                                                                          .toString() +
                                                                      "  " +
                                                                      Common.getUser()!
                                                                          .data!
                                                                          .provider!
                                                                          .mobile
                                                                          .toString()
                                                                  : "",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayMedium
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12.sp,
                                                                  )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 10.h,
                                                  ),
                                                  Common.getUser() != null &&
                                                          Common.getUser()!
                                                                  .data !=
                                                              null &&
                                                          Common.getUser()!
                                                                  .data!
                                                                  .provider !=
                                                              null &&
                                                          Common.getUser()!
                                                                  .data!
                                                                  .provider!
                                                                  .subscriptionStatus ==
                                                              true
                                                      ? Center(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.r)),
                                                            child: CustomText(
                                                                text: Common.getUser()!
                                                                        .data!
                                                                        .provider!
                                                                        .subscription!
                                                                        .name
                                                                        .toString() +
                                                                    " ",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displayMedium
                                                                    ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        color: Theme.of(context)
                                                                            .primaryColor)),
                                                          ),
                                                        )
                                                      : Container(),
                                                  Container(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 77.w),
                                                    child: CustomButton(
                                                      onPressed: () {
                                                        Get.back();
                                                        showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .appBarTheme
                                                                .backgroundColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          25.r),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          25.r)),
                                                            ),
                                                            builder: (context) =>
                                                                StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                  return Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom: MediaQuery.of(context)
                                                                            .viewInsets
                                                                            .bottom),
                                                                    child:
                                                                        SizedBox(
                                                                      //   height: Get.height / 1.99,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 20.0),
                                                                        child:
                                                                            Wrap(
                                                                          children: [
                                                                            Container(
                                                                              height: 20,
                                                                            ),
                                                                            Center(
                                                                              child: Container(
                                                                                width: 51,
                                                                                child: Center(
                                                                                  child: Divider(
                                                                                    thickness: 4,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 20,
                                                                            ),
                                                                            Center(
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  controller.pickImage();
                                                                                },
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Container(
                                                                                      height: 70,
                                                                                      width: 70,
                                                                                      child: CircleAvatar(
                                                                                        radius: 50,
                                                                                        backgroundImage: controller.image != null
                                                                                            ? FileImage(controller.image!)
                                                                                            : NetworkImage(
                                                                                                Common.getUser()!.data!.provider!.avatar.toString() == confing.baseUrl ? 'https://img.freepik.com/premium-vector/male-avatar-icon-unknown-anonymous-person-default-avatar-profile-icon-social-media-user-business-man-man-profile-silhouette-isolated-white-background-vector-illustration_735449-122.jpg?w=740' : Common.getUser()!.data!.provider!.avatar.toString(),
                                                                                              ) as ImageProvider,
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                      top: 0,
                                                                                      left: 0,
                                                                                      child: Container(
                                                                                        height: 70,
                                                                                        width: 70,
                                                                                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), shape: BoxShape.circle),
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                      top: 25,
                                                                                      left: 25,
                                                                                      child: Image.asset(
                                                                                        "assets/images/edit.png",
                                                                                        width: 20,
                                                                                        height: 18,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 10.h,
                                                                              width: double.infinity,
                                                                            ),
                                                                            Center(
                                                                              child: CustomText(
                                                                                  text: "Choose Image".tr + " ",
                                                                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 12.sp,
                                                                                        decoration: TextDecoration.underline,
                                                                                      )),
                                                                            ),
                                                                            Container(
                                                                              height: 10.h,
                                                                            ),
                                                                            Form(
                                                                                key: controller.UpdateFormKey,
                                                                                child: Container(
                                                                                  height: Get.height / 2,
                                                                                  child: ListView(
                                                                                    shrinkWrap: true,
                                                                                    physics: ClampingScrollPhysics(),
                                                                                    children: [
                                                                                      CustomTextFormField(
                                                                                        validator: (value) {},
                                                                                        readOnly: controller.fullNameController.value.toString().isEmpty ? false : true,
                                                                                        controller: controller.fullNameController.value,
                                                                                        prefixIcon: false,
                                                                                        hint: "Full Name".tr,
                                                                                        text: "Full Name".tr,
                                                                                      ),
                                                                                      SizedBox(height: 10.h),
                                                                                      CustomTextFormField(controller: controller.hourlyRateController.value, prefixIcon: false, type: TextInputType.number, validator: (value) {}, hint: "\$ " + "Enter your hourly price".tr, text: "Hourly rate".tr),
                                                                                      SizedBox(height: 10.h),
                                                                                      CustomTextFormFieldNew(
                                                                                          controller: controller.cityController.value,
                                                                                          prefixIcon: false,
                                                                                          removeHeight: true,
                                                                                          hint: "Choose your city".tr,
                                                                                          validator: (value) {},
                                                                                          suffixIcon: InkWell(
                                                                                            onTap: () {
                                                                                              print(' controller.selectedCity.value ${controller.selectedCity.value}');
                                                                                              setState(() {});
                                                                                            },
                                                                                            child: Container(
                                                                                              margin: EdgeInsets.symmetric(horizontal: 15),
                                                                                              child: Theme(
                                                                                                data: new ThemeData(
                                                                                                    backgroundColor: Common.getDarkMode() != true ? Colors.white : Colors.black,
                                                                                                    canvasColor: Common.getDarkMode() != true ? Colors.white : Colors.black,
                                                                                                    primaryColor: Colors.black,
                                                                                                    //   accentColor: Colors.black,
                                                                                                    hintColor: Colors.black),
                                                                                                child: DropdownButtonHideUnderline(
                                                                                                  child: DropdownButtonFormField<City?>(
                                                                                                    isExpanded: true,
                                                                                                    decoration: InputDecoration(
                                                                                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                                                                                        enabledBorder: UnderlineInputBorder(
                                                                                                          borderSide: BorderSide(color: Colors.transparent),
                                                                                                        )),
                                                                                                    iconEnabledColor: null,
                                                                                                    iconDisabledColor: null,
                                                                                                    hint: CustomText(
                                                                                                      text: 'Choose your city'.tr,
                                                                                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                                                                            fontSize: 12,
                                                                                                          ),
                                                                                                    ),
                                                                                                    value: controller.selectedCity.value,
                                                                                                    onChanged: controller.onCityChanged,
                                                                                                    items: controller.Cities?.map((City? city) => DropdownMenuItem<City?>(value: city, child: CustomText(text: city?.name, style: TextStyle(color: Common.getDarkMode() == true ? Colors.white : Colors.black)))).toList(),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          text: "City".tr),
                                                                                      Container(
                                                                                        height: 15.h,
                                                                                      ),
                                                                                      Container(
                                                                                        margin: EdgeInsets.only(left: 0, right: 0, top: 8),
                                                                                        child: Column(
                                                                                          children: [
                                                                                            Container(
                                                                                              width: double.infinity,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16),
                                                                                                child: CustomText(
                                                                                                  text: "identity".tr,
                                                                                                  textAlign: TextAlign.start,
                                                                                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            CustomTextFielImage(
                                                                                              "identity",
                                                                                              hint: "add_file".tr,
                                                                                              isRequired: true,
                                                                                              editController: controller.idPathImageAvatar,
                                                                                              onTap: () {
                                                                                                controller.pickFileAvatar("image", "person", setState);
                                                                                              },
                                                                                              path: controller.pathImageAvatar.toString(),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        height: 15.h,
                                                                                      ),
                                                                                      CustomTextFormField(controller: controller.taxIDlController.value, removeHeight: true, prefixIcon: false, type: TextInputType.number, validator: (value) {}, hint: "Enter tax id".tr, text: "Tax ID(Optional)".tr),
                                                                                      Container(
                                                                                        height: 15.h,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                            Container(
                                                                              height: 10.h,
                                                                            ),
                                                                            Container(
                                                                                margin: const EdgeInsets.symmetric(horizontal: 90),
                                                                                child: CustomButton(
                                                                                    onPressed: () async {
                                                                                      if (controller.phoneNumberController.value.text.length > 6) {
                                                                                        String phone = controller.phoneNumberController.value.text;
                                                                                        controller.phoneNumberController.value.text = phone;
                                                                                      }
                                                                                      String name = controller.fullNameController.value.text;

                                                                                      if (controller.UpdateFormKey.currentState!.validate()) {
                                                                                        controller.updateUser();
                                                                                        // await   controller.SignUp();
                                                                                      }
                                                                                    },
                                                                                    text: "Save".tr)),
                                                                            Container(
                                                                              height: 16.h,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }));
                                                      },
                                                      text: "Edit Profile".tr,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                child: MenuPerson(
                                  img: controller.provider?.avatar.toString(),
                                  name: controller.provider?.name,
                                  hourRate: controller.provider?.hourlyRate,
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, cons) => ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () async {
                                            if (index == 0) {
                                              bool isUpdate = false;
                                              isUpdate = await Get.to(
                                                      () => Common.getUser() !=
                                                                  null &&
                                                              Common.getUser()!
                                                                      .data!
                                                                      .provider !=
                                                                  null &&
                                                              Common.getUser()!.data!.provider!.subscriptionStatus == true
                                                          ? SubscriptionCase()
                                                          : Subscription(),
                                                      transition: Transition.rightToLeft,
                                                      duration: const Duration(milliseconds: 300),
                                                      arguments: [false]) ??
                                                  false;

                                              print("isUpdate ## " +
                                                  isUpdate.toString());
                                              if (isUpdate == true) {
                                                controller.myUser();
                                              }
                                            } else if (index == 1) {
                                              Get.to(() => const WorkTimes(),
                                                  transition:
                                                      Transition.rightToLeft,
                                                  duration: const Duration(
                                                      milliseconds: 300));
                                            } else if (index == 2) {
                                              controller.goToService();
                                            } else if (index == 3) {
                                              Get.to(() => const Contactus(),
                                                  transition:
                                                      Transition.rightToLeft,
                                                  duration: const Duration(
                                                      milliseconds: 300));
                                            } else if (index == 4) {
                                              Get.to(
                                                  () => Settings(
                                                        controller:
                                                            SettingsController(),
                                                      ),
                                                  transition:
                                                      Transition.rightToLeft,
                                                  duration: const Duration(
                                                      milliseconds: 300));
                                            }
                                          },
                                          child: MenuItem(
                                            image: listImages[index],
                                            text: list[index],
                                            height: index == 0
                                                ? 14.h
                                                : index == 1
                                                    ? 19.95.h
                                                    : index == 2
                                                        ? 19.h
                                                        : index == 3
                                                            ? 19.h
                                                            : index == 4
                                                                ? 18.h
                                                                : 17.94.h,
                                            width: index == 0
                                                ? 22.w
                                                : index == 1
                                                    ? 15.h
                                                    : index == 2
                                                        ? 20.w
                                                        : index == 3
                                                            ? 17.w
                                                            : index == 4
                                                                ? 18.w
                                                                : 17.w,
                                          ),
                                        ),
                                    itemCount: list.length),
                              ),
                            )
                          ],
                        ),
                )),
    );
  }
}
