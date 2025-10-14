import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/models/authentication/provider.dart';

import '../../../core/connection_service/api/menu_api.dart';
import '../../../models/install/country_model.dart';
import '../../../models/menu/contact_response.dart';
import '../../../models/splash/splash_response.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';

class ContactusController extends GetxController{
  GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();
  Rx<TextEditingController> phoneController = new TextEditingController().obs;
  Rx<TextEditingController> nameController = new TextEditingController().obs;
  Rx<TextEditingController> messageController = new TextEditingController().obs;
  RxList<Country>? countries = RxList<Country>([]);
  Rx<Country?> selectedCountry = Rx<Country?>(null);
  Provider? user ;
  void onInit()async{
    super.onInit();
    if(Common.getUser() != null){
      user = Common.getUser()!.data!.provider ;
      if(user!.name != null){
        nameController.value.text = user!.name.toString();
      }
      if(user!.mobile != null){
        phoneController.value.text = user!.mobile.toString();
      }
    }
    setCountries();

  }
  setCountries() async{
    countries?.value = (Common.getSplash()?.data.countries)!  ;
    selectedCountry.value =countries?.first;
    update();
     if(Common.getUser() != null){

      if(Common.getUser()!.data!.provider  != null){
        for(int i = 0 ; i < countries!.value.length ;i++){


          print(countries!.value[i].id.toString()+" =="+Common.getUser()!.data!.provider.toString());
          if(countries!.value[i].id.toString() ==Common.getUser()!.data!.provider!.countryId.toString()  )
            selectedCountry.value =countries!.value[i] ;
        }
        update();
      }
    }
  }
  void onCountryChanged(Country? country) {

    selectedCountry.value = country;
    print(selectedCountry.value?.id);
    update();
  }

  Future contactData() async {
    String name =   nameController.value.text ;
    String mobile =   phoneController.value.text ;
    String message =   messageController.value.text ;
     update();
    return await Get.find<MenuApi>().contactData(
        country_id: selectedCountry.value?.id.toString(),
        name: name,
        message: message,
        mobile: mobile
    )
      ..fold(onError, onSuccess);
  }

  onError(failure) async {
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet != null && intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
        } else {
          // internet=false.obs;
          update();
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: 'no_internet'.tr,
          );
        }
      });
    } else {
      log("Error $failure");
      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: failure.toString(),
      );
    }
    update();
  }

  onSuccess(ContactResponse data) async {

     update();
    if (data.success == true) {
      Get.back();
       Helper.ShowSnackbarSuccess(
        title: "Success".tr,
        body: "Messages sent successfully".tr,
      );
    } else {}
    update();
  }
}