import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cached_avatar_widget.dart';

class ImagePerson extends StatelessWidget {
  final double height;
  final double width;
  final String? img;

  const ImagePerson({Key? key, this.height = 40, this.width = 40, this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: Theme.of(context).primaryColor)),
      child: CircleAvatar(
        radius: 50, // Set the radius of the circle avatar as per your requirement.

        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedAvatarWidget(
            image:
            img != null || img.toString().isNotEmpty || img.toString() !="null" ?
            img.toString():"",
            fit: BoxFit.fill,

          ),
        ),

      ),
    );;
  }

  Container buildContainer(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Theme.of(context).primaryColor)),
    child: SizedBox(
      height: height.h,
      width: width.w,
      child: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(390),
          child:
          img==null?  Image.asset(
  "assets/images/person.png",
          ):
  Image.network('$img',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
  }
}
