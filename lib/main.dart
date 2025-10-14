import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/screens/auth/login/login_screen.dart';
import 'package:provider/screens/splash/splash_screen.dart';
import 'package:provider/utils/call_back_notification.dart';
import 'package:provider/utils/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'core/language/locale_string.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'utils/common.dart';

import 'core/connection_service/app_binding/initial_binding.dart';
import 'core/connection_service/injection_container.dart' as di;
import 'core/connection_service/firebase_setup.dart' as firebase;
import 'package:rxdart/subjects.dart';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';


Color colorBackGroundDark = Color.fromRGBO(
    17, 17, 17, 1.0) ;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message != null && message.data != null) {
    onClickToBackGroundNotifictain(message.data);
  }
}

onClickToBackGroundNotifictain(Map<String, dynamic> data) {
  if (data != null) {
    String msgType = data["notification_ref_type"].toString().trim();
    String target_id =  data["order_id"].toString().trim() ;
    print(data["ref_type"].toString().toString() + "FCM type");
    print(data["ref_id"].toString().toString() + "FCM ref_id");

    Get.offAll(SplashScreen(), arguments: [msgType, target_id, ""]);
  }else{
    Get.offAll(SplashScreen() );

  }
}

String? selectedNotificationPayload;

final BehaviorSubject<String> selectNotificationSubject =
BehaviorSubject<String>();
FirebaseMessaging? messaging;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
AndroidNotificationChannel? channel;

StreamController changeOrderController =
StreamController<ListinOrderNotification>();
StreamController changeAlertController =
StreamController<ListinAlertNotification>();
StreamController changeMessageController =
StreamController<ListinMessageNotification>();
void main() async{

 // customErrorScreen();

  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(SharedPreferences.getInstance);
  await di.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // await Firebase.initializeApp();

  if(kIsWeb){
    await Firebase.initializeApp();
  }else {
     await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await firebase.init();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage((message) async {
      await Firebase.initializeApp();
      _handleMessage(message);
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
                sound: RawResourceAndroidNotificationSound(
                    'slow_spring_board'),
                playSound: true,
                enableVibration: true,
                priority: Priority.high,
              ),
              iOS: darwinNotificationDetails,
            ));
      }



      if (message != null &&
          message.data["notification_ref_type"] != null &&
          message.data["notification_ref_type"].toString() == "1") {
        if (message.data["order_id"] != null) {
          int target_id = int.parse(message.data["order_id"].toString().trim());
          changeOrderController.add(new ListinOrderNotification(id: target_id));
        }
      }   else if (message != null &&
          message.data["notification_ref_type"] != null &&
          message.data["notification_ref_type"].toString() == "2") {
        if (message.data["order_id"] != null) {
          int target_id = int.parse(message.data["order_id"].toString().trim());
          changeMessageController
              .add(new ListinMessageNotification(id: target_id));
        }
      } else {
        changeAlertController.add(new ListinAlertNotification(id: 0));
      }

    });



  }

  void _handleMessage(RemoteMessage message) {
    if (message.data != null) {
      onClickToBackGroundNotifictain(message.data);
    }
  }

  @override
  void initState() {
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();
    setupInteractedMessage();
  }

  bool _notificationsEnabled = false;

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    double sizeHeight = 1.1;
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            transitionDuration: Duration(milliseconds: 250),
            debugShowCheckedModeBanner: false,
            translations: LocaleString(),
            locale: Locale('${Common.getLang()}', ''),
            opaqueRoute: Get.isOpaqueRouteDefault,
            color: Get.theme.primaryColor,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            home: child,
            themeMode: Common.getDarkMode() == false ? ThemeMode.light : ThemeMode.dark,
            initialBinding: InitialBinding(),
          );

        },
      child:  SplashScreen(),


    );
  }
}
