import 'package:flutter/services.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/install/country_model.dart';
import '../../../models/splash/splash_response.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';
import '../../../widgets/custom_appbar.dart';
import 'contact_us_controller.dart';

class Contactus extends StatefulWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
            elevation: 0,
          leading: CustomAppBar(context)
        ),
        body: GetBuilder<ContactusController>(
          init: ContactusController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.contactFormKey,
                  child: Column(
                    children: [
                      Image.asset("assets/images/contact.png",height: 46.h,width: 46.w,),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                          text: "Get in touch!".tr,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          )
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                          text: "We are here for you, How we can help you?".tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          )
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomTextFormFieldNew(
                        controller: controller.nameController.value,
                        prefixIcon: false,
                        hint: "Enter name".tr,
                        readOnly: controller.nameController.value.toString().isEmpty ?false :true,
                        removeHeight: true,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return Helper.ShowSnackBarFailure(
                              title: "Error".tr,
                              body: 'Please enter your name'.tr,
                            );
                          }
                        },
                        text: "name".tr,
                        fillColor: Common.getDarkMode()?Colors.white.withOpacity(0.05):Colors.white,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextMobileField(
                        controller: controller.phoneController.value,
                        readOnly: controller.phoneController.value.toString().isEmpty ?false :true,
                        prefixIcon: true,
                        hint: "Enter mobile number".tr,
                        text: "Mobile Number".tr,

                          prefixWidget: Container(
                            child: DropdownButton<Country?>(

                              underline: Container(),
                              dropdownColor:Common.getDarkMode() ==true ?  Colors.black:null, //<-- SEE HERE
                              icon: Visibility(
                                  visible: false,
                                  child:
                                  Icon(Icons.arrow_downward)),
                              value: controller
                                  .selectedCountry.value,

                              items: controller.countries
                                  ?.map((Country? country) =>
                                  DropdownMenuItem<Country?>(
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
                                            child:
                                            Image.network(
                                              country!.flag.toString(),
                                              fit: BoxFit
                                                  .cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          CustomText(
                                            text:
                                            country.code,
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
                              onChanged:controller
                                  .selectedCountry.value.toString().isNotEmpty ? null :
                              controller.onCountryChanged,
                            ),
                          ),
                        validator: (value){
                          if (value == null || value.isEmpty) {
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
                          return null;
                        },

                        removeHeight: true,
                        fillColor: Common.getDarkMode()?Colors.white.withOpacity(0.05):Colors.white,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextFormFieldNew(
                        controller: controller.messageController.value,
                        prefixIcon: false,
                        hint: "Write your message...".tr,
                        text: "Message".tr,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return Helper.ShowSnackBarFailure(
                              title: "Error".tr,
                              body: 'Please enter your name'.tr,
                            );
                          }
                        },
                        removeHeight: true,
                        fillColor: Common.getDarkMode()?Colors.white.withOpacity(0.05):Colors.white,
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                          margin:  EdgeInsets.symmetric(horizontal: 30.w),
                          child: CustomButton(
                            onPressed: ()async {
                              if (controller.contactFormKey.currentState!
                                  .validate()) {
                                await controller.contactData();
                               }
                            },
                            text: "Send Message".tr,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
