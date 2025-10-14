
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart' hide Trans;
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'common.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialogWidget(BuildContext context,
      {String title = "title",
        String okBtnText = "Ok",
        required Widget widget,
        required VoidCallback? okBtnFunction}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Container(
                          height: Get.height / 1.6,
                          width: double.infinity,
                          child: widget),

                      // dialog bottom
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: okBtnFunction,
                          child: new Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            padding: new EdgeInsets.all(10.0),
                            decoration: new BoxDecoration(
                                color: Color.fromRGBO(198, 40, 39, 1),
                                borderRadius: BorderRadius.circular(30)),
                            child: new Text(
                              okBtnText,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showCustomDialog(BuildContext context,
      {String title = "title",
        String msg = "msg",
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        required VoidCallback? okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 0),
                          child: Text(msg,
                              style: TextStyle(
                                color: Colors.black,
                              ))),

                      // dialog bottom
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: okBtnFunction,
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(198, 40, 39, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    okBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(74, 110, 137, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    cancelBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showCustomWidgetDialog(BuildContext context,
      {String title = "title",
        Widget? msg,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        required VoidCallback? okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(""),
                new Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 0),
                          child: msg),

                      // dialog bottom
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: okBtnFunction,
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(198, 40, 39, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    okBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(74, 110, 137, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    cancelBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showCustomWidgetDialogWin(BuildContext context,
      {String title = "title",
        Widget? msg,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        required VoidCallback? okBtnFunction,
        required VoidCallback? cancelBtnFunction}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(""),
                new Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 0),
                          child: msg),

                      // dialog bottom
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: okBtnFunction,
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(198, 40, 39, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    okBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: cancelBtnFunction,
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(74, 110, 137, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    cancelBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showCustomWidgetDialogBack(BuildContext context,
      {String title = "title",
        Widget? msg,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        required VoidCallback? okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 0),
                          child: msg),

                      // dialog bottom
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(74, 110, 137, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    cancelBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: okBtnFunction,
                                child: new Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  padding: new EdgeInsets.all(10.0),
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(198, 40, 39, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: new Text(
                                    okBtnText,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showCustomDialogAlert(BuildContext context,
      {String title = "title",
        Widget? msg,
        Widget? icon,
        String okBtnText = "ok",
        required VoidCallback? okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            content: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Container(
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color(0xFFFFFF),
                      borderRadius:
                      new BorderRadius.all(new Radius.circular(32.0)),
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        icon != null
                            ? Container(margin: EdgeInsets.all(8), child: icon)
                            : Container(),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Center(child: msg)),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: okBtnFunction,
                                  child: new Container(
                                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    padding: new EdgeInsets.all(10.0),
                                    decoration: new BoxDecoration(
                                        border: Border.all(
                                            color: Get.theme.primaryColor),
                                        borderRadius:
                                        BorderRadius.circular(30)),
                                    child: new Text(
                                      okBtnText,
                                      style: TextStyle(
                                        color: Get.theme.primaryColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showCustomDialogError(BuildContext context,
      String msg,
      VoidCallback? okBtnFunctionClick,) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Center(child: Text("error".tr)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Center(
                      child: Html(
                        data: '<p style="text-align:center;">' +
                            msg.toString() +
                            '</p>',
                      )),
                ),
                Container(
                  height: 16,
                ),
                InkWell(
                    onTap: okBtnFunctionClick,
                    child: Text(
                      "close".tr,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    )),
              ],
            ),
          );
        });
  }

  static void showCustomDialogTwoActions(BuildContext context,
      String title,
      String msg,
      String buttom1,
      String buttom2,
      VoidCallback? okBtnFunctionClickTrue,
      VoidCallback? okBtnFunctionClickfulse,) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Center(child: Text(title)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Center(
                      child: Html(
                        data: '<p style="text-align:center;">' +
                            msg.toString() +
                            '</p>',
                      )),
                ),
                Container(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: okBtnFunctionClickTrue,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                          decoration: BoxDecoration(
                            color: Get.theme.backgroundColor.withOpacity(0.2),
                            border: Border.all(
                              color: Get.theme.backgroundColor.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            buttom1,
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        )),
                    Container(
                      width: 24,
                      height: 4,
                    ),
                    InkWell(
                        onTap: okBtnFunctionClickfulse,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                          decoration: BoxDecoration(
                            color: Get.theme.backgroundColor.withOpacity(0.2),
                            border: Border.all(
                              color: Get.theme.backgroundColor.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            buttom2,
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }

  static void showCustomDialogCancelOrder(BuildContext context,
      VoidCallback? okBtnFunctionClickTrue,
      VoidCallback? okBtnFunctionClickfalse,
      {required bool IsRejected}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Center(
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(45 / 360),
                child: Icon(
                  Icons.add_circle,
                  color: Colors.red,
                  size: 48,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(8.0)),
                  ),
                  child: Center(
                      child: Column(
                        children: [
                          new Container(
                              height: 40,
                              width: Get.width / 1.5,
                              child: Center(
                                  child: Text(
                                    IsRejected == true
                                        ? "reject_order_time_title".tr
                                        : "delete_order_time_title".tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Html(
                            data: '<p style="text-align:center;">' +
                                (IsRejected == true
                                    ? "reject_order_time_msg".tr
                                    : "delete_order_time_msg".tr) +
                                '</p>',
                          ),
                        ],
                      )),
                ),
                Container(
                  height: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: okBtnFunctionClickTrue,
                        child: Container(
                          width: Get.width / 2,
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Get.theme.primaryColorDark,
                            border: Border.all(
                              color:
                              Get.theme.primaryColorDark.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              "yes".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                    Container(
                      width: 24,
                      height: 8,
                    ),
                    InkWell(
                        onTap: okBtnFunctionClickfalse,
                        child: Container(
                          width: Get.width / 2,
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            border: Border.all(
                              color: Get.theme.primaryColor.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              "no".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }



  static void showCustomDialogDelete(BuildContext context,
      void Function() onTapDelete,
      String title,
      String msg,) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Common.getDarkMode()== true ?Color.fromRGBO(
                31, 31, 31, 1.0) :null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: CircleAvatar(
              radius: 96 / 2,
              backgroundColor: Colors.red,
              child: Center(
                child: Container(
                  height: 94,
                  width: 96,
                  child: Icon(
                    Icons.delete_forever_sharp,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(8.0)),
                  ),
                  child: Center(
                      child: Column(
                        children: [
                          new Container(
                              height: 40,
                              width: Get.width / 1.5,
                              child: Center(
                                  child: Text(
                                    title,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                    //    color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ))),
                          Container(
                            width: Get.width / 1.2,
                            height: 60,
                            child: Text(
                              msg.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: 16,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);

                          onTapDelete();
                        },
                        child: Container(

                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                              color: Colors.red.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadiusDirectional.circular(8
                            ),
                          ),
                          child: Center(
                            child: Text(
                              title,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                    SizedBox(height: 8,),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            border: Border.all(
                              color: Get.theme.primaryColor.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadiusDirectional.circular(8


                            ),
                          ),
                          child: Center(
                            child: Text(
                              "cancel".tr,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }

  static void showCustomDialogTowAction(
      BuildContext context,
      void Function() onTapDelete,
      String title,
      String msg,

      ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Common.getDarkMode()== true ?Color.fromRGBO(
                31, 31, 31, 1.0) :Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: CircleAvatar(
              radius: 96 / 2,
              backgroundColor: Colors.green,
              child: Center(
                child: Container(
                  height: 94,
                  width: 96,
                  child: Icon(
                    Icons.check ,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(8.0)),
                  ),
                  child: Center(
                      child: Column(
                        children: [
                          new Container(
                              height: 40,
                              width: Get.width / 1.5,
                              child: Center(
                                  child: AutoSizeText(
                                    title,
                                    style: TextStyle(
                                      //  color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Container(
                            width: Get.width / 1.2,
                            height: 60,
                            child: AutoSizeText(
                              msg.toString(),
                              textAlign: TextAlign.center,
                              minFontSize: 14,
                              maxFontSize: 17,
                              maxLines: 4,
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);

                            onTapDelete();
                          },
                          child: Container(
                            width: Get.width / 2.2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.green ,
                              border: Border.all(
                                color: Colors.green.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadiusDirectional.circular(  8 ,

                              ),
                            ),
                            child: Center(
                              child: Text(
                                title.toString().toUpperCase() ,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: Get.width / 2.2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                border: Border.all(
                                  color: Get.theme.primaryColor.withOpacity(0.3),
                                ),
                                borderRadius: BorderRadiusDirectional.circular(  8 ,)

                            ),
                            child: Center(
                              child: Text(
                                "cancel".tr.toString().toUpperCase() ,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
  /**
  static void showCustomDialogTowAction(BuildContext context,
      void Function() onTapDelete,
      String title,
      String msg,) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            title: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 20,height: 20,),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 55, 23, 1),
                          borderRadius: BorderRadius.circular(2)
                        ),
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.delete , color: Colors.white,size: 20,),
                      ),
                      SizedBox(width: 5,),
                      Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(232, 232, 232, 1)
                    ),
                    child: Icon(Icons.close,color: Colors.grey,size: 20,),
                  )
                ],
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                  ),
                  child: Center(
                      child: Container(
                        width: Get.width / 1.2,
                        height: 60,
                        child: Text(
                          msg.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )),
                ),
                Container(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            onTapDelete();
                          },
                          child: Container(
                            width: Get.width / 2,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(
                              child: Text(
                                "undo".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: Get.width / 2,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color:  Color.fromRGBO(255, 55, 23, 1),

                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "delete_account".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }*/
  static void showCustomDialogOneActions(
      BuildContext context,
      String title,
      String msg,
      String buttom1,
      String buttom2,
      VoidCallback? okBtnFunctionClickTrue,
      VoidCallback? okBtnFunctionClickfulse,
      ) {
    showDialog(
        barrierDismissible: false,
        context: context,

        builder: (_) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            // title: Center(child: Text(title)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 8),
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: okBtnFunctionClickfulse,
                          child: Icon(
                            Icons.cancel,
                            color: title == "ensure_delete_account".tr
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                          ),
                        ))),
                new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Center(
                      child: Text(
                          msg.toString()
                      )),
                ),
                Container(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: okBtnFunctionClickTrue,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          decoration: BoxDecoration(
                            color: title == "ensure_delete_account".tr
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                            // border: Border.all(
                            //   color: Get.theme.backgroundColor.withOpacity(0.1),
                            // ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            buttom1,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }

}