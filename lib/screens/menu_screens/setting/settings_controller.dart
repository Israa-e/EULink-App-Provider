import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/models/authentication/provider.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/models/splash/splash_response.dart';
import 'package:provider/screens/auth/login/login_screen.dart';
import 'package:provider/screens/splash/splash_screen.dart';
import 'package:provider/utils/loading.dart';
import 'package:provider/widgets/dialog_login_after.dart';

import '../../../utils/common.dart';
import '../../../utils/helper.dart';

class SettingsController extends GetxController{
  bool isUpdate = false;
 String getLanguage=Common.getLanguage();
  void chaneTheme(bool isDark) {
    isUpdate = true ;
    Common.setDarkMode(isDark: isDark);

    ThemeMode themeMode = isDark == false ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(themeMode);

     update();
  }

  Provider? user;
  List<Locales> locales = [];

  @override
  void onInit() async {
    super.onInit();


    if (Common.getUser() != null) {
      user = Common.getUser()!.data!.provider;
      setDataToView();
    }
  }
  void setDataToView() {
    if(Common.getSplash()!.data.locales  != null &&
        Common.getSplash()!.data.locales .length>0)
      locales =  Common.getSplash()!.data.locales   ;
    if(user != null){
      if(user!.localeId != null){
        if(locales.where((element) => element.id.toString() == user!.localeId.toString() ).length >0){
          locales.where((element) => element.id.toString() == user!.localeId.toString() ).last.isSelect = true ;
          getLanguage = locales.where((element) => element.isSelect == true).first.name.toString();
          update();
        }
      }
    }


  }

  Future<void> logout() async {
    Loading.show();
    update();

    await Get.find<AuthApi>().logout()
      ..fold(onError, onSuccess);
  }

  LogOut() async {
    await Common.clearUserModel();

    update();

    Get.offAll(SplashScreen());
  }

  onSuccess(RootResponse data) async {
    Loading.hide();
    await Future.delayed(Duration(milliseconds: 200), () {});

    LogOut();
  }

  onError(failure) async {
    print('failll $failure');
    Loading.hide();

    await Future.delayed(Duration(milliseconds: 200), () {});


    LogOut();
  }
  Future<void> deleteAccount(BuildContext context) async {
    Loading.show();
    update();

    await Get.find<AuthApi>().logout()
      ..fold(onError , onSuccess );
  }

}