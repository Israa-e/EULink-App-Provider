import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:provider/utils/config.dart';

import '../core/theme/dark_theme.dart';
import '../utils/common.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final Rx<TextEditingController>? controllers;
  final bool prefixIcon;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final String? hint;
  final String? text;
  final String? initialValue;
  final bool? removeHeight;
  final int? maxLines;
  final Color? fillColor;
  final TextStyle? styleText;
  final Function(String?) validator;
  final TextStyle? styleInputText;
  final TextInputType? type;
  final FocusNode? focusNode;
  final bool? readOnly  ;

  const CustomTextFormField(
      {Key? key,
       this.controller,
      required this.prefixIcon,
      required this.hint,
      this.text,
      this.initialValue,
      this.maxLines = 1,
      this.focusNode,
      this.type,
      this.styleText,
      this.styleInputText,
      this.fillColor,
      this.readOnly ,
      this.suffixIcon, this.removeHeight,
        this.controllers,  required this.validator, this.prefixWidget,  this.enabled})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.text != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: widget.text!,
                  style: widget.styleText ??
                      Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              )
            : Container(),
        widget.text != ""
            ? SizedBox(
                height: 10.h,
              )
            : Container(
                color: Colors.orangeAccent,
              ),
          Container(
          height: widget.removeHeight==true? null:50,
          child: TextFormField(
            readOnly: widget.readOnly == null ? false :true ,
            enabled:widget.enabled??true,
            initialValue: widget.initialValue,
            autofocus: false,
            controller: widget.controller,
            validator: (value) { return widget.validator(value);},
            keyboardType: widget.type,
          //  textDirection: TextDirection.ltr,
            maxLines: widget.maxLines,
            //style: widget.styleInputText ?? Theme.of(context).textTheme.headlineMedium,
            decoration: InputDecoration(
                fillColor: widget.fillColor ??
                    (Common.getDarkMode()
                        ? Theme.of(context).primaryColorDark.withOpacity(0.05)
                        : Theme.of(context).scaffoldBackgroundColor),
                filled: true,
                hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 12,
                    ),
                hintText: widget.hint,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                    ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                    ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                    ),
                prefixIcon: widget.prefixIcon
                    ?Container(
                  width: Get.width/3.2,
                  // color: Colors.red,
                  child: IntrinsicHeight(
                    child: Row(children: [
                      widget.prefixWidget??Container(),
                      SizedBox(
                        width: 8,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: VerticalDivider(
                            thickness: 2,
                            color:
                            Common.getDarkMode()
                                ? primaryDarkColor.withOpacity(0.1)
                                : const Color(0xFF4B4C4D)
                                .withOpacity(0.1),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],),
                  ),
                )
                    : null,
                suffixIcon: widget.suffixIcon),
          ),
        )
      ],
    );
  }
}



class CustomTextFormFieldNew extends StatefulWidget {
  final TextEditingController? controller;
  final Rx<TextEditingController>? controllers;
  final bool prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final String? hint;
  final String? text;
  final String? initialValue;
  final bool? removeHeight;
  final int? maxLines;
  final Color? fillColor;
  final TextStyle? styleText;
  final Function(String?) validator;
  final Function(String?)? onChange;
  final TextStyle? styleInputText;
  final TextInputType? type;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly ;

  const CustomTextFormFieldNew(
      {Key? key,
        this.controller,
        required this.prefixIcon,
        required this.hint,
        this.text,
        this.initialValue,
        this.maxLines = 1,
        this.focusNode,
        this.type,
        this.styleText,
        this.styleInputText,
        this.fillColor,
        this.readOnly ,
        this.suffixIcon, this.removeHeight,
        this.controllers,  required this.validator,  this.onChange, this.prefixWidget, this.enabled})
      : super(key: key);

  @override
  State<CustomTextFormFieldNew> createState() => _CustomTextFormFieldStateNew();
}

