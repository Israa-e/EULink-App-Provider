import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class HomeCategory extends StatelessWidget {
  final String text;
  final String img;
  final bool pressed;

  const HomeCategory(
      {Key? key, required this.text, required this.img, required this.pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 0),
            )
          ],
          border: pressed == true
              ? Border.all(width: 2, color: Theme.of(context).primaryColor)
              : null),
      child: Container(
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * 0.1,
              width: Get.width * 0.32,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                "$img",
                height: 58.23.h,
                width: 46.91.w,
                    fit: BoxFit.cover,
              )),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              margin: EdgeInsets.only(top: 5,left: 5,right: 5),
              child: CustomText(
                  text: text,
                  // color: AppColors.black
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: pressed
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.titleSmall?.color)),
            ),
          ],
        ),
      ),
    );
  }
}
