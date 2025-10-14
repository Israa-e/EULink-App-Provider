import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RichTexts extends StatelessWidget {
 final String firstText;
 final String secondText;

 final void Function() onTap;

   RichTexts({Key? key, required this.firstText, required this.secondText,
 required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          text:  TextSpan(children: [
            TextSpan(
              text: firstText,
              style:  Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: secondText,
              style:  TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,

              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            )
          ])),
    );
  }
}
