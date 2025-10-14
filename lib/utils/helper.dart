import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/screens/home/order_details/order_details.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../screens/home/chat/chat.dart';

class Helper {
  static WidgetsBinding ensureInitialized() {
    if (WidgetsBinding.instance == null) {
      WidgetsFlutterBinding();
    }
    return WidgetsBinding.instance;
  }

  static ShowSnackBarFailure({required String title, required String? body}) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        body ?? "",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 4,
        textAlign: TextAlign.start,
      ),
      padding: EdgeInsets.only(top: 24, bottom: 0, left: 8, right: 8),
      backgroundColor: Colors.white,
      colorText: Colors.red,
    );
  }

  static ShowSnackbarFailureAwait(
      {required String title, required String body}) async {
    await Get.snackbar(
      "",
      "",
      titleText: Text(
        body,
        style: TextStyle(color: Colors.white, fontSize: 11),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(top: 24, bottom: 0, left: 8, right: 8),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
  static ShowSnackbarFailureCenter({required String title, required String body}) {
    Get.snackbar(
      "",
      "",
      titleText: Text(handlingFailureRespose(body),style: TextStyle(color: Colors.white ,fontSize: 11),textAlign: TextAlign.center,),
      padding: EdgeInsets.only(top: 24,bottom: 0 ,left: 8,right: 8),
      backgroundColor: Colors.red,
      colorText: Colors.white,

    );
  }
  /**static ShowSnackbarFailureCenter(
      {required String title, required String body}) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        handlingFailureRespose(body)  ,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(top: 24, bottom: 0, left: 8, right: 8),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
*/
  /**
  static ShowSnackbarSuccessCenter(
      {required String title, required String body}) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        body,
        style: TextStyle(
            color: Get.theme.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(top: 24, bottom: 0, left: 8, right: 8),
      backgroundColor: Colors.white,
      colorText: Get.theme.primaryColor,
    );
  }

  */
  static ShowSnackbarSuccessCenter({required String title, required String body}) {

    Get.snackbar(
      "",
      "",
      titleText: Text(body,style: TextStyle(color: Colors.white ,fontSize: 11),textAlign: TextAlign.center,),
      padding: EdgeInsets.only(top: 24,bottom: 0 ,left: 8,right: 8),
      backgroundColor: Colors.green,
      colorText: Colors.white,

    );
  }
  static ShowSnackbarSuccessCenterAwait({required String title, required String body}) async {

    await Get.snackbar(
      "",
      "",
      duration: Duration(seconds: 2),
      titleText: Text(body,style: TextStyle(color: Colors.white ,fontSize: 11),textAlign: TextAlign.center,),
      padding: EdgeInsets.only(top: 24,bottom: 0 ,left: 8,right: 8),
      backgroundColor: Colors.green,
      colorText: Colors.white,

    );
  }



  static ShowSnackbarInfo({required String title, required String body}) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        body,
        style: TextStyle(color: Colors.white, fontSize: 11),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(top: 24, bottom: 0, left: 8, right: 8),
      backgroundColor: Colors.amber,
      colorText: Colors.white,
    );
  }

  static ShowSnackbarSuccess({required String title, required String body}) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        body,
        style: TextStyle(
            color: Colors.white,
            fontSize: 12, ),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(top: 24, bottom: 0, left: 8, right: 8),
      backgroundColor: Colors.green,
      colorText: Get.theme.primaryColor,
    );
  }

  static ShowSnackbarSuccessAwait(
      {required String title, required String body}) async {
    await Get.snackbar(
      title,
      body,
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
    );
  }
}

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor.toString(); // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id.toString(); // unique ID on Android
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Future<void> disableCapture() async {
  //disable screenshots and record screen in current screen
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

String replaceEnglishNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(arabic[i], english[i]);
  }
  return input;
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

 goTo(screen) {
return  Get.to(() => screen,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300));
}

