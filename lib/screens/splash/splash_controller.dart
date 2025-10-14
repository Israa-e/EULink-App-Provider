import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/main.dart';
import 'package:provider/models/auth/register_response.dart';
import 'package:provider/models/authentication/provider.dart';
import 'package:provider/screens/auth/choose_service/choose_service.dart';
import 'package:provider/screens/auth/complete_profile/complete_profile.dart';
import 'package:provider/screens/menu_screens/subscription_case/subscription_case.dart';
import 'package:provider/screens/pager/pager.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/utils/helper.dart';
import 'package:video_player/video_player.dart';

import '../../core/connection_service/api/info_api.dart';
import '../../models/splash/splash_response.dart';
import '../auth/login/login_screen.dart';
import '../auth/sign_up/sing_up_screen.dart';
import '../menu_screens/subscription/subscription.dart';

class SplashController extends GetxController {
  RemoteMessage? fmessage = null;

  Future<void> setupInteractedMessage() async {
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      sound: 'slow_spring_board.aiff',
      threadIdentifier: 'thread_id',
      presentSound: true,
      presentAlert: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel!.id,
                  channel!.name,
                  importance: Importance.max,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: '@mipmap/ic_launcher',
                  sound:
                      RawResourceAndroidNotificationSound('slow_spring_board'),
                  playSound: true,
                  enableVibration: true,
                  priority: Priority.high,
                ),
                iOS: darwinNotificationDetails),
            payload: message.data.toString());
      }
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    await Firebase.initializeApp();

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    _handleMessage(message);
  }

  void _handleMessage(RemoteMessage message) {
    fmessage = message;
    print(fmessage.toString() + "FCM fmessage");
  }

  onClickToBackGroundNotifictain(Map<String, dynamic> data) {
    int msgType = int.tryParse(data["notification_ref_type"].toString())??0;
    int target_id = int.tryParse(data["order_id"].toString())??0;

    if(msgType != 0) {
      if (msgType == 1) {
        goToOrderDetailsViewClose(target_id);
      } else if (msgType == 2) {
        //Chat
        goToMassegeViewClose(target_id);
      }
    }else{
      fmessage = null ;
      update();
      goToNext();
    }
  }

  FirebaseMessaging? _firebaseMessaging = null;

  String _token = "";
  late VideoPlayerController controllerPlayer;

  @override
  void dispose() {
    super.dispose();
    controllerPlayer.dispose();
  }

  bool isCompleteVideo = false;
  bool isCompleteVideoDark = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    changeStatusBarColor();

    setupInteractedMessage();


    /** SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));*/
    isCompleteVideoDark = false;
    isCompleteVideo = false;
    controllerPlayer = VideoPlayerController.asset(
      'assets/media/EU-Link.mp4',
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );

    controllerPlayer.setLooping(false);
    controllerPlayer.setVolume(0.0);

    controllerPlayer.initialize().whenComplete(() {
      Future.delayed(
              controllerPlayer.value.duration - controllerPlayer.value.position)
          .whenComplete(() {
        isCompleteVideo = true;
        update();
        goToNext();
      });

      update();
    });
    controllerPlayer.play();

    if (Common.getUser() != null) {
      if (Get.arguments != null &&
          Get.arguments[0] != null &&
          Get.arguments[1] != null) {

        int msgType = int.tryParse(Get.arguments[0].toString())??0  ;
        int target_id = int.tryParse(Get.arguments[1].toString())??0 ;

        await Future.delayed(Duration(seconds: 1));
        if (msgType == 1) {
          goToOrderDetailsViewClose(target_id);
        } else if (msgType == 2) {
          goToMassegeViewClose(target_id);
        } else {
          print("iam NOOO on arg # ");
          splashResponse();
        }
      } else {
        print("iam NOOO 2 on arg # ");
        splashResponse();
      }
    } else {
      print("iam NOOO 3 on arg # ");
      splashResponse();
    }

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.getToken().then((token) async {
      _token = token!;
      await Common.setDeviceToken(DeviceToken: _token);
    });

    Future.delayed(Duration(seconds: 3)).then((value) {
      isCompleteVideoDark = true;
      isCompleteVideo = true;
      update();
    });
  }

  bool isCompleteData = false;

  goToNext() {
    if (isCompleteVideo == true && isCompleteData == true) {
      Future.delayed(Duration(milliseconds: 100)).then((value) {
        if (Common.getUser() != null && Common.getUser()!.data!.login != null) {
          if (fmessage != null && fmessage!.data != null) {
            onClickToBackGroundNotifictain(fmessage!.data);
          } else {
            if (Common.getUser()!.data!.provider!.hourlyRate != null &&
                Common.getUser()!.data!.provider!.identity != null &&
                Common.getUser()!.data!.provider!.identity.toString() !=
                    confing.baseUrl &&
                Common.getUser()!.data!.provider!.services != null &&
                Common.getUser()!.data!.provider!.services!.length > 0) {
              if (Common.getUser()!.data!.provider!.subscriptionStatus ==
                  false) {
                Get.offAll(Subscription(),
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 300),
                    arguments: [true]);
              } else {
                if (Common.getUser()!.data!.provider!.subscriptionStatus ==
                        true &&
                    Common.getUser()!.data!.provider!.subscription != null &&
                    Common.getUser()!.data!.provider!.subscription!.status ==
                        0) {
                  Get.offAll(() => const SubscriptionCase(),
                      transition: Transition.fade, arguments: [true]);
                } else {
                  Get.offAll(() => const Pager(selected: 0),
                      transition: Transition.fade);
                }
              }
            } else {
              if (Common.getUser()!.data!.provider!.hourlyRate == null ||
                  Common.getUser()!.data!.provider!.identity == null ||
                  Common.getUser()!.data!.provider!.identity.toString() ==
                      confing.baseUrl) {
                Get.offAll(() => const CompleteProfile(),
                    transition: Transition.fade);
              } else if (Common.getUser()!.data!.provider!.services == null ||
                  Common.getUser()!.data!.provider!.services!.length == 0) {
                Get.offAll(() => const ChooseService(),
                    transition: Transition.fade, arguments: ["add"]);
              } else {
                Get.offAll(() => const CompleteProfile(),
                    transition: Transition.fade);
              }
            }
          }
        } else {
          Get.offAll(SingUpScreen(), transition: Transition.fade);
        }
      });
    }
  }

  Future<void> myUser() async {
    await Get.find<AuthApi>().myUser()
      ..fold(onErrorMyUser, onSuccessMyUser);
  }

  onSuccessMyUser(ProviderResponse data) async {
    if (data.data != null) {
      isCompleteData = true;
      ProviderResponse? provider = Common.getUser();
      if (provider!.data!.login == null) {
        await Common.clearUserModel();
      } else {
        if (provider != null) {
          provider.data!.provider = data.data!.provider;
          //provider.data!.provider!.avatar ="https://api.eulink.app/";
          await Common.setUserModel(user: provider).then((value) {});
        } else {
          await Common.clearUserModel();
        }
      }
    } else {
      await Common.clearUserModel();
    }

    update();
    goToNext();
  }

  onErrorMyUser(failure) async {
    if (failure.toString().contains("unauthenticated")) {
      Common.clearUserModel();
    }
    isCompleteData = true;
    update();
    goToNext();
  }

  Future<void> splashResponse() async {
    await Get.find<InfoApi>().splash()
      ..fold(onError, onSuccess);
  }

  onSuccess(SplashResponse data) async {
    print("splash ## " + data.toJson().toString());
    if (data.success == true) {
      await Common.setSplashModel(splash: data).then((value) {});
      //  isCompleteData = true;
      if (Common.getUser() != null) {
        myUser();
      } else {
        isCompleteData = true;
        goToNext();
      }
    }
    update();
  }

  onError(failure) async {
    print("splash ## " + failure.toString());
    if (failure.toString().contains("Unauthenticated")) {
      await Common.clearUserModel();
    }
    goToNext();
  }
}
