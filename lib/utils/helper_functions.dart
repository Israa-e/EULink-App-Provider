import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

customErrorScreen() {
  return ErrorWidget.builder = ((details) {
    return Material(
      child: Container(
        color: Color(0xFFFAFAFA),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/error_widget.svg',height: 300.h,width: 250.w  ,),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                details.exception.toString(),
                style: TextStyle(color: Colors.black,fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  });
}