String? getKeyForValue(int? value) {
  Map<String, dynamic>? map =
  Common.getSplash()?.data.enums.orderStatusEnum.toJson();
  for (String key in map!.keys) {
    if (map[key] == value) {
      return key;
    }
  }
  return null; // Value not found in map
}
Widget viewStatusOrder(int status,double? marginStart ){

  Color color = const Color(0xFF44B75D) ;
  if(status ==0){
    color =   const Color(0xFF44B75D) ;
  }else if(status ==1){
    color =  Colors.orangeAccent;

  }else if(status ==1){
    color =  const Color(0xFF44B75D) ;

  }else if(status ==2){
    color =  const Color(0xFF44B75D) ;

  }else if(status ==3){
    color =    Colors.red ;

  }else if(status ==4){
    color =   Colors.red ;

  }else if(status ==5){
    color = Colors.orangeAccent;

  }else if(status ==6){
    color = const Color(0xFF44B75D) ;

  }else if(status ==7){
    color = Colors.red ;

  }
  var context = Get.context as BuildContext ;
  return  Container(
    margin:   EdgeInsets.only(right: marginStart == null ?0 : marginStart),
    padding: EdgeInsets.symmetric(
        horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: CustomText(
        text:
        "${ getKeyForValue(status)}".tr,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
          color: color,
        )),
  ) ;

}

String convertDateFormatToDate(DateTime? dateTime) {
  initializeDateFormatting();
  return dateTime == null ? "-- -- --":DateFormat('yyyy-MM-dd ', "en").format(dateTime).toString();
}

String convertDateFormatToDateTime(DateTime? dateTime) {
  initializeDateFormatting();

  return dateTime == null ? "-- -- --" : DateFormat(
      'dd-MM-yyyy    HH:MM a ' ).format(dateTime).toString();

}

String ConvertDateFormatToTime(DateTime? dateTime) {
  initializeDateFormatting();
  return dateTime == null ? "-- -- --":DateFormat('yyyy-MM-dd', "en").format(dateTime).toString();
}
String getEndAfferByDate(DateTime? dateTime    ) {
  initializeDateFormatting();
  print("ddd " + dateTime.toString());
  if (dateTime != null) {



    //
    print("inMinutes " +
        dateTime.difference(DateTime.now()).inMinutes.toString());

    int inMinutes = DateTime.now().difference(dateTime ).inMinutes.round();


    print("inMinutes " +inMinutes.toString() + "fff");
    if (inMinutes >= 0) {
      return getRemainingTime(inMinutes ,dateTime);
    } else
      initializeDateFormatting();
    return  DateFormat('yyyy-MM-dd HH:MM a', "en").format(dateTime).toString()  ;
  } else {
    return ""  ;
  }
}
String getRemainingTime(int duration ,DateTime? dateTime) {

  int days = duration ~/ 1440;
  int hours;
  duration = duration - (1440 * days);
  hours = duration ~/ 60;
  duration = duration - (60 * hours);

  String dateString;

  if (days == 0) {

    String hourStr = "";
    String minStr = "";


    if(hours > 0){

      if(duration>0){
        minStr =  "& "+duration.toString()+" "+"min".tr;
      }
      //initializeDateFormatting();
      hourStr = ""+   DateFormat('HH:MM', "en").format(dateTime!).toString()  ;  //hourStr + minStr ;
    }else{
      minStr = duration !=0 ? duration.toString()+" "+"min".tr:"New".tr;
      hourStr = hourStr + minStr ;
    }


    dateString =  hourStr ;
  } else {
    dateString = DateFormat('yyyy-MM-dd HH:MM a', "en").format(dateTime!).toString()  ;

  }

  return dateString;
}


String handlingFailureRespose(failure){

  if(failure.toString() !=null && failure.toString().contains("success") && failure.toString().contains("message")){
    RootResponse response = RootResponse.fromJson(failure.toString()) ;

    return response.getMessageList.toString() ;
  }else if(failure.toString().startsWith("[") && failure.toString().endsWith("]") ){
    failure = failure.toString().replaceAll("[", "");
    failure =failure.toString().replaceAll("]", "");

    return failure.toString() ;
  }else{
    return failure.toString() ;

  }
}




Future<void> goToOrderDetailsViewNotClose(int itemid) async {

  await Get.to(
          () => OrderDetails(
        index: itemid,
        UserId: Common.getUser()!.data!.provider!.id,
      ),
      transition:
      Transition.rightToLeft,
      duration: const Duration(
          milliseconds: 300),
  arguments: [itemid, true]);

}

