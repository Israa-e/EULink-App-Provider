import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/widgets/rich_text.dart';

import '../screens/auth/complete_profile/complete_profile.dart';
import '../utils/common.dart';
import 'custom_button.dart';
import 'custom_text.dart';
import 'image_person.dart';

 orderDetailBottomSheets({required BuildContext context,required name,required mobile,required address,required img}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            width: 51.w,
            child: const Divider(
              thickness: 4,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
           ImagePerson(
            height: 50,
            img: img,
            width: 50,
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomText(
              text: '$name',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              )),
          SizedBox(
            height: 10.h,
          ),
          CustomText(
              text: '$mobile',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: Theme.of(context).primaryColor)),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: CustomText(
                        text:'$address',
                        maxLine: 2,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 9.sp,
                        )),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15.h,),
     
        ],
      ),
    ),
  );
}
