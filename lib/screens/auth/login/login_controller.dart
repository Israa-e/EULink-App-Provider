import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/screens/auth/choose_service/choose_service.dart';
import 'package:provider/screens/auth/complete_profile/complete_profile.dart';
import 'package:provider/screens/menu_screens/subscription_case/subscription_case.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/helper.dart';
import 'package:provider/utils/loading.dart';
import 'package:provider/widgets/custom_button.dart';
import 'package:provider/widgets/custom_text.dart';
import 'package:provider/widgets/rich_text.dart';
//import 'package:telephony/telephony.dart';

import '../../../models/authentication/login_response.dart';
import '../../../models/authentication/provider.dart';
import '../../../models/install/country_model.dart';
import '../../../models/splash/splash_response.dart';
import '../../menu_screens/subscription/subscription.dart';
import '../../pager/pager.dart';
import 'login_screen.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  Rx<TextEditingController> pinCodeController = new TextEditingController().obs;

  Rx<TextEditingController> mobileController = new TextEditingController().obs;

  RxList<Country>? countries = RxList<Country>([]);
  Rx<Country?> selectedCountry = Rx<Country?>(null);

  // Rx<TextEditingController> passwordController = new TextEditingController().obs;

  bool isSecure = false;

  int steps = 0;

  FirebaseMessaging? _firebaseMessaging = null;
  String _token = "";

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

  @override
  void onInit() async {
    super.onInit();
    disableCapture();
    setCountries();
    controllerDown = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.getToken().then((token) async {
      _token = token!;
      await Common.setDeviceToken(DeviceToken: _token);
      print(_token);

      //Loading.show();
    });
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
      telephony.listenIncomingSms(onNewMessage: onMessage, onBackgroundMessage: null,listenInBackground: false
      );
      print("msgSMS # "+message.toString());
    }else{
      telephony.listenIncomingSms(onNewMessage:onMessage, onBackgroundMessage: null,listenInBackground: false);
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

  setCountries() async {
    countries?.value = (Common.getSplash()?.data.countries)!;
    selectedCountry.value = countries?.first;
    update();
    log('selectedCountry.value?.id ${selectedCountry.value?.id}');
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

  Future<void> login() async {
    if (_token.isEmpty) {
      _firebaseMessaging = FirebaseMessaging.instance;
      _firebaseMessaging!.getToken().then((token) async {
        _token = token!;
        await Common.setDeviceToken(DeviceToken: _token);
      });
    }

    update();

    if (mobileController.value.text.length  >= 9) {
      mobile = mobileController.value.text.toString();

      mobile = replaceEnglishNumber(mobile);
      try {
        Loading.show();
        await Get.find<AuthApi>().LoginRegister(
            emailPhone: mobile,
            country_id: selectedCountry.value?.id.toString(),
        token: _token)
          ..fold(onError, onSuccess);
      } catch (e) {
        print(e);
      }
    } else {
      print("not to work");
    }
  }

  onSuccess(LonginResponse data) async {
    Loading.hide();

    update();
    print("Success");
   // initPlatformState();
    await Future.delayed(Duration(milliseconds: 200), () {});
    if (data.success == true) {
      //await SmsAutoFill().listenForCode();
      verifyingLogin(Get.context! as BuildContext );

      // Helper.ShowSnackBarSuccess(title: "Logged Successfully", body: "Logged Successfully");
    }

    update();
  }

  onError(failure) async {
    Loading.hide();
    await Future.delayed(Duration(milliseconds: 200), () {});

    print("failure.toString():( :(  ${failure.toString()}");


    Helper.ShowSnackbarFailureCenter(
        title: "Error".tr, body: handlingFailureRespose(failure));
  }

  Future<void> Verify(context, String code ,mobile) async {

    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(Duration(milliseconds: 200), () {});
    Loading.show();

    update();

     print("data Login #  " +mobile );
    await Get.find<AuthApi>().Verify(
        mobile: mobile,
        code: code,
        country_id: selectedCountry.value!.id.toString())
      ..fold(onErrorVerify, onSuccessVerify);
  }

  onSuccessVerify(ProviderResponse data) async {
    Loading.hide();
    update();
    await Future.delayed(Duration(milliseconds: 300), () {});
    print("data.data ${data.toJson()}");
    if (data.success != false) {


      await Common.setUserModel(user: data  ).then((value) {
        if( Common.getUser()!.data!.provider!.hourlyRate != null &&  Common.getUser()!.data!.provider!.services != null
            && Common.getUser()!.data!.provider!.services!.length>0){
          if(Common.getUser()!.data!.provider!.subscriptionStatus ==false){
            Get.offAll(Subscription(),
                transition: Transition.fade,
                duration: const Duration(milliseconds: 300),
                arguments: [true]);
          }else {
            if(Common.getUser()!.data!.provider!.subscriptionStatus ==true &&
                Common.getUser()!.data!.provider!.subscription != null &&
                Common.getUser()!.data!.provider!.subscription!.status ==0 ){


              Get.offAll(() => const SubscriptionCase( ),
                  transition: Transition.fade ,
                  arguments: [true]);
            }else {

              Get.offAll(() => const Pager(selected: 0),
                  transition: Transition.fade);
            }
          }
        }else{
          if(Common.getUser()!.data!.provider!.hourlyRate == null){
            Get.offAll(() => const CompleteProfile(), transition: Transition.fade) ;

          }
          else if(   Common.getUser()!.data!.provider!.services == null
              || Common.getUser()!.data!.provider!.services!.length==0){
            Get.offAll(() => const ChooseService( ), transition: Transition.fade,
                arguments: ["add"]) ;


          }else{
            Get.offAll(() => const CompleteProfile(), transition: Transition.fade) ;

          }
        }
      });

     // Get.offAll(() => Pager(selected: 0));
    } else {

      print(data.message.toString() +"  HEREEEE IAM ");
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

    verifyingLogin(Get.context as BuildContext);
  }

  String mobile = "";
  bool displayInfo = false;


  Future<dynamic> verifyingLogin(
      BuildContext context  ) {
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
       return  Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
           // height: Get.height / 2.5,
            child: Column(
             mainAxisSize: MainAxisSize.min,
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
                    height: 30 / 18, // line height = 30px / font size = 16px
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




                        valueCode = val;
                        update();
                        setState(() {});
                        if (valueCode.length == 4) {
                          Get.back();
                          await Verify(context, valueCode, mobile);
                        }

                      },
                      textStyle: TextStyle(

                      ),
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
                    onPressed:()async{
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichTexts(
                    firstText: 'Don’t receive your code?'.tr + " "+ "  ",
                    secondText: 'send it again'.tr,

                    onTap: (){
                      Get.back();
                       login();
                    },
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
       );
        }
        ));
  }

}