class _CustomTextFormFieldStateNew extends State<CustomTextFormFieldNew> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.text != null
            ? Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CustomText(
            text: widget.text!,
            style: widget.styleText ??
                Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )
            : Container(),
        widget.text != ""
            ? SizedBox(
          height: 10.h,
        )
            : Container(
          color: Colors.orangeAccent,
        ),
        Container(
          height: widget.removeHeight==true? null:50,
          child: TextFormField(
            readOnly: widget.readOnly== null ?false :true ,
            initialValue: widget.initialValue,
            autofocus: false,
            enabled:widget.enabled ,
            controller: widget.controller,
            validator: (val) {

              if (val == null || val.isEmpty) {
                return "enter".tr  +
                    " " +
                    widget.text.toString() +
                    " " +
                    "please".tr ;
              }else if("phone_number".tr == widget.text   && val.length <  9 ){
                return "Enter a valid mobile Number".tr ;
              }

              return null;
            },            keyboardType: widget.type,
          //  textDirection: TextDirection.ltr,
            maxLines: widget.maxLines,
           // style: widget.styleInputText ?? Theme.of(context).textTheme.headlineMedium,
            decoration: InputDecoration(
                fillColor: widget.fillColor ??
                    (Common.getDarkMode()
                        ? Theme.of(context).primaryColorDark.withOpacity(0.05)
                        : Theme.of(context).scaffoldBackgroundColor),
                filled: true,
                hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 12,
                ),
                hintText: widget.hint,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                ),
                prefixIcon: widget.prefixIcon
                    ?
                Container(
                  width: Get.width/3.4,
                  // color: Colors.red,
                  child: IntrinsicHeight(
                    child: Row(children: [
                      widget.prefixWidget??Container(),
                      SizedBox(
                        width: 8,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: VerticalDivider(
                            thickness: 2,
                            color:
                            Common.getDarkMode()
                                ? primaryDarkColor.withOpacity(0.1)
                                : const Color(0xFF4B4C4D)
                                .withOpacity(0.1),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],),
                  ),
                )
                    : null,
                suffixIcon: widget.suffixIcon),
          ),
        )
      ],
    );
  }
}




class CustomTextFielImage extends StatefulWidget {
  @override
  State<CustomTextFielImage> createState() => _CustomTextFielImageState();
  final String title;

  String? hint = "";

  bool? isRequired = false;

  Rx<TextEditingController>? editController;

  final void Function() onTap;
  String path = "";

  CustomTextFielImage(this.title,
      {this.hint,
        this.isRequired,
        this.editController,
        required this.onTap,
        required this.path});
}

class _CustomTextFielImageState extends State<CustomTextFielImage> {
  bool isValid = false;

  @override
  void initState() {
    // TODO: implement initState
    isValid = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () => isValid == true || isValid == false
            ? Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (Common.getDarkMode()
                  ? Theme.of(context).primaryColorDark.withOpacity(0.05)
                  : Theme.of(context).scaffoldBackgroundColor),
              border: Border.all(
                color: isValid.obs == true
                    ? Colors.red.withOpacity(0.4)
                    : Color.fromRGBO(209, 209, 209, 1).withOpacity(0.2),
              )),
          child: Center(
            child: TextFormField(
              onTap: widget.onTap,
              controller: widget.editController!.value,
              readOnly: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10, color: Colors.grey, height: 1.1),

              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: widget.hint,
                fillColor:  Colors.transparent,
                filled: true,
                hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 12,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                ),
                icon: IconButton(
                  color: (Common.getDarkMode()
                      ? Theme.of(context).primaryColorDark.withOpacity(0.05)
                      : Theme.of(context).scaffoldBackgroundColor),
                    onPressed: widget.onTap,
                    icon: widget.path.isEmpty
                        ? SvgPicture.asset("assets/icons/ic_doc_file.svg")
                        : widget.path == "pdf" ||
                        widget.path == "doc" ||
                        widget.path.endsWith("pdf") ||
                        widget.path.endsWith("doc")
                        ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                        : widget.path.contains(confing.baseUrl) ==
                        true
                        ? CachedNetworkImage(
                      imageUrl: widget.path,
                   //   height: 11,width: 11,
                      progressIndicatorBuilder: (context,
                          url, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress
                                  .progress),
                      errorWidget: (context, url, error) =>
                      new Icon(Icons.error),
                    )
                        : Image.file(File(widget.path))),
              ),
              validator: (val) {
                isValid = false;
                if (widget.isRequired == true) {
                  if ((val == null || val.isEmpty ) && (widget.path == null || widget.path.toString().isEmpty)) {
                    isValid = true;
                    setState(() {
                      isValid = true;
                    });
                    return null;
                  } else {
                    isValid = false;
                    setState(() {
                      isValid = false;
                    });
                  }
                }
                

                return null;
              },
            ),
          ),
        )
            : Container(),
      ),
    );
  }
}






