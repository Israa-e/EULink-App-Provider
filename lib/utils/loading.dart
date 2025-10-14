import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/utils/common.dart';



class Loading extends StatefulWidget {
  Loading({Key? key}) : super(key: key);

  static void show({Key? key}) => Get.dialog(Loading(
        key: key,
      ));
   static Future<void> hide() async {
    bool?   isShow = Get.isDialogOpen ;
    while(isShow == true){
        if (Get.isDialogOpen == true) {
          await Future.delayed(Duration(milliseconds: 200));
          if (Get.isSnackbarOpen == null || !Get.isSnackbarOpen ) {
            Get.back();
            isShow = false;
          }
        }
    }



  }


  @override
  _LoadingState createState() => _LoadingState();
}

bool isShow = false;

class _LoadingState extends State<Loading> {
  @override
  void setState(VoidCallback fn) {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    isShow = true;
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    isShow = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    return Scaffold(
     backgroundColor: Colors.transparent,
      body:WillPopScope(
        onWillPop: () async => true,
        child:GestureDetector(
          onVerticalDragUpdate: (details) {},
          onHorizontalDragEnd: (details) {
            if (Platform.isIOS) {
              if (Common.getLang() == "ar") {
                if (details.primaryVelocity == null) return;
                if (details.primaryVelocity! < 0) {
                  // drag from right to left
                  Get.back( );
                } else {
                  // drag from left to right

                }
              } else {
                if (details.primaryVelocity == null) return;
                if (details.primaryVelocity! < 0) {
                  // drag from right to left
                } else {
                  Get.back( );
                }
              }
            }
          },
          child: Container(
            //color: Colors.black.withOpacity(0.4),
            child: Container(
              height: Get.height,
              child: Center(
                child: CircularProgressIndicator(), 
              ),
            ),
          ),
        ),
      ),
    );
  }
}
