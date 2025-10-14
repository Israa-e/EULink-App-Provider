import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/utils/common.dart';
class CustomTextField extends StatefulWidget {
  final String? title;

  String hint = "";

  bool? isRequired = false;

  Rx<TextEditingController>? editController;

  String? assetName = "";
  Function? onChange ;
  bool? readOnly = false;
  String? suffix ;

  CustomTextField(
      this.hint,
      { this.title,
      this.assetName,
      this.isRequired,
      this.editController,
      this.onChange ,
      this.readOnly,
      this.suffix,
       });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null?
          Column(
            children: [
              Text(widget.title!, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Color.fromRGBO(178, 178, 178, 1)
              ),
              textAlign: TextAlign.start,
              ),
              SizedBox(height: 5,),
            ],
          ):Container() ,
          Container(
            child:
            TextFormField(

              maxLength:null, //widget.hint == "hours".tr ?1 : null ,
              inputFormatters: widget.hint == "hours".tr ?[
                 LengthLimitingTextInputFormatter(1)  //or any number you want
              ]:[],
              onTap: () {
                var cursorPos = widget.editController!.value.selection.base.offset;

                if (cursorPos == widget.editController!.value.text.length - 1)
                  widget.editController!.value.selection =
                      TextSelection.fromPosition(TextPosition(
                          offset: widget.editController!.value.text.length));
              },
              controller: widget.editController!.value,
              readOnly: widget.readOnly != null && widget.readOnly == true
                  ? true
                  : false,

              obscureText: widget.hint.contains("password".tr)
                  ? _passwordVisible
                  : false,
              //This will obscure text dynamically
              keyboardType: widget.hint == "phone_number".tr ||  widget.hint == "hint_6_years".tr
                  ? TextInputType.phone
                  : widget.hint == "hours".tr ||widget.hint == "grade".tr
                  ? TextInputType.number
                  : widget.hint == "password".tr
                  ? TextInputType.visiblePassword
                  : widget.hint == "email".tr ||  widget.hint =="confirm_university_email".tr || widget.hint =="university_email".tr
                  ? TextInputType.emailAddress
                  : widget.hint == "intro".tr ||
                  widget.hint == "message".tr
                  ? TextInputType.multiline
                  : null,
              textAlign: TextAlign.start,
              maxLines: widget.title == "mission".tr ? 5 : 1 ,
              minLines: 1,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: widget.readOnly == true  ? Common.getDarkMode() == true ? Colors.white : Colors.grey :Common.getDarkMode() == true ? Colors.white :  Colors.black
              ),
              decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints(
                      maxHeight: 30,

                      maxWidth: widget.hint == "phone_number".tr ? 100 : 30,

                  ),

                  suffixIcon:widget.hint.contains("password".tr)
                      ? IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      size:22,
                      _passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color:  Color.fromRGBO(200, 200, 200, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ):widget.hint == "phone_number".tr  ? Directionality(
                    textDirection:Common.getLang() == "ar"?  TextDirection.ltr :
                    TextDirection.rtl,
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(Common.getLang() == "ar"? "+966":"966+",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(

                            color: widget.readOnly == true  ? Common.getDarkMode() == true ? Colors.white70 : Colors.grey :Common.getDarkMode() == true ? Colors.white :  Colors.black

                        ),),
                    ),
                  ) :
                  widget.suffix != null  ?

                  widget.suffix == "ic_person" ? Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SvgPicture.asset("assets/icons/${widget.suffix}.svg",
                      height: widget.suffix == "ic_gradute" || widget.suffix == "ic_place"  ? 18 :
                      widget.suffix == "ic_person" ? 21 :15 ,
                      color: Color.fromRGBO(176, 175, 178, 1),),
                  ):
                  SvgPicture.asset("assets/icons/${widget.suffix}.svg",
                      height: widget.suffix == "ic_gradute" || widget.suffix == "ic_place"  ? 18 :
                      widget.suffix == "ic_person" ? 21 :15 ,
                    color: Color.fromRGBO(176, 175, 178, 1),):null,





                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  isDense: true,
                  hintText: widget.hint,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: .25,
                      color: Color.fromRGBO(57, 56, 61, 1)
                    ),
                  ),

                  hintStyle:Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Color.fromRGBO(176, 175, 178, 1)
                  )
              ),
              validator: (val) {
                if (widget.isRequired == true) {
                  if (val == null || val.isEmpty) {
                    if("hint_6_years".tr == widget.hint){
                      return "enter".tr +
                          " " +
                           "left_until_graduation".tr +
                          " " +
                          "please".tr;
                    }else {
                      return "enter".tr +
                          " " +
                          widget.hint +
                          " " ;
                    }
                  } else {

                    if (widget.hint == "email".tr || widget.hint =="confirm_university_email".tr || widget.hint =="university_email".tr) {
                      if (val.isEmail == false) {
                        return "enter_valid_email".tr;
                      }
                    } else if (widget.hint == "phone".tr ||
                        widget.hint == "phone_number".tr) {
                      if (val.isPhoneNumber == false) {
                        return "enter_valid_phone".tr;
                      }
                    } else if (widget.hint == "active_code".tr &&
                        val.toString().length != 4) {
                      return "enter_active_code_please".tr;
                    }
                  }
                }
                return null;
              },
            )
          ),
        ],
      ),
    );
  }
}



