import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Slider;
import 'package:get/get.dart';
import 'package:provider/models/brand/brand_model.dart';
import 'package:provider/models/brand/brands_response.dart';
import 'package:provider/models/install/slider_model.dart';
import 'package:provider/models/install/sliders_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/authentication/provider.dart' hide Locale;
import '../models/install/social_response.dart';
import '../models/splash/splash_response.dart';

class Common {
  static headers() {
     print('Bearer ${Common.getUser()?.data!.login!.accessToken}');
    // print('Bearer ${getLang()}');
    return Common.getUser() != null && Common.getUser()!.data!.login != null
        ? {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization':
                'Bearer ${Common.getUser()?.data!.login!.accessToken}',
            "Accept-Language": getLang(),
            "X-localization": getLang(),
            "app_locale": getLang(),
          }
        : {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-localization": getLang(),
            "Accept-Language": getLang(),
            "app_locale": getLang(),
          };
  }

  static headersMultipartFile() {
    print('Bearer ${Common.getUser()?.data!.login!.accessToken}');
    return Common.getUser() != null
        ? {
            "Content-Type": "application/json",
            "Accept": "multipart/form-data",
            'Authorization':
                'Bearer ${Common.getUser()?.data!.login!.accessToken}',

            //  "Accept-Language": getLang(),
            //  "X-localization": getLang(),
            //  'authorization': 'Bearer ${Common.getUser()!.accessToken.toString()}',
            //  "device_type": Platform.isIOS ? "ios" : "android",
            // "x-device-token": getDeviceToken(),
            // "x-device-platform": Platform.isIOS ? "ios" : "android",
          }
        : {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "X-localization": getLang(),
            // "Accept-Language": getLang(),
            // "device_type": Platform.isIOS ? "ios" : "android",
            // "x-device-token": getDeviceToken(),
            // "x-device-platform": Platform.isIOS ? "ios" : "android",
            // 'authorization': basicAuth
          };
  }

  static String? getDeviceToken() {
    // return true;
    String? DeviceToken =
        Get.find<SharedPreferences>().getString("DeviceToken");
    if (DeviceToken == null || DeviceToken.isEmpty) {
      DeviceToken = null;
    }
    return DeviceToken;
  }

  static Future<void> setDeviceToken({required String DeviceToken}) async {
    //  print("DeviceToken # "+DeviceToken.toString());
    await Get.find<SharedPreferences>().setString("DeviceToken", DeviceToken);
  }

  static ProviderResponse? getUser() {
    return Get.find<SharedPreferences>().get("USER") == null ||
            Get.find<SharedPreferences>().get("USER") == ""
        ? null
        : ProviderResponse.fromJson(
            jsonDecode(Get.find<SharedPreferences>().get("USER").toString()));
  }

  static Future<void> setUserModel({required ProviderResponse user}) async {
    await Get.find<SharedPreferences>()
        .setString("USER", user == null ? "" : jsonEncode(user));
  }

  static setLanguage(language) async {
    await Get.find<SharedPreferences>().setString("Language", language);
  }

  static getLanguage() {
    String? language = Get.find<SharedPreferences>().getString("Language");
    return language ?? getSplash()?.data.locales.first.name;
  }

  static setSubscription(subscription) async {
    await Get.find<SharedPreferences>().setBool("Subscription", subscription);
  }

  static getSubscription() {
    bool? subscription = Get.find<SharedPreferences>().getBool("Subscription");
    return subscription ?? false;
  }

  static Future<void> setSplashModel({required SplashResponse splash}) async {
    await Get.find<SharedPreferences>()
        .setString("Splash", splash == null ? "" : jsonEncode(splash));
  }

  static SplashResponse? getSplash() {
    return Get.find<SharedPreferences>().get("Splash") == null ||
            Get.find<SharedPreferences>().get("Splash") == ""
        ? null
        : SplashResponse.fromJson(
            jsonDecode(Get.find<SharedPreferences>().get("Splash").toString()));
  }

  // delete
  static int? getvisitorId() {
    return Get.find<SharedPreferences>().getInt("vistor_id") == null ||
            Get.find<SharedPreferences>().getInt("vistor_id") == 0
        ? 0
        : Get.find<SharedPreferences>().getInt("vistor_id");
  }

  static Future<bool> setChooseService({good}) async {
    await Get.find<SharedPreferences>().setBool("Service", true);
    return true; // Return a boolean value after setting the shared preferences
  }

  static Future<bool?>? getChooseService() async {
    return Get.find<SharedPreferences>().getBool("Service");
  }

  static Future<void> setVisitor({required int vistor_id}) async {
    await Get.find<SharedPreferences>()
        .setInt("vistor_id", vistor_id == null ? 0 : vistor_id);
  }

  static void setSettingModel({required SocialResponse settingModel}) {
    Get.find<SharedPreferences>().setString(
        "Setting", settingModel == null ? "" : jsonEncode(settingModel));
  }

  static SocialResponse? getInstill() {
    return Get.find<SharedPreferences>().get("Setting") == null ||
            Get.find<SharedPreferences>().get("Setting") == ""
        ? null
        : SocialResponse.fromJson(jsonDecode(
            Get.find<SharedPreferences>().get("Setting").toString()));
  }

  static void setSlidersModel({required SlidersResponse slidersModel}) {
    Get.find<SharedPreferences>().setString(
        "slidersModel", slidersModel == null ? "" : jsonEncode(slidersModel));
  }

