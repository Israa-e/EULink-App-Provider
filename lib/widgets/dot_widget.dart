import 'package:provider/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotWidget extends StatelessWidget {
  final Widget widget;

  const DotWidget({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText(
          text: "  •",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            )
        ),
        Expanded(
          child: widget,
        ),
      ],
    );
  }
}