Future<void> goToMassegeViewNotClose(int id) async {
 // await Get.to(ChatScreen(), arguments: [chatRoom, true]);
  Get.to(
          () => Chat(),
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 300),
      arguments: [id,true]);
}




Future<void> goToOrderDetailsViewClose(int itemid) async {

  await Get.offAll(
          () => OrderDetails(
        index: itemid,
        UserId: Common.getUser()!.data!.provider!.id,
      ),
      transition:
      Transition.rightToLeft,
      duration: const Duration(
          milliseconds: 300),
      arguments: [itemid, false]);

}

Future<void> goToMassegeViewClose(int id) async {
  // await Get.to(ChatScreen(), arguments: [chatRoom, true]);
  Get.offAll(
          () => Chat(),
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 300),
      arguments: [id,false]);
}

  String? validateDate(String value) {
if (value.isEmpty) {
return "Required";
}

int year;
int month;
// The value contains a forward slash if the month and year has been
// entered.
if (value.contains(new RegExp(r'(\/)'))) {
var split = value.split(new RegExp(r'(\/)'));
// The value before the slash is the month while the value to right of
// it is the year.
month = int.parse(split[0]);
year = int.parse(split[1]);
} else {
// Only the month was entered
month = int.parse(value.substring(0, (value.length)));
year = -1; // Lets use an invalid year intentionally
}

if ((month < 1) || (month > 12)) {
// A valid month is between 1 (January) and 12 (December)
return 'Invalid month';
}

var fourDigitsYear = convertYearTo4Digits(year);
if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
// We are assuming a valid year should be between 1 and 2099.
// Note that, it's valid doesn't mean that it has not expired.
 // return 'Expiry year is invalid';
  return 'Invalid year';
}

if (!hasDateExpired(month, year)) {
return "Card expired";
}
return null;
}

/// Convert the two-digit year to four-digit year if necessary
  int convertYearTo4Digits(int year) {
if (year < 100 && year >= 0) {
var now = DateTime.now();
String currentYear = now.year.toString();
String prefix = currentYear.substring(0, currentYear.length - 2);
year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
}
return year;
}

  bool hasDateExpired(int month, int year) {
return isNotExpired(year, month);
}

  bool isNotExpired(int year, int month) {
// It has not expired if both the year and date has not passed
return !hasYearPassed(year) && !hasMonthPassed(year, month);
}

  bool hasMonthPassed(int year, int month) {
var now = DateTime.now();
// The month has passed if:
// 1. The year is in the past. In that case, we just assume that the month
// has passed
// 2. Card's month (plus another month) is less than current month.
return hasYearPassed(year) ||
convertYearTo4Digits(year) == now.year && (month < now.month + 1);
}

  bool hasYearPassed(int year) {
int fourDigitsYear = convertYearTo4Digits(year);
var now = DateTime.now();
// The year has passed if the year we are currently, is greater than card's
// year
return fourDigitsYear < now.year;
}


Future<void>  getStoragePermission({required  Function() onTrue }
) async {
  if(Platform.isAndroid) {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if (android.version.sdkInt < 33) {
      if (await Permission.storage
          .request()
          .isGranted) {
        onTrue();
      } else if (await Permission.storage
          .request()
          .isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage
          .request()
          .isDenied) {
        await Permission.storage.request();
      }
    } else {
      if (await Permission.photos
          .request()
          .isGranted) {
        onTrue();
      } else if (await Permission.photos
          .request()
          .isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.photos
          .request()
          .isDenied) {
        await Permission.storage.request();
      }
    }
  }else{
    if (await Permission.storage
        .request()
        .isGranted) {
      onTrue();
    } else if (await Permission.storage
        .request()
        .isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage
        .request()
        .isDenied) {
      await Permission.storage.request();
    }
  }
}

changeStatusBarColor(){
  if(Common.getDarkMode() ==true ){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor:  Colors.black,
      //systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,

    ));
  }else{
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,

      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor:  Colors.white,
       //systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,

    ));
  }

}