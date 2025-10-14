import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';
import 'image_person.dart';

class MenuPerson extends StatelessWidget {
  final String? img;
  final String? name;
  final String? hourRate;

  const MenuPerson({Key? key, this.img, this.name, this.hourRate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        SizedBox(
          height: 10.h,
        ),
        ImagePerson(height: 50.h,width: 50.h, img: '$img',),
        SizedBox(
          height: 5.h,
        ),
        CustomText(
            text: "$name",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13.5.sp,
            )
        ),
        SizedBox(
          height: 7.h,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: CustomText(
              text: hourRate == null ? "":"\$${hourRate}/hr",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 11.5.sp,
              )
          ),
        ),
      ],
    );
  }
}
