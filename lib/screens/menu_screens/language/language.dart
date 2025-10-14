import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/utils/common.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/language_item.dart';
import '../../../widgets/search_text_filed.dart';
import 'language_controller.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int indexTaped=0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        init: LanguageController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
              elevation: 0,
              leading: CustomAppBar(context),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    SearchTextFiled(
                      textEditingController: controller.searchController.value,
                      onSaved: (val) {
                        controller.onSearch(val);

                      },
                      onChanged: (val) {
                        controller.onSearch(val);

                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return LanguageItem(
                            text:controller.locales.where((element) => element.name!.toLowerCase().contains(controller.q.toString().toLowerCase().toString()) ).toList()[index].name,
                            onTap: () {
                              setState(() {
                                //indexTaped=index;
                                controller.locales.forEach((element) {
                                  element.isSelect = false;
                                });
                                controller.locales.where((element) => element.name!.toLowerCase().contains(controller.q.toString().toLowerCase()) ).toList()[index].isSelect = true ;
                                controller.update();

                                controller.updateUserLanguageWebService(locale_id:controller.locales.where((element) => element.name!.toLowerCase().contains(controller.q.toString().toLowerCase()) ).toList()[index].id! );
                              });
                            },
                            isTrue:controller.locales.where((element) => element.name!.toLowerCase().contains(controller.q.toString().toLowerCase()) ).toList()[index].isSelect,
                          );
                        },
                        itemCount: controller.locales.where((element) => element.name!.toLowerCase().contains(controller.q.toString().toLowerCase()) ).length,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
