import 'dart:developer';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/models/splash/splash_response.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/dark_theme.dart';
import '../../../models/authentication/provider.dart';
import '../../../models/install/country_model.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/rich_text.dart';
import '../sign_up/sing_up_screen.dart';
import 'login_controller.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
final LoginController loginController = Get.put(LoginController());
class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Country>? list =Common.getSplash()?.data.countries;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    return GetBuilder<LoginController>(
        init: LoginController(),
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
              appBar: null,
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
                child: Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Get.height / 6,
                            ),
                            Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 60.0),
                              child: Image.asset(
                                Common.getDarkMode()
                                    ? "assets/images/logo_dark.png"
                                    : "assets/images/logo.png",
                                height: 45.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: Get.height / 25,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Welcome".tr +" ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Common.getDarkMode()
                                            ? primaryDarkColor
                                            : Theme.of(context)
                                            .iconTheme
                                            .color)),
                                TextSpan(
                                    text: "Back!".tr,
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
                              text: "Login to your account".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Form(
                              key: controller.loginFormKey,
                              child: Hero(
                                tag: "Phone".tr,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Material(
                                    color: Common.getDarkMode()
                                        ? Theme.of(context)
                                        .scaffoldBackgroundColor
                                        : Theme.of(context).primaryColorLight,
                                    child: CustomTextMobileField(
                                      prefixIcon: true,
                                      type: TextInputType.phone,
                                      prefixWidget:
                                      Container(
                                        child: DropdownButton<Country?>(
                                          dropdownColor:Common.getDarkMode() ==true ?  Colors.black:null, //<-- SEE HERE
                                          underline: Container(),
                                          icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                                          value: controller.selectedCountry.value,
                                          items: controller.countries?.map((Country? country) => DropdownMenuItem<Country?>(
                                              value: country,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  SizedBox(width: 20,),
                                                  Container(
                                                    height: 14.h,
                                                    width: 20.w,
                                                    child: Image.network(
                                                      country!.flag.toString(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  CustomText(
                                                    text: country.code,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10.sp),
                                                  ),
                                                  SizedBox(width: 10,),

                                                ],
                                              ))).toList()


                                          , onChanged: controller.onCountryChanged,

                                        ),
                                      ),
                                      controller: controller.mobileController.value,
                                      hint: "",
                                      validator: (value) {
                                       /** if (value == null || value.isEmpty) {
                                          return Helper.ShowSnackBarFailure(
                                            title: "Error".tr,
                                            body:
                                            'Please enter your phone number'.tr,
                                          );
                                        }
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
                                      controllers:
                                      controller.mobileController,
                                      removeHeight: true,
                                      text: "phone_number".tr,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 80.w),
                              child:
                                  CustomButton(
                                onPressed: () async {

                                  if (controller.mobileController.value.text
                                      .length <
                                      6) {
                                    String phone = controller.mobileController.value.text;
                                    controller.mobileController.value.text = phone;



                                  }

                                  if (controller.loginFormKey.currentState!
                                      .validate()) {
                                    if(Get.isDialogOpen == true  ||
                                        Get.isSnackbarOpen == true  ){
                                      Get.back();
                                    }
                                    controller.login();
                                   }
                                },
                                text: 'Login'.tr,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 50.h),
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don’t have an account?".tr +" ",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                              TextSpan(
                                  text: "Register Now".tr,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {

                                      FocusManager.instance.primaryFocus?.unfocus();
                                      FocusScope.of(context).requestFocus(FocusNode());

                                      Get.to(() => const SingUpScreen(),
                                          duration:
                                          const Duration(milliseconds: 500));
                                    }),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
