import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/theme/light_theme.dart';
import '../utils/common.dart';
import 'custom_text.dart';

class MenuItem extends StatelessWidget {
  final String image;
  final String text;
  final double? height;
  final double? width;

  const MenuItem(
      {Key? key,
      required this.image,
      required this.text,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7),
      padding: const EdgeInsetsDirectional.only(top: 25, bottom: 25, start: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 0),
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Row(
        children: [
         image.toString() == "choose_services"?Icon(Icons.home_repair_service,
             size: height,
             color: Common.getDarkMode() ? Colors.white : secondTextColor, ) : SvgPicture.asset(
            "assets/icons/$image.svg",
            height: height,
            width: width,
            color: Common.getDarkMode() ? Colors.white : secondTextColor,
          ),
          SizedBox(
            width: 20.w,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: CustomText(
              text: text.tr,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
