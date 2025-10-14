import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/screens/pager/pager.dart';
import 'package:provider/widgets/custom_text.dart';

import '/../widgets/home_category.dart';
import 'choose_service_controller.dart';

class ChooseService extends StatefulWidget {
  const ChooseService({Key? key}) : super(key: key);

  @override
  State<ChooseService> createState() => _ChooseServiceState();
}

class _ChooseServiceState extends State<ChooseService> {

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ChooseServiceController>(
          init: ChooseServiceController(),
          builder: (controller) {
            return Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Choose services".tr,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5.sp,
                                    height: 31.5 / 18),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomText(
                            text: "Choose the services you provide it".tr,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                ),
                          ),
                        ],
                      ),
                      CustomText(
                        text: "${controller.indexTap.length}/5",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.5.sp,
                                ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) => GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: Get.height / 50,
                              crossAxisSpacing: Get.width / 20,
                              childAspectRatio: Get.pixelRatio / 2.5),
                          itemCount: controller.servicesList?.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  controller.updateIndexTap(index,controller.servicesList![index].id);
                                  print(controller.indexTap);
                                },
                                child: HomeCategory(
                                  text: controller.servicesList![index].name.toString(),
                                  img: controller.servicesList![index].image.toString(),
                                  pressed: controller.indexTap.contains(index)? true : false,
                                ),
                              )),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 47.h,
                      width: 280.w,
                      child: FloatingActionButton(
                        backgroundColor: controller.idTap.length == 0 ? Colors.grey :Theme.of(context).primaryColor,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        onPressed: () async{
                          if(controller.idTap.length >0)
                             await controller.updateServices();
                        },
                        child: CustomText(
                            text: 'next'.tr,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
