import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/theme/dark_theme.dart';
import '../utils/common.dart';

class SearchTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;

  final Function onChanged;
  final Function onSaved;

  const SearchTextFiled(
      {Key? key,
      required this.textEditingController,
      required this.onChanged,
      required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      height: 42.h,
      decoration: BoxDecoration(
          color: Common.getDarkMode()? primaryDarkColor.withOpacity(0.05):inactiveTextColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0.r)),
      child: Center(
        child: TextFormField(
          // onSaved: onSaved(),
          controller: textEditingController,
          onChanged: (val) => onChanged(val),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for language".tr,
              hintStyle: TextStyle(
                color: const Color(0xFFADB5BD),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              prefixIcon:  Center(
                heightFactor: 2.0,
                widthFactor: 2.0,
                child: SvgPicture.asset(
                "assets/icons/search_icon.svg",
                  height: 15.26,
                  width: 15,
                  color: Color(0xFFADB5BD),
                ),
              )),
        ),
      ),
    );
  }
}
