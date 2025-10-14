

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' ;
import 'package:provider/screens/menu_screens/setting/settings_controller.dart';
import 'package:provider/utils/common.dart';

import '../screens/splash/splash_screen.dart';





class AlertLogOutDialog extends StatelessWidget {
  SettingsController cotroller;

  AlertLogOutDialog(this.cotroller);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        width: Get.width,
        decoration: new BoxDecoration(
          color: Common.getDarkMode() == true ?
          Colors.blueGrey.shade900
              :Colors.grey.shade100,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 48,
              width: 48,
              padding: EdgeInsets.all(8),

              child: SvgPicture.asset(
                "assets/icons/ic_log_out_new.svg",

                color: Common.getDarkMode()
                    ?Colors.white
                    :  Colors.black  ,
              ),
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Common.getDarkMode() == true ?
              Colors.blueGrey.shade900 :Colors.grey.shade200,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            Center(
                child: Text(
                  "log_out".tr ,
                  style: TextStyle(color:Common.getDarkMode() == true ?Colors.white70 : Colors.black,fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 16,),
            Center(
                child: Text(
                  "log_out_msg".tr ,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Common.getDarkMode() == true ?Colors.white70 :null),
                )),
            Container(
              width: double.infinity,
              height: 2,
              color: Common.getDarkMode() == true ?
              Colors.blueGrey.shade900 :Colors.grey.shade200,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        cotroller.logout();
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 12, bottom: 12),
                          decoration: new BoxDecoration(
                            color: Common.getDarkMode() == true ?Colors.black26 :Colors.black,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Text(
                            "log_out".tr ,
                            style: TextStyle(color: Common.getDarkMode() == true ?Colors.white70 :Colors.white),
                          )),
                    )),
                Container(
                  width: 16,
                  height: 4,
                ),
                Center(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 12, bottom: 12),
                          decoration: new BoxDecoration(
                            color: Common.getDarkMode() == true ?Colors.black26 :Colors.white70,
                            border: Border.all(
                              color: Common.getDarkMode() == true ? Colors.transparent :Colors.black,

                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Text(
                            "cancel".tr ,
                            style: TextStyle(color: Common.getDarkMode() == true ?Colors.white70 :Colors.black),
                          )),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class AlertDeleteDialog extends StatelessWidget {
  SettingsController cotroller;

  AlertDeleteDialog(this.cotroller);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        width: Get.width,
        decoration: new BoxDecoration(
          color: Common.getDarkMode() == true ?
          Colors.blueGrey.shade900 : Colors.grey.shade100,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.highlight_remove, size: 48, color: Colors.red),
            Container(
              width: double.infinity,
              height: 2,
              color: Common.getDarkMode() == true ?
              Colors.blueGrey.shade900 :Colors.grey.shade200,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            Center(
                child: Text(
                  "disable_account".tr ,
                  style: TextStyle(color: Colors.red),
                )),
            SizedBox(height: 16,),
            Center(
                child: Text(
                  "disable_account_msg".tr ,
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                )),
            Container(
              width: double.infinity,
              height: 2,
              color:Common.getDarkMode() == true ?
              Colors.blueGrey.shade900 : Colors.grey.shade200,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        cotroller.deleteAccount(context);
                      },
                      child: Container(
                          width: Get.width/1.5,
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 12, bottom: 12),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              "disable_account".tr ,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )),
                Container(
                  width: 16,
                  height: 4,
                ),
                Center(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          width: Get.width/1.5,
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 12, bottom: 12),
                          decoration: new BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              "cancel".tr ,
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

