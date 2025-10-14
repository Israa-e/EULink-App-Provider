import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/utils/common.dart';

import '../core/theme/light_theme.dart';

 CustomAppBar(context, {title, actions, controller, onTapBack}) {


  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 20.0,
    ),
    child: GestureDetector(
      onTap: () {
        if(onTapBack != null){
          onTapBack();
        }else
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: secondTextColor),
        child: Center(
          heightFactor: 2.0,
          widthFactor: 2.0,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 2.0),
            child: RotatedBox(
              quarterTurns: Common.getLang() == "ar"? 2:4,
              child: SvgPicture.asset(
                "assets/icons/back_icon.svg",
                height: 14.25.h,
                width: 14.w,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
