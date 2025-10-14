import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const MaterialColor accentMaterialColor = MaterialColor(
  0xffffb600,
  <int, Color>{
    50: Color(0xffffb600),
    100: Color(0xffffb600),
    200: Color(0xffffb600),
    300: Color(0xffffb600),
    400: Color(0xffffb600),
    500: Color(0xffffb600),
    600: Color(0xffffb600),
    700: Color(0xffffb600),
    800: Color(0xffffb600),
    900: Color(0xffffb600),
  },
);
const Color primaryColor = Color(0xFFFFB600);
const Color primaryLightColor = Color(0xFF000000);
const Color primaryDarkColor = Color(0xFFFFFFFF);
const Color secondTextColor = Color(0xFFB3B3B3);
const Color inactiveTextColor = Color(0xFFD6DADE);
const Color activeTextColor = Color(0xFFFFB600);
const Color thirdTextColor = Color(0xFFD6DADE);
const Color cardTextColor = Color(0xFFFFFFFF);
const Color primBackgroundColor = Color(0xFF121212);
const Color secondBackgroundColor = Color(0xFF121212);
const Color inputPrimBackgroundColor = Color(0xFFFAFAFA);
const Color inputSecondBackgroundColor = Color(0xFFF3F4F5);
const Color inputTextColor = Color(0xFF4B4B4B);
const Color inputHintColor = Color(0xFF4B4B4B);
 Color cardColor = const Color(0xFFFFFFFF).withOpacity(0.05);
const brightness = Brightness.light;
const accentColor = accentMaterialColor;
Color lightColor = const Color(0xFFFFFFFF).withOpacity(0.05);
ColorScheme _customColorScheme = const ColorScheme(
  primary: primaryColor,
  secondary: Colors.amber,
  surface: Colors.white,
  background: primBackgroundColor,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.deepOrange,
  onSurface: primBackgroundColor,
  onBackground: primBackgroundColor,
  onError: Colors.redAccent,
  brightness: Brightness.light,
);

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: cardColor, // background color
  helpTextStyle: TextStyle(color: Colors.black, fontSize: 16.sp,fontWeight: FontWeight.bold), // help text style
  dialBackgroundColor: primaryColor.withOpacity(0.1), // dial background color
  // hourMinuteTextColor: Colors.black, // hour and minute text color
  entryModeIconColor: Colors.yellow,
  dayPeriodTextColor: Colors.black, // AM/PM text color
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.selected)
      ? primaryColor
      : primaryColor.withOpacity(0.2)),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.selected)
      ? Colors.white
      : Colors.black),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.selected)
      ? Colors.white
      : Colors.black),
  hourMinuteTextStyle: TextStyle(color:MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.selected)
      ? primaryColor
      : Colors.black), fontSize: 30.sp), // hour and minute text style
  dayPeriodTextStyle: TextStyle(color: MaterialStateColor.resolveWith((states) =>
  states.contains(MaterialState.selected)
      ? primaryColor
      : Colors.black), fontSize: 18.sp), // AM/PM text style
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // shape of the widget
);
ThemeData darkTheme() {
  double sizeHeight = Platform.isIOS ? 1.3 : 1.1;
  double sizeHeight2 = Platform.isIOS ? 1.2 : 1.1;
  return ThemeData(
    primarySwatch: accentColor,
    timePickerTheme: _timePickerTheme,
    primaryColorDark: primaryDarkColor,
    primaryColorLight: primaryLightColor,
    colorScheme: _customColorScheme,
    scaffoldBackgroundColor: primBackgroundColor,
    bottomAppBarTheme: const BottomAppBarTheme(color: primaryLightColor),
    dialogBackgroundColor: inactiveTextColor.withOpacity(0.2),
    brightness: brightness,
   /** appBarTheme: const AppBarTheme(
      backgroundColor: primaryLightColor,
    ),*/
    textTheme: TextTheme(
      displayLarge: TextStyle(color: primaryDarkColor, fontSize: 30.sp,fontWeight: FontWeight.w600, height: sizeHeight),
      displayMedium: TextStyle(color: secondTextColor, fontSize: 14.sp, fontWeight: FontWeight.w500, height: sizeHeight),
      displaySmall: TextStyle(color: secondTextColor, fontSize: 14.sp, fontWeight: FontWeight.w400, height: sizeHeight),
      headlineMedium: TextStyle(color: inputTextColor, fontSize: 14.sp, fontWeight: FontWeight.w400, height: sizeHeight),
      headlineSmall: TextStyle(color: inputHintColor, fontSize: 12.sp, fontWeight: FontWeight.w400, height: sizeHeight),
      titleLarge: TextStyle(color: primaryDarkColor, fontWeight: FontWeight.w700,fontSize: 18.sp,height: sizeHeight),
      titleMedium: TextStyle(color: secondTextColor, fontWeight: FontWeight.w400, fontSize: 14.sp,  height: sizeHeight2),
      titleSmall: TextStyle(color: primaryDarkColor, fontWeight: FontWeight.w500, fontSize: 12.sp, height: sizeHeight2),
      bodyLarge: TextStyle(color: primBackgroundColor,fontSize: 16.sp,fontWeight: FontWeight.w600, height: sizeHeight2),
      bodyMedium: TextStyle(color:primaryDarkColor, height: sizeHeight2),
      labelLarge: TextStyle(color: inactiveTextColor, height: sizeHeight),
      labelMedium: TextStyle(color: thirdTextColor, height: sizeHeight),
      labelSmall: TextStyle(height: sizeHeight2, color: primaryDarkColor)
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),


    primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      color: Colors.black,
      foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.black,
          systemNavigationBarColor: Colors.black),
    ),

    cardTheme:  CardTheme(
      elevation: 2,
      color:cardColor,
    ),
    iconTheme: const IconThemeData(
      color: secondTextColor,
    ),
    primaryColor: primaryColor,
    fontFamily: 'Poppins',
    cardColor: cardColor,
  );
}
