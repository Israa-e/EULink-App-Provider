import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/core/connection_service/api/auth_api.dart';

import '../../core/theme/dark_theme.dart';
import '../../utils/common.dart';
import '../../utils/helper.dart';
import '../home/home_orders/home_orders.dart';
import '../menu_screens/menu/menu.dart';
import '../notifications/notifications.dart';

class Pager extends StatefulWidget {
  final int selected;

  const Pager({Key? key, required this.selected}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  int _selectedScreenIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.selected ==null) {
      _selectedScreenIndex = 0;
    } else {
      _selectedScreenIndex = widget.selected;
    }

    updateDeviceTokenWebService();

  }

  final List _screens = [
    {"screen": const HomeOrders(), "title": "Home Screen"},
    {"screen": const Notifications(), "title": "Order Screen"},
    {"screen": const Menu(), "title": "Menu Screen"},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
   /** SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));*/
    changeStatusBarColor();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset : true,
      appBar: null,
      body:/** AnnotatedRegion<SystemUiOverlayStyle>(
        value: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child:  _screens[_selectedScreenIndex]["screen"],
      ),*/
      _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: Container(
       // height: MediaQuery.of(context).size.height/10,
        decoration: BoxDecoration(

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                offset: const Offset(0, 0),
              )
            ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            topLeft: Radius.circular(20.r),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 10.sp,
            unselectedFontSize: 10.sp,
            backgroundColor: Common.getDarkMode() ? primaryDarkColor.withOpacity(0.05)  : Theme.of(context).appBarTheme.backgroundColor,
            currentIndex: _selectedScreenIndex,
            onTap: _selectScreen,
            unselectedItemColor: const Color(0xFFD6DADE),
            selectedIconTheme:   IconThemeData(color: Theme.of(context).primaryColor),
            selectedItemColor: Theme.of(context).primaryColor,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 12.0,top: 8),
                    child: SvgPicture.asset(
                      "assets/icons/home_icon.svg",
                      //width: 29.w,
                     // height: 25.89.h,
                      color: _selectedScreenIndex == 0
                          ? Theme.of(context).primaryColor
                          : Color(0xFFD6DADE),
                    ),
                  ),
                  label: "Services".tr),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 12.0,top: 8),
                    child: SvgPicture.asset(
                      "assets/icons/notifications_icon.svg",
                     // width: 23.w,
                    //  height: 26.h,
                      color: _selectedScreenIndex == 1
                          ? Theme.of(context).primaryColor
                          : Color(0xFFD6DADE),
                    ),
                  ),
                  label: "Notifications".tr),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 12.0,top: 8),
                    child: SvgPicture.asset(
                      "assets/icons/menu_icon.svg",
                     // width: 20.w,
                    //  height: 20.h,
                      color: _selectedScreenIndex == 2
                          ? Theme.of(context).primaryColor
                          : Color(0xFFD6DADE),
                    ),
                  ),
                  label: "Menu".tr),
            ],
          ),
        ),
      ),
    );
  }



  Future updateDeviceTokenWebService() async{
    if(Common.getDeviceToken() != null)
      await Get.find<AuthApi>().updateDeviceToken()
      ..fold((e){}, (data){});
  }

}
