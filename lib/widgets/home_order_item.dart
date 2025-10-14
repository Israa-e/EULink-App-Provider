import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/utils/helper.dart';

import 'custom_text.dart';

class HomeOrderItem extends StatelessWidget {
  final String text;
  final int? status;
  final String serviceName;
  final String address;
  final DateTime? date;
  final String? timeString;
  final Color color;

  const HomeOrderItem(
      {Key? key,
        required this.text,
        required this.status,
      required this.color,
      required this.serviceName,
      required this.address,
      required this.date,
      required this.timeString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime time = DateFormat('HH:mm:ss').parse(timeString!);
    String formattedTime = DateFormat('h:mm a').format(time);
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(top: 15.h, bottom: 15.h, left: 15.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width/1.8,
                child: CustomText(
                    text: "${serviceName}",
                    // color: AppColors.black
                    maxLine: 1,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.2.sp,
                        height: 24 / 18)),
              ),
              viewStatusOrder( status!,16),

              /**Container(
                margin: const EdgeInsets.only(right: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: CustomText(
                    text: text,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: color)),
              ),*/
            ],
          ),
          SizedBox(
            height: 17.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/icons/location_icon.svg",
              ),
              SizedBox(
                width: 5.h,
              ),
              Expanded(
                child: CustomText(
                    text: '${address}',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                        )),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
              ),
              SizedBox(
                width: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomText(
                      text: "${DateFormat('d MMMM y', 'en_US').format(date!)}",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          )),
                ),
              ),
              SizedBox(
                width: 12.h,
              ),
              const Icon(
                Icons.access_time_rounded,
                size: 16,
              ),
              SizedBox(
                width: 4.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CustomText(
                    text:
                        "${formattedTime}",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
