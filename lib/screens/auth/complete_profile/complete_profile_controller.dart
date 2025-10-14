import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/models/address/map/map_street_model.dart';
import 'package:provider/models/authentication/provider.dart';
import 'package:provider/utils/common.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/utils/utils.dart';
import 'package:provider/widgets/dialog_permission_denied.dart';

import '../../../core/connection_service/api/auth_api.dart';
import '../../../models/authentication/cities_response.dart';
import '../../../models/authentication/update_provider_response.dart';
import '../../../utils/helper.dart';
import '../../../utils/loading.dart';
import '../choose_service/choose_service.dart';

class CompleteProfileController extends GetxController {
  Rx<TextEditingController> hourlyRateController =
      new TextEditingController().obs;
  Rx<TextEditingController> taxIDlController = new TextEditingController().obs;
  Rx<TextEditingController> cityController = new TextEditingController().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Position? currentPosition;
  RxList<City>? Cities = RxList<City>([]);
  Rx<City?> selectedCity = Rx<City?>(null);
  File? image;
  var type = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getCurrentPosition();
    getCities();

    log("accessToken  ${Common.getUser()!.data!.login!.accessToken}");
    setDataToView();
  }

  setCities(City) async {
    Cities?.value = City;
    // selectedCity.value =Cities?.first;
    update();
    log('selectedCountry.value?.id ${selectedCity.value?.name}');


    setDataToView();
  }

  void onCityChanged(City? city) {
    selectedCity.value = city;
    print(selectedCity.value?.id);
    cityController.value.text = city!.name;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      update();
      log("currentPosition.longitude ${currentPosition?.longitude} currentPosition?.latitude ${currentPosition?.latitude}");

      GetNameStreetWebService();
    }).catchError((e) {
      log(e);
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Location Services Disabled'.tr),
          content: Text(
              'Location services are disabled. Please enable the services.'.tr),
          actions: [
            TextButton(
              child: Text('OK'.tr),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.isLocationServiceEnabled();
                // Open app settings to allow the user to enable location services manually
              },
            ),
          ],
        ),
      );
      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: 'Location services are disabled. Please enable the services'.tr,
      );
      print('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Helper.ShowSnackbarFailureCenter(
          title: "Error".tr,
          body: 'Location permissions are denied'.tr,
        );
        print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.whileInUse) {

      return true ;
    }

      if (permission == LocationPermission.deniedForever) {
      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body:
            'Location permissions are permanently denied, we cannot request permissions.'
                .tr,
      );
      print('Location services are disabled. Please enable the services');
      return false;
    } else {
      print("permissions true");
    }
    return true;
  }

  Future pickImage() async {

    getStoragePermission(onTrue:() async {
      cropNewImageTop();
     /** try {
        final image = await ImagePicker().pickImage(
            source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        this.image = imagePath;
        isAddImage = true;
        update();
        print("image ${this.image}");
      } on PlatformException catch (e) {
        log("e $e");
      }
      */
    }) ;
    /**PermissionStatus state = await await Permission.storage.request();;

     print(state.toString() + "sssss");
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
        final image = await ImagePicker().pickImage(
            source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        this.image = imagePath;
        isAddImage = true;
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
        this.image = imagePath;
        isAddImage = true;
        update();

      });
    });
  }

  bool isAddImage = true ;
  Future updateProvider() async {
    if (currentPosition != null) {
      isAddImage = true ;

      print(provider!.avatar.toString() + "xxx");
      if((image == null || image.toString().isEmpty || image!.path.toString().isEmpty)
          && (provider!.avatar == null || provider!.avatar.toString().isEmpty || provider!.avatar.toString() == confing.baseUrl )
      ){
        isAddImage = false ;
        update();
        Helper.ShowSnackbarFailureCenter(
            title: "Error".tr, body:  "add_avatar_please".tr);


        return ;
      }else {
        if((imageID == null || imageID.toString().isEmpty || imageID!.path.toString().isEmpty)
            && (provider!.identity == null || provider!.identity.toString().isEmpty || provider!.identity.toString() == confing.baseUrl )
        ) {
          isAddImage = false;
          update();
          Helper.ShowSnackbarFailureCenter(
              title: "Error".tr, body: "identity".tr);


          return;
        }
        Loading.show();
        String hourly_rate = hourlyRateController.value.text.toString();
        String tax_id = taxIDlController.value.text.toString();
        await Get.find<AuthApi>().UpdateProvider(
          file: image != null ? image :null ,
          fileName:image != null ? image!.path
              .split("/")
              .last:null,
          fileID: imageID != null  ? imageID:null ,
          fileNameID:imageID != null ? imageID!.path
              .split("/")
              .last:null,

          type: type,
          hourly_rate: hourly_rate,
          city_id: selectedCity.value?.id.toString(),
          tax_id: tax_id,
          locale_id: Common
              .getSplash()
              ?.data
              .locales
              .first
              .id,
          longitude: currentPosition?.longitude,
          latitude: currentPosition?.latitude,
          nameLocation: nameLocation != null && nameLocation.isNotEmpty
              ? nameLocation.toString()
              : null,
        )
          ..fold(onError, onSuccess);



      }
    } else {
      _getCurrentPosition();
    }
  }

  String nameLocation = "";

  onSuccess(ProviderResponse data) async {
    Loading.hide();
    update();
    await Future.delayed(Duration(milliseconds: 200), () {});
    print("Success " + data.success.toString());
    if (data.success == true) {
      // Helper.ShowSnackbarSuccess(title: "Complete Profile".tr, body:"Successfully Complete Profile".tr);
      Get.to(() => const ChooseService(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
          arguments: ["add"]);
      // print("${data.data.toJson()}");
    }

    update();
  }

  onError(failure) async {
    Loading.hide();
    await Future.delayed(Duration(milliseconds: 200), () {});

    Helper.ShowSnackbarFailureCenter(
        title: "Error".tr, body: failure.toString());

    update();
  }

  String errorEmailUniv = "";
  String errorEmail = "";

  Future getCities() async {
    await Get.find<AuthApi>().CitiesProvider()
      ..fold(onErrorCities, onSuccessCities);
  }

  List<City>? citiesList = [];

  onSuccessCities(CitiesResponse data) async {
    update();
    await Future.delayed(Duration(milliseconds: 200), () {});
    print("Success " + data.success.toString());
    if (data.success == true) {
      citiesList = data.data.cities;
      update();
      setCities(citiesList);
      print("${data.data.toJson()}");
    }
    update();
  }

  onErrorCities(failure) async {
    await Future.delayed(Duration(milliseconds: 200), () {});
    print("error " + failure.toString());
    // String error = failure.toString();

    Helper.ShowSnackbarFailureCenter(
        title: "Error".tr, body: failure.toString());

    update();
  }


  Future<void> GetNameStreetWebService() async {
    if (currentPosition != null)
      await Get.find<AuthApi>()
          .GetNameStreet(currentPosition!.latitude, currentPosition!.longitude)
        ..fold(onErrorStreet, onSuccessStreet);
  }


  onSuccessStreet(MapStreetModel data) {
    nameLocation = "";
    if (data != null && data.address!.country != null) {
      nameLocation += data.address!.country.toString();
    }

    if (data != null && data.address!.city != null) {
      nameLocation += " , " + data.address!.city.toString();
    }

    if (data != null && data.address!.state != null) {
      nameLocation += " , " + data.address!.state.toString();
    }
    if (data != null &&
        data.displayName != null &&
        data.displayName.toString().isNotEmpty) {
      nameLocation += " , " + data.displayName.toString();
    }

    update();
    print("nammmmmme ## "+nameLocation.toString());

   }

  onErrorStreet(failure) async {
   }



  String? pathImageAvatar  = "";
  File? imageID;

  Rx<TextEditingController> idPathImageAvatar  =
      new TextEditingController().obs;



  Future pickFileAvatar(String type, String user_type) async {
    getStoragePermission(onTrue: (){
      cropNewImage();

    });
    /**
    PermissionStatus state = await Permission.storage.request();

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
        final image = await ImagePicker().pickImage(
            source: ImageSource.gallery);
        if (image == null) return;
        final imagePath = File(image.path);
        imageID = imagePath;

        pathImageAvatar = image.path.toString();
        idPathImageAvatar.value.text = image.name;
        update();
      } on PlatformException catch (e) {
        log("e $e");
      }
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





  Provider? provider ;
  void setDataToView() {

     provider = Common.getUser()!.data!.provider  ;
    if(provider != null){
      if(provider!.hourlyRate != null)
      hourlyRateController.value.text = provider!.hourlyRate.toString() ;
      if(provider!.taxId != null)
        taxIDlController.value.text = provider!.taxId.toString() ;

      if(provider!.cityId != null){
        if(citiesList!.where((element) => element.id.toString() == provider!.cityId.toString()).length>0)
        onCityChanged(citiesList!.where((element) => element.id.toString() == provider!.cityId.toString()).first   ) ;
      }
      if(provider!.identity != null && provider!.identity.toString() != confing.baseUrl)
        pathImageAvatar = provider!.identity.toString() ;

      if(provider!.type != null){
        type = provider!.type!.obs;

      }
      update();
    }
  }
}