class CustomTextFieldLable extends StatefulWidget {
  final String? title;

  String hint = "";

  bool? isRequired = false;

  Rx<TextEditingController>? editController;

  String? assetName = "";
  Function? onChange ;
  bool? readOnly = false;
  String? suffix ;

  CustomTextFieldLable(
      this.hint,
      { this.title,
        this.assetName,
        this.isRequired,
        this.editController,
        this.onChange ,
        this.readOnly,
        this.suffix,
      });

  @override
  State<CustomTextFieldLable> createState() => _CustomTextFieldLableState();
}

class _CustomTextFieldLableState extends State<CustomTextFieldLable> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
              child:
              TextFormField(
                onTap: () {
                  var cursorPos = widget.editController!.value.selection.base.offset;

                  if (cursorPos == widget.editController!.value.text.length - 1)
                    widget.editController!.value.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: widget.editController!.value.text.length));
                },
                controller: widget.editController!.value,
                readOnly: widget.readOnly != null && widget.readOnly == true
                    ? true
                    : false,

                obscureText: widget.hint.contains("password".tr)
                    ? _passwordVisible
                    : false,
                //This will obscure text dynamically
                keyboardType: widget.hint == "phone_number".tr ||  widget.hint == "hint_6_years".tr
                    ? TextInputType.phone
                    : widget.hint == "hours".tr ||widget.hint == "grade".tr
                    ? TextInputType.number
                    : widget.hint == "password".tr
                    ? TextInputType.visiblePassword
                    : widget.hint == "email".tr ||  widget.hint =="confirm_university_email".tr || widget.hint =="university_email".tr
                    ? TextInputType.emailAddress
                    : widget.hint == "intro".tr ||
                    widget.hint == "message".tr
                    ? TextInputType.multiline
                    : null,
                textAlign: TextAlign.start,
                maxLines: widget.title == "mission".tr ? 5 : 1 ,
                minLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: widget.readOnly == true  ? Common.getDarkMode() == true ? Colors.white : Colors.grey :Common.getDarkMode() == true ? Colors.white :  Colors.black
                ),
                decoration: InputDecoration(
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: 40,

                      maxWidth: widget.hint == "phone_number".tr ? 100 : 30,

                    ),
                    labelText: widget.hint,
                    labelStyle: TextStyle(
                        fontSize: 13,
                    color: Color.fromRGBO(176, 175, 178, 1)),
                    suffixIcon:widget.hint.contains("password".tr)
                        ? IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        size:22,
                        _passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color:  Color.fromRGBO(200, 200, 200, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ):widget.hint == "phone_number".tr  ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        child: CountryCodePicker(
                          enabled:  false  ,
                          dialogSize:  Size(40.w , 80.h),
                          initialSelection:'SA' ,
                          favorite: ['SA'],

                          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Color.fromRGBO(176, 175, 178, 1),

                          ),
                          dialogBackgroundColor:
                          Common.getDarkMode() == true
                              ? Colors.black87
                              : Colors.white,
                          showOnlyCountryWhenClosed: false,
                          showFlag: true,
                          //alignLeft: true,
                          showFlagMain: true,
                          hideMainText: false,
                          showDropDownButton: false,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ) :
                    widget.suffix != null  ? widget.suffix == "ic_user_2" ?
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 0),
                      child: SvgPicture.asset("assets/icons/${widget.suffix}.svg",
                        height: widget.suffix == "ic_gradute" || widget.suffix == "ic_place" || widget.suffix == "ic_person" ? 18 : widget.suffix == "ic_user_2" ?20 :15 ,
                        color: Color.fromRGBO(176, 175, 178, 1),),
                    ) :SvgPicture.asset("assets/icons/${widget.suffix}.svg",
                      height: widget.suffix == "ic_gradute" || widget.suffix == "ic_place" || widget.suffix == "ic_person" ? 18 : widget.suffix == "ic_user_2" ?20 :15 ,
                      color: Color.fromRGBO(176, 175, 178, 1),):null,
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    isDense: true,
                   // hintText: widget.hint,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: .25,
                          color: Color.fromRGBO(57, 56, 61, 1)
                      ),
                    ),

                    hintStyle:Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color.fromRGBO(176, 175, 178, 1)
                    )
                ),
                validator: (val) {
                  if (widget.isRequired == true) {
                    if (val == null || val.isEmpty) {
                      if("hint_6_years".tr == widget.hint){
                        return "enter".tr +
                            " " +
                            "left_until_graduation".tr +
                            " " +
                            "please".tr;
                      }else {
                        return "enter".tr +
                            " " +
                            widget.hint +
                            " " ;
                      }
                    } else {
                      if (widget.hint == "email".tr || widget.hint =="confirm_university_email".tr || widget.hint =="university_email".tr) {
                        if (val.isEmail == false) {
                          return "enter_valid_email".tr;
                        }
                      } else if (widget.hint == "phone".tr ||
                          widget.hint == "phone_number".tr) {
                        if (val.isPhoneNumber == false) {
                          return "enter_valid_phone".tr;
                        }
                      } else if (widget.hint == "active_code".tr &&
                          val.toString().length != 4) {
                        return "enter_active_code_please".tr;
                      }
                    }
                  }
                  return null;
                },
              )
          ),
        ],
      ),
    );
  }
}




