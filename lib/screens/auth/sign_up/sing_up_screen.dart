import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/screens/auth/login/login_screen.dart';
import 'package:provider/screens/auth/sign_up/sign_up_controller.dart';
import 'package:provider/screens/menu_screens/privacy/privacy.dart';
import 'package:provider/widgets/custom_button.dart';

import '../../../models/install/country_model.dart';
import '/../widgets/custom_text.dart';
import '/../widgets/custom_text_form_field.dart';
import '../../../core/theme/dark_theme.dart';
import '../../../models/splash/splash_response.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';
import '../../../widgets/rich_text.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpState();
}

final SignUpController signUpController = Get.put(SignUpController());

class _SingUpState extends State<SingUpScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Common.getDarkMode()
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).primaryColorLight,
              body:AnnotatedRegion<SystemUiOverlayStyle>(
                value: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height / 6,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Image.asset(
                                Common.getDarkMode()
                                    ? "assets/images/logo_dark.png"
                                    : "assets/images/logo.png",
                                height: 45.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Hello".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Common.getDarkMode()
                                              ? primaryDarkColor
                                              : Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                ),
                                TextSpan(
                                    text: " "+"there,".tr,
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor)),
                              ]),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              text: "Create your account".tr,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Form(
                              key: controller.signUpFormKey,
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: CustomTextFormFieldNew(
                                      controller:
                                          controller.fullNameController.value,
                                      prefixIcon: false,
                                      removeHeight: true,
                                      hint: 'Enter username'.tr,
                                      type: TextInputType.name,
                                      validator: (value) {
                                        /**if (value == null || value.isEmpty) {
                                            return Helper.ShowSnackBarFailure(
                                            title: "Error".tr,
                                            body: 'Please enter your name'.tr,
                                            );
                                            }*/
                                      },
                                      text: "Username".tr,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Hero(
                                    tag: "Phone",
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Material(
                                          color: Common.getDarkMode()
                                              ? Theme.of(context)
                                                  .scaffoldBackgroundColor
                                              : Theme.of(context)
                                                  .primaryColorLight,
                                          child: CustomTextMobileField(
                                            controller: controller
                                                .phoneNumberController.value,
                                            removeHeight: true,
                                            validator: (value) {
                                              /**if (value == null || value.isEmpty) {
                                                  return Helper.ShowSnackBarFailure(
                                                  title: "Error".tr,
                                                  body:
                                                  'Please enter your phone number'.tr,
                                                  );
                                                  }

                                                  // Check if the value is a valid phone number
                                                  final phoneRegex = RegExp(
                                                  r'^\+?(\d{1,2})?\s*?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
                                                  if (!phoneRegex.hasMatch(value)) {
                                                  return Helper.ShowSnackBarFailure(
                                                  title: "Error".tr,
                                                  body:
                                                  'Please enter a valid phone number'.tr,
                                                  );
                                                  }
                                                  return null;*/
                                            },
                                            type: TextInputType.phone,
                                            prefixIcon: true,
                                            prefixWidget: Container(
                                              child: DropdownButton<Country?>(
                                                dropdownColor:
                                                    Common.getDarkMode() == true
                                                        ? Colors.black
                                                        : null,
                                                //<-- SEE HERE
                                                underline: Container(),
                                                icon: Visibility(
                                                    visible: false,
                                                    child: Icon(
                                                        Icons.arrow_downward)),
                                                value: controller
                                                    .selectedCountry.value,
                                                items: controller.countries
                                                    ?.map((Country? country) =>
                                                        DropdownMenuItem<
                                                                Country?>(
                                                            value: country,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  height: 14.h,
                                                                  width: 20.w,
                                                                  child: Image
                                                                      .network(
                                                                    country!.flag
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                CustomText(
                                                                  text: country
                                                                      .code,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall
                                                                      ?.copyWith(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          fontSize:
                                                                              10.sp),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            )))
                                                    .toList(),
                                                onChanged:
                                                    controller.onCountryChanged,
                                              ),
                                            ),
                                            hint: 'Enter phone number'.tr,
                                            text: "phone_number".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsetsDirectional.only(start: 8, end: 8),
                              /**  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                  color:controller.isChecked == true ? Colors.transparent : Colors.red,
                                  width: 0.5
                                  )
                                  ),*/
                              child:
                              Container(
                                margin: EdgeInsets.only(left: 24,right: 24,top:16),
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "agree to the".tr + " ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      TextSpan(
                                          text: "terms".tr,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.to(() => const Privacy(),
                                                  transition:
                                                  Transition.rightToLeft,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  arguments: ["terms"]);
                                            }),
                                      TextSpan(
                                        text: " " + "&".tr + "  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      TextSpan(
                                          text: "Privacy".tr,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.to(() => const Privacy(),
                                                  transition:
                                                  Transition.rightToLeft,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  arguments: ["privacy"]);
                                            })
                                    ])),
                              ),
                                /**
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: controller.isAgree,
                                      side: controller.isChecked == false
                                          ? BorderSide(
                                              color: controller.isChecked == true
                                                  ? Common.getUser()== true ? Colors.white70: Colors.black
                                                  : Colors.red)
                                          : BorderSide(
                                          color: controller.isChecked == true
                                              ? Common.getUser()== true ? Colors.white70: Colors.black
                                              : Colors.red),
                                      onChanged: (val) {
                                        controller.isChecked = true;
                                        controller.isAgree = val!;
                                        controller.update();
                                      }),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: "agree to the".tr + " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.sp,
                                          ),
                                    ),
                                    TextSpan(
                                        text: "terms".tr,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => const Privacy(),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                arguments: ["terms"]);
                                          }),
                                    TextSpan(
                                      text: " " + "&".tr + "  ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13.sp,
                                          ),
                                    ),
                                    TextSpan(
                                        text: "Privacy".tr,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => const Privacy(),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                arguments: ["privacy"]);
                                          })
                                  ])),
                                ],
                              ),*/
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 50.w),
                              child: CustomButton(
                                onPressed: () async {
                                   controller.update();
                                  if (controller.phoneNumberController.value.text
                                          .length >
                                      6) {
                                    String phone = controller
                                        .phoneNumberController.value.text;
                                    controller.phoneNumberController.value.text =
                                        phone;
                                  }

                                  String name =
                                      controller.fullNameController.value.text;
                                  if (controller.signUpFormKey.currentState!
                                      .validate()) {
                                       if (Get.isDialogOpen == true ||
                                          Get.isSnackbarOpen == true) {
                                        Get.back();
                                      }
                                      await controller.SignUp();

                                  }
                                  print(controller.isSingUp.toString());
                                  if (controller.isSingUp == true.obs) {}
                                  // verifying(context);
                                },
                                text: 'register'.tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50.h),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Already have an account?".tr + " ",
                          style:
                              Theme.of(context).textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.sp,
                                  ),
                        ),
                        TextSpan(
                            text: "Login".tr,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                             //   Get.back();
                                FocusManager.instance.primaryFocus?.unfocus();
                                FocusScope.of(context).requestFocus(FocusNode());

                                Get.offAll(() => const LoginScreen(),
                                    duration:
                                    const Duration(milliseconds: 500));
                              })
                      ])),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