  static SlidersResponse? getSlidersModel() {
    return Get.find<SharedPreferences>().get("slidersModel") == null ||
            Get.find<SharedPreferences>().get("slidersModel") == ""
        ? null
        : SlidersResponse.fromJson(jsonDecode(
            Get.find<SharedPreferences>().get("slidersModel").toString()));
  }

  static void setBrandsModel({required BrandsResponse brandsModel}) {
    Get.find<SharedPreferences>().setString(
        "brandsModel", brandsModel == null ? "" : jsonEncode(brandsModel));

    cachImages();
  }

  static BrandsResponse? getBrandsModel() {
    return Get.find<SharedPreferences>().get("brandsModel") == null ||
            Get.find<SharedPreferences>().get("brandsModel") == ""
        ? null
        : BrandsResponse.fromJson(jsonDecode(
            Get.find<SharedPreferences>().get("brandsModel").toString()));
  }

  static void cachImages() {
    if (getBrandsModel() != null && getBrandsModel()!.data != null) {
      List<Brand> brandsList = getBrandsModel()!.data!;
      if (brandsList.length > 0) cachImagesBrand(brandsList);
    }
  }

  static void cachImagesBrand(List<Brand> brandsList) {
    brandsList.forEach((element) async {
      if (element.extra_image != null) {
        await CachedNetworkImageProvider(element.extra_image.toString(),
            cacheKey: element.extra_image.toString());
        // print(element.extra_image.toString());
      }
    });

    if (getSlidersModel() != null && getSlidersModel()!.data != null) {
      List<Slider> slidersList = getSlidersModel()!.data!;
      if (slidersList.length > 0) cachImagesSlider(slidersList);
    }
  }

  static void cachImagesSlider(List<Slider> slidersList) {
    slidersList.forEach((element) async {
      if (element.image != null) {
        await CachedNetworkImageProvider(element.image.toString(),
            cacheKey: element.image.toString());
        //  print(element.image.toString());
      }
    });
  }

// end delete

  static Future<void> clearUserModel() async {
    await Get.find<SharedPreferences>().setString("USER", "");
    await Get.find<SharedPreferences>().setBool("Subscription", false);
  }

  static bool getDarkMode() {
    // return true;
    bool? IsDark = Get.find<SharedPreferences>().getBool("dark_mode");
    if (IsDark == null) {
      if (Get.isDarkMode) {
        return true;
      } else
        return false;
    }
    return IsDark;
  }

  static Future<void> setDarkMode({required bool isDark}) async {
    await Get.find<SharedPreferences>().setBool("dark_mode", isDark);
  }

  static void changeLanguage(
      BuildContext context, String lang, void Function() callBack) {
    if (lang == "en") {
      Common.setLang(lang: "en");
      setLang(lang: "en");
      Get.updateLocale(Locale('en'));
    } else if (lang == "ar") {
        Common.setLang(lang: "ar");
        setLang(lang: "ar");
        Get.updateLocale(Locale('ar'));
        }
    else if (lang == "pl") {
      Common.setLang(lang: "pl");
      setLang(lang: "pl");
      Get.updateLocale(Locale('pl'));
    } else if (lang == "fr") {
      Common.setLang(lang: "fr");
      setLang(lang: "fr");
      Get.updateLocale(Locale('fr'));
    }else if (lang == "nl") {
      Common.setLang(lang: "nl");
      setLang(lang: "nl");
      Get.updateLocale(Locale('nl'));
    }

    lang = Common.getLang();
    callBack();
  }

  static Future<void> setIsFirstLaunch() async {
    await Get.find<SharedPreferences>().setBool("IsFirstLaunch", false);
  }

  static bool getIsFirstLaunch() {
    bool? IsFirstLaunch =
        Get.find<SharedPreferences>().getBool("IsFirstLaunch");
    print("IsFirstLaunch # " + IsFirstLaunch.toString());
    if (IsFirstLaunch == null) {
      return true;
    }
    return IsFirstLaunch;
  }

  static Future<void> setIsShowGuide() async {
    await Get.find<SharedPreferences>().setBool("IsShowGuide", true);
  }

  static bool getIsShowGuide() {
    bool? IsFirstLaunch = Get.find<SharedPreferences>().getBool("IsShowGuide");
    print("IsShowGuide # " + IsFirstLaunch.toString());
    if (IsFirstLaunch == null) {
      return false;
    }
    return IsFirstLaunch;
  }

  static Locale locale = Locale("ar", "SA");

  static Future<void> setLang({required String lang}) async {
    await Get.find<SharedPreferences>()
        .setString("language", lang == null ? "" : lang);
  }

  static String getLang() {
    //  return "en";
    String? lang = Get.find<SharedPreferences>().getString("language");
    if (lang == null || lang.isEmpty) {
      if (Get.deviceLocale != null && Get.deviceLocale!.languageCode != null) {
        if (Get.deviceLocale!.languageCode.contains("en")) {
          return "en";
        }
        /** if (Get.deviceLocale!.languageCode.contains("ar")) {
            return "ar";
            }*/
        if (Get.deviceLocale!.languageCode.contains("fr")) {
          return "fr";
        }
        if (Get.deviceLocale!.languageCode.contains("pl")) {
          return "pl";
        }
        if (Get.deviceLocale!.languageCode.contains("ar")) {
          return "ar";
        }
        if (Get.deviceLocale!.languageCode.contains("nl")) {
          return "nl";
        }
      }

      return "en";
    }
    return lang != null ? lang : "en";
  }
}
