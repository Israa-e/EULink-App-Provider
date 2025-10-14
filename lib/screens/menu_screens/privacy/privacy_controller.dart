import 'package:get/get.dart';
import 'package:provider/core/connection_service/api/install_api.dart';
import 'package:provider/models/install/pages_response.dart';

class PagesController extends GetxController{


  String key = "privacy" ;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if(Get.arguments != null && Get.arguments[0] != null){
      key = Get.arguments[0];
    }
    getPagesByKeyWebService();



  }
  var isLoading = false.obs ;
  Future getPagesByKeyWebService()async{

      isLoading = false.obs;

    update();
    return await Get.find<InstallApi>().getPagesByKey(key: key)
      ..fold(onError, onSuccess);
  }
  onError(failure) async {

      isLoading = true.obs;

    update();

    int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }
  Page? page;
  onSuccess(PagesResponse data) async {

      isLoading = true.obs;

    update();

    if (data != null) {
      if(data.data!.page !=null) ;
      page = data.data!.page ;

    } else {}

    print("page # "+page!.toJson().toString());
    update();
  }
}