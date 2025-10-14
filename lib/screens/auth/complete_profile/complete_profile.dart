import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/models/authentication/cities_response.dart';
import 'package:provider/screens/auth/choose_service/choose_service.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/widgets/custom_appbar.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/custom_text_form_field.dart';
import 'package:provider/widgets/image_person.dart';

import '../../../core/theme/light_theme.dart';
import 'complete_profile_controller.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  Color color1 = Color(0xffb3b3b3);
  Color color2 = primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompleteProfileController>(
          init: CompleteProfileController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                elevation: 0,
                systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                actions: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const ChooseService(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                          arguments: ["add"]);
                    },
                    child: Container(
                      // color: Colors.red,
                      margin: const EdgeInsets.only(top: 20, right: 25),
                      padding: EdgeInsets.all(10),
                      child: Center(
                          child: CustomText(
                        text: 'Skip'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                      )),
                    ),
                  ),
                ],
                leading: CustomAppBar(context,onTapBack: (){
                  exit(0);
                }),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      CustomText(
                        text: "Complete Profile".tr,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Common.getDarkMode()
                                    ? primaryLightColor
                                    : Theme.of(context).iconTheme.color),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomText(
                        text: "Complete your profile information",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                color: Common.getDarkMode()
                                    ? Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.color
                                    : Theme.of(context).iconTheme.color),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.outer,
                                  offset: const Offset(0, 0))
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(controller.image !=
                                                null ||
                                            (controller.provider != null &&
                                                controller.provider!.avatar !=
                                                    null)
                                        ? 8
                                        : 28),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color2.withOpacity(0.1),
                                        border: Border.all(
                                          color: controller.isAddImage == false
                                              ? Colors.red
                                              : Colors.transparent,
                                        )),
                                    child: Center(
                                      heightFactor: 1.0,
                                      widthFactor: 1.0,
                                      child: controller.image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                              child: Image.file(
                                                controller.image!,
                                                height: 48.h,
                                                width: 48.h,
                                                fit: BoxFit.cover,
                                              ))
                                          : controller.provider != null &&
                                                  controller.provider!.avatar !=
                                                      null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360),
                                                  child: ImagePerson(
                                                      height: 48.h,
                                                      width: 48.h,
                                                      img: (controller.provider!
                                                                  .avatar
                                                                  .toString()) ==
                                                              confing.baseUrl
                                                          ? null
                                                          : '${controller.provider!.avatar.toString()}'),
                                                )
                                              : SvgPicture.asset(
                                                  "assets/icons/camera_icon.svg",
                                                  height: 20.h,
                                                  width: 23.w,
                                                ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                CustomText(
                                  text: "Choose profile picture".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        fontSize: 12.sp,
                                      ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Theme.of(context).cardTheme.color,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10.r,
                                blurStyle: BlurStyle.outer,
                                offset: const Offset(0, 0))
                          ],
                        ),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        color1 = primaryColor;
                                        color2 = Color(0xffb3b3b3);
                                        log("person");
                                        controller.type = 0.obs;
                                        log("${controller.type}");
                                      });
                                    },
                                    child: Container(
                                      height: 64.h,
                                      width: 133.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: color1.withOpacity(0.2),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: color1.withOpacity(0.5),
                                          ),
                                          CustomText(
                                            text: "Personal".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp,
                                                  color: color1,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        color2 = primaryColor;
                                        color1 = Color(0xffb3b3b3);
                                        log("Business");
                                        controller.type = 1.obs;
                                        print(controller.type);
                                      });
                                    },
                                    child: Container(
                                      height: 64.h,
                                      width: 133.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: color2.withOpacity(0.1)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/business_icon.svg",
                                            color: color2,
                                          ),
                                          CustomText(
                                            text: "Business".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp,
                                                  color: color2,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomTextFormFieldNew(
                                  controller:
                                      controller.hourlyRateController.value,
                                  removeHeight: true,
                                  prefixIcon: false,
                                  type: TextInputType.number,
                                  validator: (value) {},
                                  hint: "\$ " + "Enter your hourly price".tr,
                                  text: "Hourly rate".tr),
                              SizedBox(
                                height: 15.h,
                              ),

                              CustomTextFormFieldNew(
                                  controller: controller.cityController.value,
                                  prefixIcon: false,
                                  removeHeight: true,
                                  hint: "Choose your city".tr,
                                  validator: (value) {},
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      print(
                                          ' controller.selectedCity.value ${controller.selectedCity.value}');
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Theme(
                                        data: new ThemeData(
                                            backgroundColor: Common.getDarkMode() !=true ?  Colors.white :
                                            Colors.black ,
                                            canvasColor:Common.getDarkMode() !=true ?  Colors.white :
                                            Colors.black ,
                                            primaryColor: Colors.black,
                                          //  accentColor: Colors.black,
                                            hintColor: Colors.black),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField<City?>(

                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.transparent)),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.transparent),)),
                                            iconDisabledColor: null,
                                            hint: CustomText(
                                              text: 'Choose your city'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                    fontSize: 12,
                                                  ),
                                            ),
                                            value: controller.selectedCity.value,
                                            onChanged: controller.onCityChanged,


                                            items: controller.Cities?.map(
                                                    (City? city) =>
                                                        DropdownMenuItem<City?>(
                                                            value: city,
                                                            child: CustomText(
                                                                text: city?.name,
                                                                style: TextStyle(
                                                                    color:Common.getDarkMode() ==true ? Colors.white:  Colors
                                                                        .black))))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  text: "City".tr),
                              SizedBox(
                                height: 15.h,
                              ),

                              Container(
                                margin:
                                    EdgeInsets.only(left: 0, right: 0, top: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, bottom: 16),
                                        child: CustomText(
                                          text: "identity".tr,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    CustomTextFielImage(
                                      "identity",
                                      hint: "add_file".tr,
                                      isRequired: true,
                                      editController:
                                          controller.idPathImageAvatar,
                                      onTap: () {
                                        controller.pickFileAvatar(
                                            "image", "person");
                                      },
                                      path:
                                          controller.pathImageAvatar.toString(),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 15.h,
                              ),

                              CustomTextFormField(
                                  controller: controller.taxIDlController.value,
                                  removeHeight: true,
                                  prefixIcon: false,
                                  validator: (value) {},
                                  type: TextInputType.number,
                                  hint: "Enter tax id".tr,
                                  text: "Tax ID(Optional)".tr),
                              //Todo :: make rich text
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: CustomButton(
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.updateProvider();
                                print("validate");
                              }
                            },
                            text: "Create profile".tr),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
