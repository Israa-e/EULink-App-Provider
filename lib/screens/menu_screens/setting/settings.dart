import 'package:flutter/services.dart';
import 'package:provider/screens/menu_screens/about_EU/about_EU.dart';
import 'package:provider/screens/menu_screens/language/language.dart';
import 'package:provider/screens/menu_screens/privacy/privacy.dart';
import 'package:provider/screens/menu_screens/setting/settings_controller.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/widgets/dialog_login_after.dart';
import 'package:provider/widgets/dialog_login_after.dart';
import '../../../core/theme/light_theme.dart';
import '../../../utils/common.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/settings_item.dart';

class Settings extends StatefulWidget {
  final SettingsController controller;

  const Settings({Key? key,required this.controller}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDark = Common.getDarkMode() == true ? true : false;
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    isDark = Common.getDarkMode() == true ? true : false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
        elevation: 0,
        leading: CustomAppBar(context),
      ),
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              SettingsItem(
                text:  "Dark Mode".tr,
                h: 20.h,
                w: 17.w,
                image:  "assets/icons/dark_mode_icon.svg",
                widget:   SizedBox(
                //  height: 22.h,
                  width: 50.w,
                  child: FlutterSwitch(
                    value: isDark,
                    borderRadius: 60.0,

                    activeColor:Theme.of(context).primaryColor,
                    inactiveTextColor : secondTextColor,
                    inactiveColor: secondTextColor.withOpacity(0.2),
                    toggleSize: 20,
                     width: 45,
                     height: 22,
                    padding: 2,duration: Duration(milliseconds: 200),
                    onToggle: (bool value){
                      setState(() {
                        isDark = value;
                        widget.controller.chaneTheme(isDark);
                      });
                    },
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 10.h,
              ),
              SettingsItem(
                text: "Language".tr,
                h: 14.h,
                w: 24.w,
                image: "assets/icons/language_icon.svg",
                widget:  Row(
                  children: [
                    CustomText(
                        text: '${controller.getLanguage}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: const Color(0xFFC2C2C2),
                    ),),
                    SizedBox(width: 5.w,),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFFC2C2C2),
                      size: 10,
                    ),
                  ],
                ),
                onTap: () {
                  Get.to(()=>const Language(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 300));
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              SettingsItem(
                text: "Privacy".tr,
                h: 20.h,
                w: 18.w,
                image:  "assets/icons/privacy_icon.svg",
                onTap: () {
                  Get.to(()=>const Privacy(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 300) ,
                  arguments: ["privacy"]);

                },
              ),
              SizedBox(
                height: 10.h,
              ),

              SettingsItem(
                text: "About App".tr,
                h: 20.h,
                w: 20.w,
                image: "assets/icons/about_app_icon.svg",
                onTap: () {
                  Get.to(()=>const AboutEU(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 300),
                      arguments: ["about"]);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Spacer(),

              SettingsItem(
                text: "log_out".tr,
                h: 20.h,
                w: 20.h,
                image: "assets/icons/ic_log_out_new.svg",
                onTap: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        WillPopScope(
                          onWillPop: () {
                            Get.back();
                            return Future.value(true);
                          },
                          child: Scaffold(
                              backgroundColor: Colors.black12,
                              body: AlertLogOutDialog(controller)),
                        ),
                  );                  },
              ),
              SizedBox(
                height: 10.h,
              ),
          SettingsItem(
          text: "disable_account".tr,
          h: 20.h,
          w: 20.h,
          image: "assets/icons/ic_disable_account.svg",
          onTap: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: false,


              pageBuilder: (context, animation, secondaryAnimation) =>
                  WillPopScope(
                    onWillPop: () {
                      Get.back();
                      return Future.value(true);
                    },
                    child: Scaffold(
                        backgroundColor: Colors.black12,
                        body: AlertDeleteDialog(controller)),
                  ),
            );          },
          ),
              Container(height: 24,)



            ],
          );
        }
      ),
    );
  }
}
