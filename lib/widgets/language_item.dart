import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class LanguageItem extends StatelessWidget {
  final String? text;
  final Function() onTap;
  final bool isTrue;

  const LanguageItem(
      {Key? key, required this.text, required this.onTap, required this.isTrue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(23),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 0))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: text,
                // fontSize: 16.sp,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
        )
            ),
            isTrue
                ?  Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            )
                : Column(),
          ],
        ),
      ),
    );
  }
}