class CustomTextMobileField extends StatefulWidget {
  final TextEditingController? controller;
  final Rx<TextEditingController>? controllers;
  final bool prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final String? hint;
  final String? text;
  final String? initialValue;
  final bool? removeHeight;
  final int? maxLines;
  final Color? fillColor;
  final TextStyle? styleText;
  final Function(String?) validator;
  final Function(String?)? onChange;
  final TextStyle? styleInputText;
  final TextInputType? type;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;

  const CustomTextMobileField(
      {Key? key,
        this.controller,
        required this.prefixIcon,
        required this.hint,
        this.text,
        this.initialValue,
        this.maxLines = 1,
        this.focusNode,
        this.type,
        this.styleText,
        this.styleInputText,
        this.fillColor,
        this.readOnly,
        this.suffixIcon,
        this.removeHeight,
        this.controllers,
        required this.validator,
        this.onChange,
        this.prefixWidget,
        this.enabled})
      : super(key: key);

  @override
  State<CustomTextMobileField> createState() => _CustomTextMobileFieldtate();
}

class _CustomTextMobileFieldtate extends State<CustomTextMobileField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.text != null
            ? Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CustomText(
            text: widget.text!,
            style: widget.styleText ??
                Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )
            : Container(),
        widget.text != ""
            ? SizedBox(
          height: 10.h,
        )
            : Container(
          color: Colors.orangeAccent,
        ),
        Container(
          height: widget.removeHeight == true ? null : 50,
          child: TextFormField(
            initialValue: widget.initialValue,
            readOnly: widget.readOnly == null ? false : true,
            autofocus: false,
            enabled: widget.enabled,
            controller: widget.controller,

            keyboardType: widget.type,
          //  textDirection: TextDirection.ltr,
            maxLines: widget.maxLines,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "enter".tr +
                    " " +
                    widget.text.toString() +
                    " " +
                    "please".tr;
              } else if ("phone_number".tr == widget.text && val.length < 9) {
                return "Enter a valid mobile Number".tr;
              }

              return null;
            },

            // style: widget.styleInputText ?? Theme.of(context).textTheme.headlineMedium,
            decoration: InputDecoration(
                fillColor: widget.fillColor ??
                    (Common.getDarkMode()
                        ? Theme.of(context).primaryColorDark.withOpacity(0.05)
                        : Theme.of(context).scaffoldBackgroundColor),
                filled: true,
                hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 12,
                ),

                hintText: widget.hint,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                suffixIcon: Common.getLang() != "ar"
                    ? null
                    : widget.prefixIcon
                    ? Container(
                  //color: Colors.red,
                  width: Get.width / 3.4,
                  // color: Colors.red,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 8,
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10.h),
                            child: VerticalDivider(
                              thickness: 2,
                              color: Common.getDarkMode()
                                  ? primaryDarkColor.withOpacity(0.1)
                                  : const Color(0xFF4B4C4D)
                                  .withOpacity(0.1),
                            ),
                          ),
                        ),
                        widget.prefixWidget ?? Container(),
                      ],
                    ),
                  ),
                )
                    : null,
                prefixIcon: Common.getLang() != "ar"
                    ? widget.prefixIcon
                    ? Container(
                  //color: Colors.red,
                  width: Get.width / 3.4,
                  // color: Colors.red,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        widget.prefixWidget ?? Container(),
                        SizedBox(
                          width: 8,
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10.h),
                            child: VerticalDivider(
                              thickness: 2,
                              color: Common.getDarkMode()
                                  ? primaryDarkColor.withOpacity(0.1)
                                  : const Color(0xFF4B4C4D)
                                  .withOpacity(0.1),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                )
                    : null
                    : null),
          ),
        )
      ],
    );
  }
}