import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double radius;
  final TextStyle? style;
    CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.radius = 8,  this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: CustomText(
          text: text,
          style: style?? Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp
          ),
        ),
      ),
    );
  }
}

class CustomButtonNew extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double radius;
  final TextStyle? style;
  final Color? backgroundColor ;
  CustomButtonNew({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.radius = 8,  this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          backgroundColor: backgroundColor,
        ),
        child: CustomText(
          text: text,
          style: style?? Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp
          ),
        ),
      ),
    );
  }
}
