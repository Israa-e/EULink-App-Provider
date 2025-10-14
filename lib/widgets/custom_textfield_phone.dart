import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomTextFieldPhone extends StatefulWidget {
  final String? title;

  String hint = "";

  bool? isRequired = false;

  TextEditingController? editController ;
  TextEditingController? editControllerCountry ;

  String? assetName = "";
  Function? onChange;

  bool? readOnly = false;
  String? suffix;

  CustomTextFieldPhone(
      this.hint, {
        this.title,
        this.assetName,
        this.isRequired,
        this.editController,
        this.editControllerCountry ,
        this.onChange,
        this.readOnly,
        this.suffix,
      });

  @override
  State<CustomTextFieldPhone> createState() => _CustomTextFieldPhoneState();
}

class _CustomTextFieldPhoneState extends State<CustomTextFieldPhone> {

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom:  8),
        // color: Colors.red,
        width: double.infinity,
        height: 120,

        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                 margin: EdgeInsets.only(bottom: Platform.isIOS ==true ?8:2),
              //  height: 32,
                child: Center(
                  child: Text("+",
                    textAlign: TextAlign.center,

                    style: TextStyle(

                        color: Color.fromRGBO(186, 185, 188, 1),
                        fontSize: 23,
                        height: 1.0,
                        fontWeight: FontWeight.w500
                    ),),
                ),
              ),
              Container(
                //margin: EdgeInsets.only(top: 14),
                child: Container(
                  width: Get.width/ (2.6*3.3),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top:  0),
                  // color: Colors.green,
                  child: PinCodeTextField(
                    keyboardType :TextInputType.number ,
                    appContext: context,
                    enabled: false,

                    textStyle: TextStyle(
                        color: Color.fromRGBO(186, 185, 188, 1),
                        fontSize: 23,
                        height: 1.6,
                        fontWeight: FontWeight.w500
                    ),
                    pastedTextStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      fontWeight: FontWeight.bold,

                    ),
                    length: 3,
                    obscureText: false,

                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    showCursor: false,
                    animationType: AnimationType.fade,
                    cursorHeight: 24 ,


                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,

                      fieldHeight:   Platform.isIOS ==true ?32:24,


                      fieldWidth: Get.width / 28,
                      borderWidth:0.001,


                      activeColor: Colors.white,
                      activeFillColor:Colors.white,
                      inactiveFillColor:
                      Colors.white,
                      selectedFillColor:Colors.white,
                      errorBorderColor:
                      Colors.white,
                      inactiveColor:Colors.white,
                      selectedColor:
                      Colors.white,
                    ),
                    cursorColor: Colors.black,

                    animationDuration: Duration(milliseconds: 300),
                    controller: widget.editControllerCountry ,

                     onCompleted: (v) {

                    },
                    onChanged: (String value) {},
                  ),
                ),),
              SizedBox(
                width: 8,
              ),
              Container(
                width: Get.width / 2.6,
                margin: EdgeInsets.only(top: 0),
                // color: Colors.green,
                child: PinCodeTextField(
                  appContext: context,
                  cursorHeight: 24 ,
                  textStyle: TextStyle(
                    color: Get.isDarkMode == true ? Colors.white :Colors.black,
                    fontSize: 23,
                      height: 1.6,
                    fontWeight: FontWeight.w500
                  ),
                  pastedTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    fontWeight: FontWeight.bold,

                  ),
                  length: 9,
                  obscureText: false,


                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight:  Platform.isIOS ==true ?32:24,


                    fieldWidth: Get.width / 28,
                    borderWidth:0.8,
                    activeColor: Get.isDarkMode == true ? Colors.transparent : Colors.white,
                    activeFillColor:
                    Theme.of(context).backgroundColor.withOpacity(0.2),
                    inactiveFillColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    errorBorderColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    inactiveColor:Color.fromRGBO(186, 185, 188, 1),
                    selectedColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  controller: widget.editController ,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {

                  },
                  onChanged: (String value) {},
                ),
              ),
             /** SizedBox(
                width: 16,
              ),
              Container(
                width: Get.width / 7.5,
                //color: Colors.blue,
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    fontWeight: FontWeight.bold,
                  ),
                  length: 3,
                  obscureText: false,
                  focusNode: widget.myFocusNode2,
                  obscuringCharacter: '*',
                  autoDismissKeyboard: false,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 28,
                    fieldWidth: Get.width / 26,
                    activeColor: Colors.white,
                    activeFillColor:
                    Theme.of(context).backgroundColor.withOpacity(0.2),
                    inactiveFillColor: Colors.white,
                    selectedFillColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    errorBorderColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    inactiveColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  controller: widget.editController2,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {
                    //widget.myFocusNode2.unfocus();
                    if( Platform.isIOS){
                      widget.myFocusNode3.nextFocus();

                    }else
                      widget.myFocusNode3.requestFocus(); // setState(() {});
                  },
                  onChanged: (String value) {
                    if (value.length == 0) {
                      // widget.myFocusNode2.unfocus();

                      widget.myFocusNode1.requestFocus();
                    }
                  },
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                width: Get.width / 5.7,
                // color: Colors.grey,
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: false,
                  focusNode: widget.myFocusNode3,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 28,
                    fieldWidth: Get.width / 26,
                    activeColor: Colors.white,
                    activeFillColor:
                    Theme.of(context).backgroundColor.withOpacity(0.2),
                    inactiveFillColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    errorBorderColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    inactiveColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  controller: widget.editController3,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {

                  },
                  onChanged: (String value) {
                    if (value.length == 0) {
                      // widget.myFocusNode3.unfocus();
                      if( Platform.isIOS){
                        widget.myFocusNode2.nextFocus();

                      }else
                        widget.myFocusNode2.requestFocus();
                    }
                  },
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }


}
