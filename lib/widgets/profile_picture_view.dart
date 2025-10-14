import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/models/auth/avatars_response.dart';import 'package:provider/widgets/profile_picture_view.dart';

import 'cached_image_widget.dart';

class ProfilePictureView extends StatelessWidget {
  final Avatar avatar;

  final void Function() onTap;

  ProfilePictureView({
    required this.avatar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent
        ),
        child: Stack(
          children: [

            Container(
              height: Get.width/4 ,
              width: Get.width/4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(66),
                child: CachedImageWidget(
                  image: avatar.image.toString(),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ),

         avatar.isSelect != true ? Container():   ClipRRect(
              borderRadius: BorderRadius.circular(66),
              child:  Container(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ],
        ),
        //child:  Image.asset("assets/images/img_avatar.png",),
      ),
    );
  }
}
