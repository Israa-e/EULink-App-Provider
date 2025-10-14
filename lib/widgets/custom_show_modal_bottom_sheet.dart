import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> buildShowModalBottomSheet(
    {required BuildContext context, required Widget widget}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r))),
    context: context,
    builder: (context) => widget,
  );
}



Future<void> buildShowModalBottomSheetWhite(
    {required BuildContext context, required Widget widget}) {
  return showModalBottomSheet(
     isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r))),
    context: context,
    builder: (context) => widget,
  );
}