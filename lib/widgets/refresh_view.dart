
import 'package:provider/widgets/waterdrop_header_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshView extends StatelessWidget {
  bool enablePullDown =false;
  bool enablePullUp =false ;
  RxBool isLoadMore = false.obs;
  RefreshController refreshController  =
  RefreshController(initialRefresh: false);
  void Function()? onRefresh ;
  void Function()? onLoading ;
  Widget child =Container();

  RefreshView({required this.enablePullDown, required this.enablePullUp,
    required this.isLoadMore,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return  SmartRefresher(
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      header: CustomWaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = (!isLoadMore.value)
                ? Text("pull_up_load".tr )
                : Text("");
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator(
              color: Get.isDarkMode == true ?Colors.white70 : Colors.black87,
            );
          } else if (mode == LoadStatus.failed) {
            body = Text("load_failed_click_retry".tr );
          } else if (mode == RefreshStatus.completed) {
            body = Text("refresh_complete".tr );
          } else if (mode == LoadStatus.canLoading) {
            body = Container();//Text("release_to_load_more".tr );
          } else {
            body = Text("No_more_data".tr );
          }
          return Container(
            height: 55.0,

            child: Center(child: body),
          );
        },
      ),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child:child
          ,
    );
  }
}
