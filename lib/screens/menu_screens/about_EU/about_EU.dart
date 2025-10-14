import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:provider/screens/menu_screens/privacy/privacy_controller.dart';
import 'package:provider/widgets/app_loader_widget.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/light_theme.dart';
import '../../../utils/common.dart';
import '../../../widgets/custom_appbar.dart';


class AboutEU extends StatefulWidget {
  const AboutEU({Key? key}) : super(key: key);

  @override
  State<AboutEU> createState() => _AboutEUState();
}

class _AboutEUState extends State<AboutEU> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PagesController>(
        init: PagesController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
                elevation: 0,
                leading: CustomAppBar(context)),
            body: controller.isLoading == false
                ? AppLoaderWidget()
                : controller.page != null
                ? Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                CustomText(
                    text: controller.page!.name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    )),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                    text: controller.page!.description.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    )),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 25, top: 30),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(0, 0),
                                blurRadius: 10)
                          ]),
                      child: ListView(
                        children: [
                          controller.page!.image != null &&
                              controller.page!.image
                                  .toString()
                                  .isNotEmpty
                              ? Container(
                              height: Get.width / 2,
                              width: Get.width / 2,
                              child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(21),
                                  child: Image.network(
                                    controller.page!.image
                                        .toString(),
                                    height: Get.width / 2,
                                    width: Get.width / 2,
                                    fit: BoxFit.fill,
                                  )))
                              : Container(),
                          SizedBox(height: 24,),
                          AutoSizeText(
                            controller.page!.content.toString(),
                          )
                        ],
                      )),
                ),
              ],
            )
                : Container(),
          );
        });
  }
}
