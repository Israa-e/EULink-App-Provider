import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/main.dart';
import 'package:provider/screens/splash/splash_controller.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
          //  backgroundColor: Platform.isAndroid == true ? colorBackGroundDark :null,
             resizeToAvoidBottomInset: false,

            body: Container(child: VideoPlayer(controller.controllerPlayer)),
          );
        });
  }
}
