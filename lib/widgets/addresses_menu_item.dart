import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:provider/core/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class AddressesMenuItem extends StatelessWidget {
  final String title;
  final String address;
  final bool isDefault;

  const AddressesMenuItem(
      {Key? key,
      required this.title,
      required this.address,
      required this.isDefault})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 25, left: 20,right: 20),
      margin:  EdgeInsets.symmetric(vertical: 4.h,),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: title,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                    )
                ),
                 SizedBox(
                  height: 5.h,
                ),
                AutoSizeText(
                     address,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                    )
                ),
              ],
            ),
          ),
          isDefault
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomText(
                    text: "Default".tr,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: Theme.of(context).primaryColor
                      )
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
