import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/utils/helper.dart';

import '../models/notification/notification_model.dart';
import 'custom_text.dart';
import 'image_person.dart';

class NotificationsItem extends StatelessWidget {
  final Notification notification;

  final void Function() onTap;

  const NotificationsItem(this.notification, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 10),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 0),
                  blurRadius: 10.r)
            ]),
        child: Row(
          children: [
            notification.refType.toString() == "0"
                ? Container()
                : ImagePerson(
                    height: 35.h,
                    width: 35.h,
                    img: notification.avatar != null ? notification.avatar : "",
                  ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(notification.message.toString(),
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          )),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: CustomText(
                        text:
                            convertDateFormatToDateTime(notification.createdAt),
                        textAlign: TextAlign.start,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                )),
                  ),
                ],
              ),
            ),
          ],
        ),

        // ListTile(
        //   leading: image
        //       ? ImagePerson(
        //           height: 45.h,
        //           width: 45.w,
        //         )
        //       : null,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         child: AutoSizeText(
        //             text,
        //             maxLines: 2,
        //             textAlign: TextAlign.left,
        //             style: Theme.of(context).textTheme.titleSmall?.copyWith(
        //                 fontWeight: FontWeight.w500,
        //                 fontSize: 11.sp,
        //             )
        //         ),
        //       ),
        //     ],
        //   ),
        //   subtitle: Container(
        //     margin: EdgeInsets.only(top: 5.h),
        //     child: CustomText(
        //         text: time,
        //         style: Theme.of(context).textTheme.displayMedium?.copyWith(
        //             fontWeight: FontWeight.w400,
        //             fontSize: 8.sp,
        //         )
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
