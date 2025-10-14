import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/models/authentication/provider.dart';
import 'package:provider/models/authentication/update_provider_response.dart';
import 'package:provider/screens/auth/choose_service/choose_service.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/utils/loading.dart';
import 'package:provider/utils/utils.dart';
import 'package:provider/widgets/dialog_permission_denied.dart';

import '../../../core/connection_service/api/menu_api.dart';
import '../../../models/authentication/cities_response.dart';
import '../../../models/authentication/info_response.dart';
import '../../../models/install/country_model.dart';
import '../../../models/menu/show_schedules_response.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';
import '../../splash/splash_screen.dart';

class MenuScreenController extends GetxController {
  var isLoading;

  FirebaseMessaging? _firebaseMessaging = null;
  String _token = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Common.getUser() != null) myUser();
    infoProviderData();

    getCities();

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.getToken().then((token) async {
      _token = token!;
      await Common.setDeviceToken(DeviceToken: _token);
      print(_token);
    });
  }

  Future getCities() async {
    await Get.find<AuthApi>().CitiesProvider()
      ..fold(onErrorCities, onSuccessCities);
  }

  List<City>? citiesList = [];

  onSuccessCities(CitiesResponse data) async {
    update();
    //await Future.delayed(Duration(milliseconds: 200), () {});
    print("SuccessCity " + data.success.toString());
    if (data.success == true) {
      citiesList = data.data.cities;
      update();
      setCities(citiesList);
      print("${data.data.toJson()}");
    }
    update();
  }

  setCities(City) async {
    Cities?.value = City;
    selectedCity.value = Cities?.first;
    update();

    infoProviderData();
  }

  void onCityChanged(City? city) {
    selectedCity.value = city;
    print(selectedCity.value?.id);
    cityController.value.text = city!.name;
  }

  onErrorCities(failure) async {
    await Future.delayed(Duration(milliseconds: 200), () {});
    print("error " + failure.toString());
    // String error = failure.toString();

    Helper.ShowSnackbarFailureCenter(
        title: "Error".tr, body: failure.toString());

    update();
  }

  Future infoProviderData() async {
    isLoading = true.obs;
    update();
    return await Get.find<MenuApi>().infoProviderData()
      ..fold(onError, onSuccess);
  }




  String msgError = "Error".tr;
  onError(failure) async {
    isLoading = false.obs;
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
          msgError =failure.toString();
        } else {
          // internet=false.obs;
          msgError ="no_internet".tr;
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
      msgError =failure.toString();
    }
    // int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  Provider? provider;

  var paginationList;

  onSuccess(InfoResponse data) async {
    isLoading = false.obs;

    update();
    // String? key = getKeyForValue( 5);
    // print("Common.getSplash().data.enums.orderStatusEnum.toJson() ${key}");
    if (data.success != false) {
      provider = data.data!.provider;
      user = data.data!.provider;
      ProviderResponse? providerResponse = Common.getUser();
      if (providerResponse != null) {
        providerResponse.data!.provider = user;
        await Common.setUserModel(user: providerResponse).then((value) {
          log('Common.getUser()?.data.user.toJson() ${Common.getUser()?.toJson()}');
          user = Common.getUser()!.data!.provider;
          if (user!.city != null) {
            if (citiesList!
                    .where((element) =>
                        element.id.toString() == user!.cityId.toString())
                    .length >
                0)
              onCityChanged(citiesList!
                  .where((element) =>
                      element.id.toString() == user!.cityId.toString())
                  .first);
            selectedCity(citiesList!
                .where((element) =>
                    element.id.toString() == user!.cityId.toString())
                .first);
          }
          if (user!.taxId != null) {
            taxIDlController.value.text = user!.taxId;
          }

          if (user!.identity != null &&
              provider!.identity.toString() != confing.baseUrl) {
            pathImageAvatar = user!.identity.toString();
          }
          update();
        });
      }

      if (user!.hourlyRate != null)
        hourlyRateController.value.text = user!.hourlyRate.toString();
    } else {}
    update();
    update();
  }

  GlobalKey<FormState> UpdateFormKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  Rx<TextEditingController> phoneNumberController =
      new TextEditingController(text: Common.getUser()!.data!.provider!.mobile)
          .obs;
  Rx<TextEditingController> fullNameController =
      new TextEditingController(text: Common.getUser()!.data!.provider!.name)
          .obs;
  RxList<Country>? countries = RxList<Country>([]);
  Rx<Country?> selectedCountry = Rx<Country?>(null);
  File? image;

  setCountries() async {
    countries?.value = (Common.getSplash()!.data.countries);
    selectedCountry.value = countries?.first;
    update();

    if (Common.getUser() != null) {
      if (Common.getUser()!.data!.provider!.countryId != null) {
        for (int i = 0; i < countries!.value.length; i++) {
          print(countries!.value[i].id.toString() +
              " ==" +
              Common.getUser()!.data!.provider!.countryId.toString());
          if (countries!.value[i].id.toString() ==
              Common.getUser()!.data!.provider!.countryId.toString())
            selectedCountry.value = countries!.value[i];
        }
        update();
      }
    }
  }

  void onCountryChanged(Country? country, setState) {
    selectedCountry.value = country;
    print(selectedCountry.value?.id);

    setState(() {});
    update();
    update();
  }

  Future pickImage() async {
    getStoragePermission(onTrue: () async {

      cropNewImageTop();
      /**try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        this.image = imagePath;

        updateUser();
        update();
        print("image ${this.image}");
      } on PlatformException catch (e) {
        log("e $e");
      }*/
    });

    /** PermissionStatus state = await Permission.storage.request();
        if (state == PermissionStatus.permanentlyDenied   ) {
        showDialog(
        context: Get.context as BuildContext,
        builder: (context) => new ShowDialogPermissionDenied(
        "Allow Permission", "The app needs permission to access storage!"),
        );
        }  else if (state != PermissionStatus.granted) {
        await Permission.storage.request();
        } else {


        try {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        this.image = imagePath;

        updateUser();
        update();
        print("image ${this.image}");
        } on PlatformException catch (e) {
        log("e $e");
        }
        }*/
  }
  cropNewImageTop() async {
    await Utils.pickImageFromGallery().then((pickedFile) async {
      // Step #2: Check if we actually picked an image. Otherwise -> stop;
      if (pickedFile == null) return;

      // Step #3: Crop earlier selected image
      await Utils.cropSelectedImageAttachments(pickedFile.path)
          .then((croppedFile) async {
        // Step #4: Check if we actually cropped an image. Otherwise -> stop;
        if (croppedFile == null) return;

        // Step #5: Display image on screen

        // image  = croppedFile.path  ;
        final imagePath = File(croppedFile.path);
        imagePath.length() ;
        int size = await imagePath.length()  ;
        print( " ddd "+size.toString());
         this.image = imagePath;

        updateUser();
        update();

      });
    });
  }

  Rx<TextEditingController> hourlyRateController =
      new TextEditingController().obs;
  Rx<TextEditingController> taxIDlController = new TextEditingController().obs;
  Rx<TextEditingController> cityController = new TextEditingController().obs;
  RxList<City>? Cities = RxList<City>([]);
  Rx<City?> selectedCity = Rx<City?>(null);

  goToService() {
    Get.to(() => const ChooseService(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
        arguments: ["edit"]);
  }

  Future updateUser() async {
    Get.back();

    update();
    Loading.show();
    String? phoneNumber = phoneNumberController.value.text.toString();
    String? fullName = fullNameController.value.text.toString();

    if (phoneNumberController.value.text !=
        Common.getUser()!.data!.provider!.mobile) {
      user!.countryId = selectedCountry.value!.id!;
    }
    if (phoneNumberController.value.text != null) {
      user!.mobile = phoneNumberController.value.text;
    }
    if (hourlyRateController.value.text != null) {
      user!.hourlyRate = hourlyRateController.value.text;
    }

    if (fullNameController.value.text !=
        Common.getUser()!.data!.provider!.name) {
      user!.name = fullNameController.value.text;
    }
    if (image?.path != null && image.toString().isNotEmpty) {
      user!.avatar = image!.path;
    }
    String tax_id = taxIDlController.value.text.toString();

    update();

    await Get.find<AuthApi>().UpdateUserData(
      user: user,
      file: image,
      tax_id: tax_id,
      cityId: selectedCity.value?.id.toString(),
      fileName: image?.path.split("/").last,
      country_id: selectedCountry.value?.id.toString(),
      fileID: imageID != null ? imageID : null,
      fileNameID: imageID != null ? imageID!.path.split("/").last : null,
    )
      ..fold(onErrorUpdate, onSuccessUpdate);
  }

  Provider? user;

  onSuccessUpdate(ProviderResponse data) async {
    Loading.hide();
    update();
    await Future.delayed(Duration(milliseconds: 200), () {});
    print("Success " + data.success.toString());
    if (data.success == true) {
      infoProviderData();
    }
    await Future.delayed(Duration(milliseconds: 200), () {
      update();
    });
    update();
  }
  onErrorUpdate(failure) async {
    Loading.hide();
    update();
     await Future.delayed(Duration(milliseconds: 200), () {});

    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet) {
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
    // int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  String errorEmailUniv = "";
  String errorEmail = "";

  Future<void> myUser() async {
    await Get.find<AuthApi>().myUser()
      ..fold(onErrorMyUser, onSuccessMyUser);
  }

  onSuccessMyUser(ProviderResponse data) async {
    if (data.data != null) {
      ProviderResponse? provider = Common.getUser();
      if (provider!.data!.login == null) {
        await Common.clearUserModel();
      } else {
        if (provider != null) {
          provider.data!.provider = data.data!.provider;
          await Common.setUserModel(user: provider).then((value) {
            user = Common.getUser()!.data!.provider;
          });
        }
      }
    }

    update();
  }

  onErrorMyUser(failure) async {
    if (failure.toString().contains("unauthenticated")) {
      Common.clearUserModel();
    }
  }

  String? pathImageAvatar = "";
  File? imageID;

  Rx<TextEditingController> idPathImageAvatar = new TextEditingController().obs;

  Future pickFileAvatar(String type, String user_type, var setState) async {

    getStoragePermission(onTrue:() async {
     await cropNewImage();
   /**   try {
        final image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        imageID = imagePath;

        pathImageAvatar = image.path.toString();
        idPathImageAvatar.value.text = image.name;
        update();
      } on PlatformException catch (e) {
        log("e $e");
      }*/
      setState(() {});
    }) ;

    /**PermissionStatus state = await Permission.storage.request();
     print(state.toString() + "sssss");
    if (state == PermissionStatus.permanentlyDenied) {
      showDialog(
        context: Get.context as BuildContext,
        builder: (context) => new ShowDialogPermissionDenied(
            "Allow Permission", "The app needs permission to access storage!"),
      );
    } else if (state != PermissionStatus.granted) {
      await Permission.storage.request();
    } else {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        imageID = imagePath;

        pathImageAvatar = image.path.toString();
        idPathImageAvatar.value.text = image.name;
        update();
      } on PlatformException catch (e) {
        log("e $e");
      }
      setState(() {});
    }*/
  }

  cropNewImage() async {
    await Utils.pickImageFromGallery().then((pickedFile) async {
      // Step #2: Check if we actually picked an image. Otherwise -> stop;
      if (pickedFile == null) return;

      // Step #3: Crop earlier selected image
      await Utils.cropSelectedImageAttachments(pickedFile.path)
          .then((croppedFile) {
        // Step #4: Check if we actually cropped an image. Otherwise -> stop;
        if (croppedFile == null) return;

        // Step #5: Display image on screen

        // image  = croppedFile.path  ;
         final imagePath = File(croppedFile.path);
        imageID = imagePath;

        pathImageAvatar = croppedFile.path.toString();
        idPathImageAvatar.value.text = croppedFile.path.split(".").last;
        update();

       });
    });
  }
  LogOut() async {
    await Common.clearUserModel();

    update();

    Get.offAll(SplashScreen());
  }

}
