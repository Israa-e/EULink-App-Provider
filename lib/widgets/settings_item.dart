import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/theme/light_theme.dart';
import '../utils/common.dart';
import 'custom_text.dart';

class SettingsItem extends StatelessWidget {
  final Widget? widget;
  final Function() onTap;
  final String text;
  final String image;
  final double? h;
  final double? w;

  const SettingsItem(
      {Key? key,
      this.widget,
      required this.onTap,
      required this.text,
      required this.image,
      this.h = 18,
      this.w = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        height: Get.height / 12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Theme.of(context).cardTheme.color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                image.contains("ic_log_out_new")
                    ? Container(
                  height: 24,
                  width: 24,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color:Common.getDarkMode()
                          ?  Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(24)),
                  child: SvgPicture.asset(
                    image ,
                    color: Common.getDarkMode()
                        ? Colors.black
                        : Colors.white,
                  ),
                )
                        : image.contains("ic_disable_account")
                    ? Container(
                  height: 24,
                  width: 24,
                  //padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24)),
                  child: Icon(
                    Icons.no_accounts_sharp,
                    color: Common.getDarkMode()
                        ? Colors.white
                        : Colors.white,
                    size: 21,
                  ),
                )
                    : SvgPicture.asset(
                        image!,
                        height: h,
                        width: w,
                        color: Common.getDarkMode()
                            ? Colors.white
                            : secondTextColor,
                      ),
                SizedBox(
                  width: 20.w,
                ),
                CustomText(
                    text: text,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color:  image.contains("ic_disable_account") ? Colors.red: null,
                          fontSize: 12.sp,
                        )),
              ],
            ),
            widget ?? Container()
          ],
        ),
      ),
    );
  }
}
