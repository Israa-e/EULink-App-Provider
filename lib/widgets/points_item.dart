import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class PointsItem extends StatelessWidget {
  final String order;
  final String date;
  final String prise;

  const PointsItem({Key? key, required this.order, required this.date, required this.prise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children:  [
            CustomText(
                text: order,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                )
            ),
             SizedBox(
              height: 5.h,
            ),
            CustomText(
              text: date,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                )
            ),
          ],
        ),
        RichText(
          text:  TextSpan(children: [
            TextSpan(
              text:prise,
              style:  TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Theme.of(context).primaryColor),
            ),
             TextSpan(
              text: "Points".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Theme.of(context).primaryColor),
            ),
          ]),
        ),
         SizedBox(
          height: 15.h,
        )
      ],
    );
  }
}