class CustomTextFieldReadOnly extends StatefulWidget {
  final String? title;

  String hint = "";

  bool? isRequired = false;

  Rx<TextEditingController>? editController;

  String? assetName = "";
  Function? onChange ;
  bool? readOnly = false;
  String? suffix ;
  final void Function() onTap;

  CustomTextFieldReadOnly(
      this.hint,
      { this.title,
        this.assetName,
        this.isRequired,
        this.editController,
        this.onChange ,
        this.readOnly,
        this.suffix,
       required this.onTap
      });

  @override
  State<CustomTextFieldReadOnly> createState() => _CustomTextFieldReadOnlyState();
}

class _CustomTextFieldReadOnlyState extends State<CustomTextFieldReadOnly> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null?
          Column(
            children: [
              Text(widget.title!, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Color.fromRGBO(178, 178, 178, 1)
              ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 5,),
            ],
          ):Container() ,
          Container(
              child:
              TextFormField(
                onTap: widget.onTap,
                controller: widget.editController!.value,
                readOnly: widget.readOnly != null && widget.readOnly == true
                    ? true
                    : false,
                obscureText: widget.hint.contains("password".tr)
                    ? _passwordVisible
                    : false,
                //This will obscure text dynamically
                keyboardType: widget.hint == "phone_number".tr ||  widget.hint == "hint_6_years".tr
                    ? TextInputType.phone
                    : widget.hint == "hours".tr
                    ? TextInputType.number
                    : widget.hint == "password".tr
                    ? TextInputType.visiblePassword
                    : widget.hint == "email".tr ||  widget.hint =="confirm_university_email".tr || widget.hint =="university_email".tr
                    ? TextInputType.emailAddress
                    : widget.hint == "intro".tr ||
                    widget.hint == "message".tr
                    ? TextInputType.multiline
                    : null,
                textAlign: TextAlign.start,
                maxLines: widget.title == "mission".tr ? 5 : 1 ,
                minLines: 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: widget.readOnly == true  ? Common.getDarkMode() == true ? Colors.white : Colors.grey :Common.getDarkMode() == true ? Colors.white :  Colors.black
                ),
                decoration: InputDecoration(
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: 30,

                      maxWidth: widget.hint == "phone_number".tr ? 100 : 30,

                    ),
                    suffixIcon:widget.hint.contains("password".tr)
                        ? IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        size:22,
                        _passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color:  Color.fromRGBO(200, 200, 200, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ):widget.hint == "phone_number".tr  ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: CountryCodePicker(
                        enabled:  false  ,
                        dialogSize:  Size(90.w , 80.h),
                        initialSelection:'SA' ,
                        favorite: ['SA'],

                        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color.fromRGBO(176, 175, 178, 1),

                        ),
                        dialogBackgroundColor:
                        Common.getDarkMode() == true
                            ? Colors.black87
                            : Colors.white,
                        showOnlyCountryWhenClosed: false,
                        showFlag: true,
                        //alignLeft: true,
                        showFlagMain: true,
                        hideMainText: false,
                        showDropDownButton: false,
                        padding: EdgeInsets.zero,
                      ),
                    ) :
                    widget.suffix != null  ? SvgPicture.asset("assets/icons/${widget.suffix}.svg",
                      height: widget.suffix == "ic_gradute" || widget.suffix == "ic_place" || widget.suffix == "ic_person" ? 18 : 15 ,
                      color: Color.fromRGBO(176, 175, 178, 1),):null,
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    isDense: true,
                    hintText: widget.hint,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: .25,
                          color: Color.fromRGBO(57, 56, 61, 1)
                      ),
                    ),

                    hintStyle:Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color.fromRGBO(176, 175, 178, 1)
                    )
                ),
                validator: (val) {
                  if (widget.isRequired == true) {
                    if (val == null || val.isEmpty) {
                      if("hint_6_years".tr == widget.hint){
                        return "enter".tr +
                            " " +
                            "left_until_graduation".tr +
                            " " +
                            "please".tr;
                      }else {
                        return "enter".tr +
                            " " +
                            widget.hint +
                            " " +
                            "please".tr;
                      }
                    } else {
                       if (widget.hint == "email".tr || widget.hint =="confirm_university_email".tr || widget.hint =="university_email".tr) {
                        if (val.isEmail == false) {
                          return "enter_valid_email".tr;
                        }
                      } else if (widget.hint == "phone".tr ||
                          widget.hint == "phone_number".tr) {
                        if (val.isPhoneNumber == false) {
                          return "enter_valid_phone".tr;
                        }
                      } else if (widget.hint == "active_code".tr &&
                          val.toString().length != 4) {
                        return "enter_active_code_please".tr;
                      }
                    }
                  }
                  return null;
                },
              )
          ),
        ],
      ),
    );
  }
}
