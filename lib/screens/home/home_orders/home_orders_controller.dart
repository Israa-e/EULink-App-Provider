import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/main.dart';
import 'package:provider/models/address/map/map_street_model.dart';
import 'package:provider/models/authentication/provider.dart';
import 'package:provider/models/order/show_messages_response.dart';
import 'package:provider/utils/call_back_notification.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/connection_service/api/order_api.dart';
import '../../../models/order/order_response.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as locat;

class HomeOrdersController extends GetxController {
  var isLoading;
  RxInt? status;

  int is_completed = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentPosition();
    getOrdersData();
  }

  bool isGetLocal = false;

  @override
  void onReady() {
    super.onReady();
    changeOrderController = StreamController<ListinOrderNotification>();
    changeOrderController.stream.listen((e) {
      print(e.toString() + "notiiiiii orders");
      page = 1;
      getOrdersData();
    });
  }

  Future getOrdersData() async {
    if (page == 1) {
      isLoading = true.obs;
    } else {
      isLoadMore = true.obs;
    }
    update();
    return await Get.find<OrderApi>().getOrderData(
        status: status,
        page: page,
        per_page: per_page,
        is_completed: is_completed,
        from: fromformattedDate != null
            ? fromformattedDate!.value.toString()
            : "",
        to: toformattedDate != null ? toformattedDate!.value.toString() : "")
      ..fold(onError, onSuccess);
  }

  onSuccess(OrderResponse data) async {
    isLoading = false.obs;
    isLoadMore = false.obs;
    update();
    String? key = getKeyForValue(5);
    if (data.success != false) {
      if (data.data!.ordersCollection != null) {
        if (page == 1) {
          ordersList = data.data!.ordersCollection!.orders!;
        } else {
          ordersList.addAll(data.data!.ordersCollection!.orders!);
        }
        paginationList = data.data!.ordersCollection?.pagination;
        paginate = data.data!.ordersCollection?.pagination;
      }
    } else {}
    update();
    update();
  }

  onError(failure) async {
    isLoading = false.obs;
    isLoadMore = false.obs;
    update();
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

  List<Orders> ordersList = [];

  var paginationList;
  String formattedDate = '';

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

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  int page = 1;

  int per_page = 10;

  //loade more and refresh
  Rx<ScrollController> scrollController = new ScrollController().obs;
  Pagination? paginate = null;
  RxBool isLoadMore = false.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch

    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    ordersList = [];
    paginate = null;
    page = 1;
    getOrdersData();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (!isLoadMore.value &&
        ordersList.length > 0 &&
        paginate != null &&
        paginate!.total! > ordersList.length) {
      if (!isLoadMore.value && !isLoadMore.value) {
        page++;
        getOrdersData();
      }
      update();
    }
    refreshController.loadComplete();
  }

  RxString? fromformattedDate;
  RxString? toformattedDate;

  var selectedDate = DateTime(DateTime.now().year).obs;
  DateTime? pickedDate;

  void selectDate(BuildContext context, bool isFrom, setState) async {
    pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      //initialEntryMode: DatePickerEntryMode.input,
      firstDate: DateTime(1940),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Common.getDarkMode() == true
                ? ColorScheme.dark(
                    primary: Colors.orangeAccent,

                    surface: Colors.orangeAccent,
                    onSurface: Colors.white,
                    background: Colors.white,
                    //t color
                    onPrimary: Colors.white,
                  )
                : ColorScheme.light(
                    primary: Colors.orangeAccent,
                    // header background color
                    onPrimary: Colors.black,

                    background: Common.getDarkMode() == true
                        ? Colors.black
                        : Color.fromRGBO(255, 255, 255, 1.0),
                    //t color
                    onSurface: Colors.black,
                    primaryContainer: Common.getDarkMode() == true
                        ? Colors.black
                        : Color.fromRGBO(255, 255, 255, 1.0),
                    onPrimaryContainer: Common.getDarkMode() == true
                        ? Colors.black
                        : Color.fromRGBO(255, 255, 255, 1.0),
                    secondaryContainer: Common.getDarkMode() == true
                        ? Colors.black
                        : Color.fromRGBO(255, 255, 255, 1.0),
                    onBackground: Common.getDarkMode() == true
                        ? Colors.black
                        : Color.fromRGBO(255, 255, 255, 1.0),
                    onSecondary: Common.getDarkMode() == true
                        ? Colors.black
                        : Color.fromRGBO(255, 255, 255, 1.0),
                    // body text color
                  ),
            dialogBackgroundColor:
                Common.getDarkMode() == true ? Colors.black : Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  //foregroundColor: Colors.black, // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate!;

      if (isFrom == true) {
        fromformattedDate =
            pickedDate.toString().substring(0, 10).toString().obs;
      } else {
        toformattedDate = pickedDate.toString().substring(0, 10).toString().obs;
      }
      update();

      setState(() {});
      print(pickedDate.toString().substring(0, 10));
    }
  }

  void clearFillter() {
    toformattedDate = null;
    fromformattedDate = null;
    page = 1;
    getOrdersData();
  }

  void searchByFillter() {
    Get.back();
    getOrdersData();
  }

  Position? currentPosition;

  Future<void> getCurrentPosition() async {
    print("pos ## ".toString());
    final hasPermission = await _handleLocationPermission();
    print("pos ## " + hasPermission.toString());
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      update();
      GetNameStreetWebService();
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  LocationPermission? permission;
  String msgCurrentLocationPref = "";

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    msgCurrentLocationPref = "";
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locat.Location location = new locat.Location();
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }

      return false;
    }
    permission = await Geolocator.checkPermission();

    print("pos ##222 " + permission.toString());
    if (currentPosition == null) {
      if (permission == LocationPermission.denied) {
        msgCurrentLocationPref = 'msgCurrentLocationPref'.tr;
      } else if (permission == LocationPermission.whileInUse) {
        return true;
      }
      update();
      return false;
    } else {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Helper.ShowSnackbarFailureCenter(
            title: "Error".tr,
            body: 'Location permissions are denied'.tr,
          );
          return false;
        }
      }

      if (permission == LocationPermission.whileInUse) {
        return true;
      }

      if (permission == LocationPermission.deniedForever) {
        Helper.ShowSnackbarFailureCenter(
          title: "Error".tr,
          body:
              'Location permissions are permanently denied, we cannot request permissions.'
                  .tr,
        );

        return false;
      } else {}
    }
    return true;
  }

  Future<bool> handleLocationPermissionTap() async {
    bool serviceEnabled;
    msgCurrentLocationPref = "";
    update();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locat.Location location = new locat.Location();
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }

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
        return false;
      }
    } else if (permission == LocationPermission.whileInUse) {
      return true;
    }
    if (permission == LocationPermission.deniedForever) {
      Helper.ShowSnackbarFailureCenter(
        title: "Error".tr,
        body:
            'Location permissions are permanently denied, we cannot request permissions.'
                .tr,
      );

      return false;
    } else {}

    getCurrentPosition();

    return true;
  }

  Future updateProviderLocationWebService() async {
    if (currentPosition != null)
      return await Get.find<AuthApi>().updateProviderLocation(
          latitude: currentPosition!.latitude,
          longitude: currentPosition!.longitude,
          nameLocation: nameLocation != null && nameLocation.isNotEmpty
              ? nameLocation
              : null)
        ..fold((failure) {}, (ProviderResponse data) {});
  }

  Future<void> GetNameStreetWebService() async {
    if (currentPosition != null)
      await Get.find<AuthApi>()
          .GetNameStreet(currentPosition!.latitude, currentPosition!.longitude)
        ..fold(onErrorStreet, onSuccessStreet);
  }

  String nameLocation = "";

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

    updateProviderLocationWebService();
  }

  onErrorStreet(failure) async {
    updateProviderLocationWebService();
  }
}
