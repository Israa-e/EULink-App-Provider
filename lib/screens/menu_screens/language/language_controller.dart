import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/models/authentication/provider.dart';
import 'package:provider/models/splash/splash_response.dart';
import 'package:provider/screens/splash/splash_screen.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/helper.dart';
import 'package:provider/utils/loading.dart';



class LanguageController extends GetxController {
  String language = Common.getLang();

  Provider? user;
  List<Locales> locales = [];
  Rx<TextEditingController> searchController = new TextEditingController().obs;

  @override
  void onInit() async {
    super.onInit();


    if (Common.getUser() != null) {
      user = Common.getUser()!.data!.provider;
      setDataToView();
    }
  }


  void selectLanguage(Locales locale) async {

    if(language != locale.locale.toString()) {

      if(locale.locale == "en" || locale.locale ==  "pl" || locale.locale ==  "fr" || locale.locale ==  "ar" || locale.locale ==  "nl") {

     language = locale.locale.toString();

      Common.changeLanguage(Get.context as BuildContext, language, () {
        // setDataToView();
        Get.offAll(SplashScreen());
        update();
      });



    }else{
      Helper.ShowSnackbarFailureCenter(
          title: "Error".tr, body: "app_not_support_this_language".tr);
    }

    }

  }

  Future updateUserLanguageWebService({required int locale_id}) async{

    Loading.show();


    update();


    await Get.find<AuthApi>().updateUserLanguage( locale_id: locale_id)..fold(onError, onSuccess);
  }

  onSuccess(ProviderResponse data) async {
    Loading.hide();
    update();
    await Future.delayed(Duration(milliseconds: 200), () {
    });
    print("Success " + data.success.toString());
    if(data.success == true)
    {


      ProviderResponse? provider = Common.getUser() ;
      if(provider != null) {
        provider.data!.provider = data.data!.provider ;
        await Common.setUserModel(user: provider ).then((value) {
          if (data.data!.provider!.localeId.toString() != null) {
            user = data.data!.provider!;

            if (locales
                .where((element) =>
            element.id.toString() == data.data!.provider!.localeId.toString())
                .length > 0) {
              // locales.where((element) => element.locale.toString() ==data.data!.user!.localeId.toString() ).last.locale.toString() ;
              setDataToView();
              selectLanguage(locales
                  .where((element) =>
              element.id.toString() == data.data!.provider!.localeId.toString())
                  .last);
            }
          }
          update();
        });
      }
    }
    await Future.delayed(Duration(milliseconds: 200), () {
      update();
    });
    update();
  }


  onError(failure) async {
    Loading.hide();
    await Future.delayed(Duration(milliseconds: 200), () {});


    Helper.ShowSnackbarFailureCenter(
        title: "Error".tr, body: failure.toString());

    update();

  }

  void setDataToView() {
    if(Common.getSplash()!.data.locales  != null &&
        Common.getSplash()!.data.locales .length>0)
      locales =  Common.getSplash()!.data.locales   ;
    if(user != null){
      if(user!.localeId != null){
        if(locales.where((element) => element.id.toString() == user!.localeId.toString() ).length >0){
          locales.where((element) => element.id.toString() == user!.localeId.toString() ).last.isSelect = true ;
          update();
        }
      }
    }
  }


  String? q = "";
  void onSearch(val) {
    if(val == null){
      q = "";
      searchController.value.text = "";
    }else{
      q = val ;
    }

    update();

  }
}
