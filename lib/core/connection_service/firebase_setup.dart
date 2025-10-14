import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/main.dart';

import '../../screens/splash/splash_screen.dart';
Future<void> init() async {

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel_111', // id
      'High Importance Notifications', // title // description
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      playSound: true,
      enableVibration: true,
    );
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        String? payload = notificationResponse.payload;
        if (payload != null && payload.toString().isNotEmpty) {

          payload = payload.toString().replaceAll("{", "");
          payload = payload.toString().replaceAll("}", "");
          var dataSp = payload.split(',');
          Map<String, dynamic> mapData = Map();
          dataSp.forEach((element) =>
          mapData[element.toString().trim().split(':')[0]] =
          element.toString().trim().split(':')[1]);

          onClickToBackGroundNotifictain(mapData);
        } else {
          Get.offAll(SplashScreen());
        }

        selectedNotificationPayload = payload;
        selectNotificationSubject.add(payload!);
      });
  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(
    sound: 'slow_spring_board.aiff',
    threadIdentifier: 'thread_id',
    presentSound: true,
    presentAlert: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    AndroidNotification? android = message.notification!.android;
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
              sound: RawResourceAndroidNotificationSound('slow_spring_board'),
              playSound: true,
              enableVibration: true,
              priority: Priority.high,
            ),
            iOS: darwinNotificationDetails,
          ));
    }





  });
}
void onDidReceiveLocalNotification(
    int? id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  showDialog(
    context: Get.context as BuildContext,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title.toString()),
      content: Text(body.toString()),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SplashScreen(),
              ),
            );
          },
        )
      ],
    ),
  );
}