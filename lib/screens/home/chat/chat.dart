import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/core/theme/dark_theme.dart';
import 'package:provider/screens/pager/pager.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/widgets/app_loader_widget.dart';
import 'package:provider/widgets/chat_message.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/refresh_view.dart';
import '../../../utils/helper.dart';
import '../../../widgets/image_person.dart';
import 'chat_controller.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
  /**  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));*/

    changeStatusBarColor();
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () {
              if(controller.canBack == true ) {
                Get.back( );
              }else{
                Get.offAll(Pager(selected: 0,));
              }
              return Future.value(false);
            },
            child:  Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: null,
                  resizeToAvoidBottomInset: true,
                  body: /**AnnotatedRegion<SystemUiOverlayStyle>(
                    value: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
                    child: */Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          padding: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ]),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0, bottom: 5),
                                child: IconButton(
                                    onPressed: () {
                                      if(controller.canBack == true ) {
                                        Get.back( );
                                      }else{
                                        Get.offAll(Pager(selected: 0,));
                                      }
                                    },
                                    icon: RotatedBox(
                                      quarterTurns: Common.getLang() == "ar"? 2:4,
                                      child: SvgPicture.asset(
                                        "assets/icons/back_icon.svg",
                                        height: 18,
                                        color: Common.getDarkMode()
                                            ? secondTextColor
                                            : Colors.black,
                                        width: 10,
                                      ),
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20, bottom: 9, left: 10),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    ImagePerson(
                                      height: 35,
                                      width: 35,
                                      img: (controller.order != null
                                          ? controller.order!.user!=null ? controller.order!.user!.avatar
                                          .toString():""
                                          : ""),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: CustomText(
                                          text: controller.order != null
                                              ?controller.order!.user!=null ? controller.order!.user!.name
                                              .toString():""
                                              : "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                            child: LayoutBuilder(builder: (context, cons) {
                              return controller.isLoading == true
                                  ? AppLoaderWidget()
                                  : controller.chats.length > 0
                                  ? RefreshView(
                                onLoading: controller.onLoading,
                                onRefresh: controller.onRefresh,
                                isLoadMore: true.obs,
                                refreshController:
                                controller.refreshController,
                                enablePullDown: false,
                                enablePullUp:
                                controller.paginate != null &&
                                    controller.paginate!.total! >
                                        controller.chats.length
                                    ? true
                                    : false,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  primary: false,
                                  reverse: true,
                                  controller:
                                  controller.scrollController.value,
                                  itemCount: controller.chats.length,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  itemBuilder: (context, index) {
                                    return ChatMessage(
                                      controller.chats[index],
                                      index: index,
                                      indexSelect: controller.indexSelect,
                                      onTap: () {
                                        if(controller.chats[index].message_type.toString() == "1"  )
                                          controller.onClickMessageShow(controller.chats[index]);

                                        controller.indexSelect = index;
                                        controller.update();

                                      },
                                    );
                                    ;
                                  },
                                ),
                              )
                                  : Container() /**ListView(
                                  shrinkWrap: true,
                                  children: [
                                  const ChatMessage(
                                  text: "I’m waiting bro", time: "18:29", sender: true),
                                  const ChatMessage(
                                  text: "On my way", time: "18:29", sender: false),
                                  Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  const Expanded(
                                  child: Divider(
                                  color: Color(0xFFD6DADE),
                                  thickness: 1,
                                  ),
                                  ),
                                  SizedBox(
                                  width: 10.w,
                                  ),
                                  CustomText(
                                  text: "Today",
                                  style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  )),
                                  SizedBox(
                                  width: 10.w,
                                  ),
                                  const Expanded(
                                  child: Divider(
                                  color: Color(0xFFD6DADE),
                                  thickness: 1,
                                  ),
                                  ),
                                  ],
                                  ),
                                  ),
                                  const ChatMessage(
                                  text: "Are you sure the address is on the order?",
                                  time: "18:29",
                                  sender: false),
                                  const ChatMessage(
                                  text: "Of course this location is my location",
                                  time: "18:29",
                                  sender: true),
                                  const ChatMessage(
                                  text: "Hi Khalil I need about 3min to arrive",
                                  time: "18:29",
                                  sender: false),
                                  ],
                                  )*/
                              ;
                            }),
                          ),
                        ),
                        Container(
                          //height: 80.h,
                          padding:
                          EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 0))
                            ],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.setEmoji();
                                    },
                                    child: Image.asset(
                                      "assets/images/emoji.png",
                                      height: 27.h,
                                      width: 27.w,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      //height: 41,
                                      child: TextFormField(
                                        autofocus: false,

                                        controller: controller.editMessagecontroller.value,
                                        keyboardType: TextInputType.multiline,
                                        textDirection: TextDirection.ltr,
                                        style: Theme.of(context).textTheme.headlineMedium,
                                        maxLines: 3,
                                        minLines: 1,
                                        onTap: (){
                                          controller.emojiShowing = false;
                                          controller.update();
                                        },
                                        onChanged: (value) {
                                          controller.onMessageChanged();
                                        },
                                        decoration: InputDecoration(
                                          fillColor: (Common.getDarkMode()
                                              ? Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(0.05)
                                              : Theme.of(context).scaffoldBackgroundColor),
                                          filled: true,
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                            fontSize: 12,
                                          ),
                                          hintText: "Type your message".tr,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.getImageFromGalary(context);
                                    },
                                    child: Container(

                                        padding: EdgeInsets.all(8),
                                        child:  Icon(Icons.image ,color: Colors.grey ,)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (controller.editMessagecontroller.value.text !=
                                            null &&
                                            controller.editMessagecontroller.value.text
                                                .toString()
                                                .isNotEmpty)
                                          controller.sendMessageByOrderIdWebService(
                                              controller.editMessagecontroller.value.text
                                                  .toString(),0);
                                      },
                                      icon: Image.asset(
                                        "assets/images/send.png",
                                        height: 24.h,
                                        width: 24.w,
                                        color: controller.isMessageEmpty == true
                                            ? Colors.grey
                                            : null,
                                      ))
                                ],
                              ),

                              controller.ViewEmogi(context),
                            ],
                          ),
                        ),
                      ],
                    ),
               //   ),
                ),

          );
        });
  }
}
