import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class WorkTimesItem extends StatelessWidget {
  final String text;
  final String from;
  final String to;
  final bool isTapped;
  final Function() onTap;
  final Function() onTapImage;

  const WorkTimesItem(
      {Key? key, required this.text, required this.from, required this.to, required this.onTap, required this.onTapImage, required this.isTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTapImage,
      child: Container(
        // height: 87.h,
        padding: const EdgeInsets.all(4),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: isTapped?Theme.of(context).primaryColor
                : Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),blurRadius: 10,offset: Offset(0,0))]),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomText(
                text: text,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
                color: isTapped? Colors.white
                        : Theme.of(context).primaryColorDark,)
            ),
          ),
          subtitle: Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "From".tr + " ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: isTapped?Colors.white
                            :  Theme.of(context).textTheme.displayLarge?.color?.withOpacity(0.5),
                      ),
                    ),
                    TextSpan(
                      text: "$from ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isTapped ? Colors.white :
                        Theme.of(context).textTheme.displayMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: " "+"To".tr + " ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color:  isTapped?Colors.white
                            :  Theme.of(context).textTheme.displayLarge?.color?.withOpacity(0.5),
                      ),
                    ),
                    TextSpan(
                      text: "$to ",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isTapped? Colors.white :
                        Theme.of(context).textTheme.displayMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: isTapped? GestureDetector(
            onTap: onTapImage,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/images/edit.png",
                height: 22.h,
                width: 22.w,
              ),
            ),
          ):SizedBox(height: 0,width: 0,),
        ),
      ),
    );
  }
}
