import 'package:get/get.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/utils/common.dart';

import '../../../models/authentication/choose_services_response.dart';
import '../../../models/authentication/show_services_response.dart';
import '../../../utils/helper.dart';
import '../../../utils/loading.dart';
import '../../menu_screens/subscription/subscription.dart';
import '../../pager/pager.dart';

class ChooseServiceController extends GetxController {
  final indexTap = <int>[].obs;
  final idTap = <int>[].obs;
  final data = {}.obs;

  String arg = "add";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null && Get.arguments[0] != null) {
      arg = Get.arguments[0];
      update();
    }
    getServices();
  }

  void updateIndexTap(int index, id) {
    if (indexTap.isEmpty) {
      indexTap.add(index);
      idTap.add(id);
    } else if (!indexTap.contains(index) && indexTap.length != 5) {
      indexTap.add(index);
      idTap.add(id);
    } else if (indexTap.contains(index) && indexTap.length != 1) {
      indexTap.remove(index);
      idTap.remove(id);
    }
    update();
    print("indexTap ${indexTap}");
    print("idTap ${idTap}");
  }

  Future getServices() async {
    print("Hi ::::::::");
    return await Get.find<AuthApi>().getServices()
      ..fold(onError, onSuccess);
  }

  onError(failure) async {
    update();
    if (failure.toString().toString().contains("Failed host lookup")) {
      checkConnectivity().then((intenet) {
        if (intenet) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: failure.toString(),
          );
        } else {
          // var internet = false.obs;
          update();
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: 'no_internet'.tr,
          );
        }
      });
    } else {
      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: failure.toString(),
      );
    }
    update();
  }

  List<Service>? servicesList = [];

  onSuccess(ShowServicesResponse data) async {
    print(data..toString());
    print('servicesList $servicesList');
    update();

    if (data.success != false) {
      servicesList = data.data!.services;

      if (Common.getUser()!.data!.provider!.services != null ||
          Common.getUser()!.data!.provider!.services!.length > 0) {
        Common.getUser()!.data!.provider!.services!.forEach((userservice) {
          for (int i = 0; i < servicesList!.length; i++) {
            if (servicesList![i].id == userservice.id) {
              updateIndexTap(i, userservice.id);
            }
          }
        });
      }
    } else {}
    print('servicesList $servicesList');
    update();
    update();
  }

  Future updateServices() async {
    Loading.show();
    print("Hi ::::::::");
    return await Get.find<AuthApi>().ChooseServices(list: idTap)
      ..fold(onErrorUpdate, onSuccessUpdate);
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
          // var internet = false.obs;
          update();
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: 'no_internet'.tr,
          );
        }
      });
    } else {
      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body: failure.toString(),
      );
      print(failure.toString());
    }
    update();
  }

  onSuccessUpdate(ChooseServicesResponse data) async {
    Loading.hide();

    update();
    await Future.delayed(Duration(milliseconds: 200), () {});
    print('data.data ${data.data.toString()}');
    if (data.success != false) {
      print(data.data.toString());
      await Common.setChooseService(good: true);

      if (arg == "edit") {
        await Future.delayed(Duration(milliseconds: 200), () {});

        await Helper.ShowSnackbarSuccess(
            title: "Choose Service".tr, body: "Successfully Choose Service".tr);

          Get.offAll(() => const Pager(selected: 0),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 300));
      } else {



        if (Common.getUser()!.data!.provider!.subscriptionStatus == false) {
          Get.to(Subscription(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 300),
              arguments: [true]);
        } else
        Get.offAll(() => const Pager(selected: 0),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 300));
      }
    } else {}
    update();
  }
}
