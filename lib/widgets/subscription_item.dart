import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class SubscriptionItem extends StatelessWidget {
  final String? title;
  final List<String>? text1;
  final String? pris;
  final int text2;
  final bool? select;

  const SubscriptionItem(
      {Key? key,
      required this.title,
      required this.text1,
      required this.pris,
      required this.text2,
      required this.select})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 130.h,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: select == true
            ? Border.all(color: Theme.of(context).primaryColor, width: 3)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 0),
          )
        ],
        color: Theme.of(context).cardTheme.color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: AutoSizeText(title!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 14.sp, height: 1.5,

                    color: select==true?Theme.of(context).primaryColor:Theme.of(context).textTheme.titleSmall?.color
                    )),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top:10,bottom: 10),
                // padding: EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                        text: "\$$pris",
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: Theme.of(context).primaryColor)),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      child: ListView.separated(
                        itemCount: text2,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Text('⦁ ${text1![index]}',
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                  color: select==true?Theme.of(context).primaryColor:Theme.of(context).textTheme.displayMedium?.color
                              )
                          );
                        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(
                        height: 5.h,
                      ); },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}
