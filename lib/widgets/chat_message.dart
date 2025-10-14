import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/models/chat/message_model.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/utils/helper.dart';
import 'package:provider/widgets/cached_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/theme/dark_theme.dart';
import '../utils/common.dart';
import 'custom_text.dart';

class ChatMessage extends StatelessWidget {
  Chat chatRoomMessage;
  int index = -1;
  int indexSelect = -1;

  final void Function() onTap;

  ChatMessage(
    this.chatRoomMessage, {
    required int this.index,
    required this.onTap,
    required this.indexSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: chatRoomMessage.senderType != 0
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: chatRoomMessage.senderType != 0
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: chatRoomMessage.senderType != 0
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 220.w),
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, bottom: 15, right: 20),
                  decoration: BoxDecoration(
                      color: chatRoomMessage.senderType != 0
                          ? Theme.of(context).primaryColor
                          : Common.getDarkMode() == true
                              ? Theme.of(context)
                                  .cardTheme
                                  .color
                                  ?.withOpacity(0.1)
                              : Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 0)),
                      ]),
                  child: Wrap(
                    children: [
                      if (chatRoomMessage.message_type == 0)
                        Linkify(
                          onOpen: (link) async {
                            if (!await launchUrl(Uri.parse(link.url))) {
                              throw Exception('Could not launch ${link.url}');
                            }
                          },
                          text: chatRoomMessage.message.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 12.sp,
                                  color: chatRoomMessage.senderType != 0
                                      ? Common.getDarkMode()
                                          ? primaryLightColor
                                          : primaryDarkColor
                                      : Common.getDarkMode()
                                          ? primaryDarkColor
                                          : primaryLightColor),
                          linkStyle: TextStyle(color: Colors.blue),
                        )
                      else
                        Container(
                          width: Get.width / 2,
                          height: Get.width / 2,
                          child: GestureDetector(
                            onTap: onTap,
                            child: CachedImageWidget(
                              image: (chatRoomMessage.message
                                          .toString()
                                          .isNotEmpty &&
                                      confing.baseUrl !=
                                          chatRoomMessage.message.toString()
                                  ? chatRoomMessage.message.toString()
                                  : ""),
                              fit: BoxFit.cover,
                              height: 180,
                              width: double.infinity,
                            ),
                          ),
                        )
                      /**  CustomText(
                          text: chatRoomMessage.message.toString(),
                          style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                          fontSize: 12.sp,
                          color: chatRoomMessage.senderType !=0 ? Common.getDarkMode() ? primaryLightColor:primaryDarkColor
                          : Common.getDarkMode() ? primaryDarkColor:primaryLightColor)),*/
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: CustomText(
                      text: getEndAfferByDate(chatRoomMessage.createdAt),
                      // color: const Color(0xFF8C8C8C)
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Color(0xFF8C8C8C))),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
