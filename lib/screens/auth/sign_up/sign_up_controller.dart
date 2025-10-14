import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/models/install/social_response.dart';
import 'package:provider/screens/auth/complete_profile/complete_profile.dart';
import 'package:provider/screens/auth/sign_up/sing_up_screen.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/helper.dart';
import 'package:provider/utils/loading.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/rich_text.dart';
//import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/authentication/login_response.dart';
import '../../../models/authentication/provider.dart';
import '../../../models/install/country_model.dart';
import '../../../models/splash/splash_response.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  Rx<TextEditingController> phoneNumberController =
      new TextEditingController().obs;
  Rx<TextEditingController> fullNameController =
      new TextEditingController().obs;
  Rx<TextEditingController> pinCodeController = new TextEditingController().obs;
  RxList<Country>? countries = RxList<Country>([]);
  Rx<Country?> selectedCountry = Rx<Country?>(null);
  FirebaseMessaging? _firebaseMessaging = null;
  String _token = "";
  String mobile = "";
  String countrycode = "966";
  var isSingUp = false.obs;
  late CountdownTimerController controllerDown;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  String valueCode = "";


  @override
  void dispose() {
    controllerDown.dispose();
    super.dispose();
  }

  bool iSEndTime = false;

  void onEnd() {
    iSEndTime = true;
    update();
  }

  bool onCompleted = false;
  final ScrollController scrollController = ScrollController();

  ProviderResponse? user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    disableCapture();
    setCountries();
    controllerDown = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    next = 1;

    if (Common.getUser() != null) {
      // user = Common.getUser();
    }
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        mobile = Get.arguments[0] as String;
      }
      if (Get.arguments[1] != null) {
        countrycode = Get.arguments[1] as String;
      }
      if (Get.arguments[2] != null) {
        next = Get.arguments[2] as int;
        endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
        controllerDown =
            CountdownTimerController(endTime: endTime, onEnd: onEnd);
        textEditingController = TextEditingController();
        iSEndTime = false;
        update();
      }
    }
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.getToken().then((token) async {
      _token = token!;
      await Common.setDeviceToken(DeviceToken: _token);
      print(_token);
    });
    // socialLinkWebService();

    //getUniversitiesWebService();
  }
  /**
  String  message = "";
  final telephony = Telephony.instance;

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    final bool? result = await telephony.requestSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(onNewMessage: onMessage, onBackgroundMessage:  null ,listenInBackground: false);
      print("msgSMS # "+message.toString());
    }else{
      telephony.listenIncomingSms(onNewMessage:onMessage, onBackgroundMessage: null ,listenInBackground: false);
      print("msgSMS # "+message.toString());

    }


    update();



  }
  onMessage(SmsMessage msg ) async {

    message = msg.body ?? "";

    checkAndVerifySMS(message);
  }
  checkAndVerifySMS(String message) async {
    if(message !=null && message.isNotEmpty){
      message = message.replaceAll(".", " ");
      List<String> msgList = message.split(" ");
      for(int i =0 ; i < msgList.length ;i++) {
        if ((msgList[i].toString().trim().isNum == true ) && (msgList[i].toString().trim().length == 4)) {
          valueCode =msgList[i].toString().trim() ;
          await Verify(Get.context as BuildContext, valueCode, mobile);
        }
      }
    }
  }*/

  int next = 1;

  setCountries() async {
    countries?.value = (Common.getSplash()?.data.countries)!;
    selectedCountry.value = countries?.first;
    update();
  }

  void onCountryChanged(Country? country) {
    selectedCountry.value = country;
    print(selectedCountry.value?.id);
    update();
  }

  void goTo(screen) {
    Get.to(screen);
  }

  void goOffTo(screen) {
    Get.offAll(screen);
  }

  Future<void> SignUp() async {
    Loading.show();
    if (_token.isEmpty) {
      _firebaseMessaging = FirebaseMessaging.instance;
      _firebaseMessaging!.getToken().then((token) async {
        _token = token!;
        await Common.setDeviceToken(DeviceToken: _token);
      });
    }
    update();
    String name = fullNameController.value.text;
    mobile = phoneNumberController.value.text;
    update();
    await Get.find<AuthApi>().SignUp(
      mobile: mobile,
      country_id: selectedCountry.value?.id.toString(),
      full_name: name,
    )
      ..fold(onError, onSuccess);
  }

  onSuccess(LonginResponse data) async {
    Loading.hide();
    update();
 //   initPlatformState();
    await Future.delayed(Duration(milliseconds: 200), () {});
    if (data.success == true) {
      verifying(Get.context!);
    }

    update();
  }

  String errorEmailUniv = "";
  String errorEmail = "";

  onError(failure) async {
    Loading.hide();
    await Future.delayed(Duration(milliseconds: 200), () {});
    // String error = failure.toString();

    Helper.ShowSnackbarFailureCenter(
        title: "Error".tr, body: failure.toString());

    update();
  }

  /**Future<void> Verify(context, String code) async {
      Loading.show();

      update();
      await Get.find<AuthApi>().Verify(
      mobile: phoneNumberController.value.text.toString(),
      code: code,
      country_id: selectedCountry.value?.id.toString())
      ..fold(onErrorVerify, onSuccessVerify);
      }
   */
  onSuccessVerify(ProviderResponse data) async {
    Loading.hide();

    update();
    await Future.delayed(Duration(milliseconds: 300), () {});
    if (data.success != false) {
      //Helper.ShowSnackbarSuccessCenter(
        //  title: "Verify".tr, body: data.getMessageList().toString());

      await Common.setUserModel(user: data).then((value) {});

      Get.offAll(() => CompleteProfile());
    } else {
      Helper.ShowSnackBarFailure(
          title: "Error".tr, body: data.getMessageList.toString());
    }

    update();
  }

  onErrorVerify(failure) async {
    Loading.hide();


    await Future.delayed(Duration(milliseconds: 300), () {
      Helper.ShowSnackbarFailureCenter(
          title: "Error".tr, body: handlingFailureRespose(failure));
    });

    verifying(Get.context as BuildContext);

  }

  Future<void> Verify(context, String code, mobile) async {

    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(Duration(milliseconds: 200), () {});
    Loading.show();

    update();

    print("data Login #  " + mobile);
    await Get.find<AuthApi>().Verify(
        mobile: mobile,
        code: code,
        country_id: selectedCountry.value!.id.toString())
      ..fold(onErrorVerify, onSuccessVerify);
  }

  Future<void> login() async {
    if (_token.isEmpty) {
      _firebaseMessaging = FirebaseMessaging.instance;
      _firebaseMessaging!.getToken().then((token) async {
        _token = token!;
        await Common.setDeviceToken(DeviceToken: _token);
      });
    }

    update();

    if (phoneNumberController.value.text.length == 10) {
      mobile = phoneNumberController.value.text.toString();

      mobile = replaceEnglishNumber(mobile);

      Loading.show();
      await Get.find<AuthApi>().LoginRegister(
          emailPhone: mobile,
          token: _token,
          country_id: selectedCountry.value?.id.toString())
        ..fold(onError, onSuccess);
    } else {}
  }

  onSuccessLogin(LonginResponse data) async {
    Loading.hide();

    update();
    await Future.delayed(Duration(milliseconds: 200), () {});
    if (data.success == true) {
      verifying(Get.context!);
    }

    update();
  }

  onErrorLogin(failure) async {
    Loading.hide();
    await Future.delayed(Duration(milliseconds: 200), () {});

    Helper.ShowSnackbarFailureCenter(
        title: "Error".tr, body: failure.toString());
  }

  Future<dynamic> verifying(BuildContext context) {
    pinCodeController.value.clear();
    valueCode = "";
    update();
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
        ),
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: Get.height / 2.5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                          width: 51.w,
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Common.getDarkMode()
                                  ? Colors.white.withOpacity(0.2)
                                  : Color(0xFFDBDBDB),
                            ),
                          )),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomText(
                        text: "Verify mobile number".tr,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              height: 30 /
                                  18, // line height = 30px / font size = 16px
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: "Please enter the code we sent to your mobile".tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 11.sp),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            keyboardType :TextInputType.number ,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            appContext: context,
                            autoDisposeControllers: true,
                            animationType: AnimationType.fade,
                            controller: pinCodeController.value,
                            enableActiveFill: true,
                            cursorColor: Theme.of(context).primaryColor,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldWidth: 50,
                              inactiveFillColor: Common.getDarkMode()
                                  ? Colors.white.withOpacity(0.09)
                                  : Color(0xFFF3F4F5),
                              activeFillColor: Common.getDarkMode()
                                  ? Colors.white.withOpacity(0.05)
                                  : Color(0xFFF3F4F5),
                              selectedColor: Common.getDarkMode()
                                  ? Colors.white.withOpacity(0.05)
                                  : Color(0xFFF3F4F5),
                              selectedFillColor: Common.getDarkMode()
                                  ? Colors.white.withOpacity(0.05)
                                  : Color(0xFFF3F4F5),
                              inactiveColor: Common.getDarkMode()
                                  ? Colors.white.withOpacity(0.05)
                                  : Color(0xFFF3F4F5),
                              activeColor: Common.getDarkMode()
                                  ? Colors.white.withOpacity(0.05)
                                  : Color(0xFFF3F4F5),
                              borderWidth: 0,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            length: 4,
                            onCompleted: (val) async {
                              valueCode = val;
                              update();
                              setState(() {});
                              if (valueCode.length == 4) {
                                Get.back();
                                await Verify(context, valueCode, mobile);
                              }
                            },
                            textStyle: TextStyle(),
                            onChanged: (String value) {
                              valueCode = value;
                              update();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 75.w),
                        child: CustomButton(
                          onPressed: () async {
                            if (valueCode.length == 4) {
                              Get.back();
                              await Verify(context, valueCode, mobile);
                            }
                          },
                          text: 'Verify',
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      RichTexts(
                        firstText: 'Don’t receive your code?'.tr + " " + "  ",
                        secondText: 'send it again'.tr,
                        onTap: () {
                          Get.back();
                          login();
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

/**
    Future<dynamic> verifying(
    BuildContext context  ) {
    pinCodeController.value.clear();
    update();
    return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
    ),
    context: context,
    builder: (context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
    height: Get.height / 2.5,
    child: Column(
    children: [
    SizedBox(
    height: 20.h,
    ),
    SizedBox(
    width: 51.w,
    child: Container(
    height: 5,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: Common.getDarkMode()
    ? Colors.white.withOpacity(0.2)
    : Color(0xFFDBDBDB),
    ),
    )),
    SizedBox(
    height: 15.h,
    ),
    CustomText(
    text: "verify_mobile_number".tr,
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    height: 30 / 18, // line height = 30px / font size = 16px
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(
    height: 10.h,
    ),
    CustomText(
    text: "enter_code_sent_mobile".tr,
    textAlign: TextAlign.center,
    style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(fontSize: 11.sp),
    ),
    SizedBox(
    height: 20.h,
    ),
    Container(
    padding: EdgeInsets.symmetric(horizontal: 45),
    child: PinCodeTextField(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    appContext: context,
    autoDisposeControllers: false,
    animationType: AnimationType.fade,
    controller:  pinCodeController.value,
    enableActiveFill: true,
    cursorColor: Theme.of(context).primaryColor,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    pinTheme: PinTheme(
    shape: PinCodeFieldShape.box,
    fieldWidth: 50,
    inactiveFillColor: Common.getDarkMode()
    ? Colors.white.withOpacity(0.09)
    : Color(0xFFF3F4F5),
    activeFillColor: Common.getDarkMode()
    ? Colors.white.withOpacity(0.05)
    : Color(0xFFF3F4F5),
    selectedColor: Common.getDarkMode()
    ? Colors.white.withOpacity(0.05)
    : Color(0xFFF3F4F5),
    selectedFillColor: Common.getDarkMode()
    ? Colors.white.withOpacity(0.05)
    : Color(0xFFF3F4F5),
    inactiveColor: Common.getDarkMode()
    ? Colors.white.withOpacity(0.05)
    : Color(0xFFF3F4F5),
    activeColor: Common.getDarkMode()
    ? Colors.white.withOpacity(0.05)
    : Color(0xFFF3F4F5),
    borderWidth: 0,
    borderRadius: BorderRadius.circular(5),
    ),
    length: 4,
    onCompleted: (val)async{
    Get.back();
    valueCode = val;

    await  Verify(context , valueCode,mobile);
    },
    textStyle: TextStyle(

    ),
    onChanged: (String value) {
    valueCode = value;
    update();
    },
    ),
    ),
    SizedBox(
    height: 10.h,
    ),
    Container(
    margin: EdgeInsets.symmetric(horizontal: 75.w),
    child: CustomButton(
    onPressed:()async{

    await  Verify(context , valueCode,mobile);
    },
    text: 'Verify'.tr,
    ),
    ),
    SizedBox(
    height: 20.h,
    ),
    RichTexts(
    firstText: 'dont_receive_code'.tr + " "+ "  ",
    secondText: 'send it again'.tr,
    onTap: (){
    Get.back();
    login();
    },
    ),
    ],
    ),
    ),
    ));
    }
 */
}
