import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/main.dart';
import 'package:provider/models/order/order_response.dart';
import 'package:provider/models/order/showOrderByIdResponse.dart';
import 'package:provider/utils/call_back_notification.dart';
import 'package:provider/utils/utils.dart';
import 'package:provider/widgets/dialog_permission_denied.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/core/connection_service/api/chat_api.dart';
import 'package:provider/models/chat/chat_response.dart';
import 'package:provider/models/chat/chats_response.dart';
import 'package:provider/models/chat/message_model.dart';
import 'package:provider/models/install/paging_model.dart';

import '../../../core/connection_service/api/order_api.dart';
import '../../../utils/common.dart';
import '../../../utils/helper.dart';

class ChatController extends GetxController {
  var isLoading;
  Order? order;

  int? order_id;

  bool canBack = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments != null && Get.arguments[0] != null) {
      if (Get.arguments[0] is Order) {
        order = Get.arguments[0] as Order;
        getChatMessagesByOrderIdWebService();
      } else if (Get.arguments[0] is int) {
        order_id = Get.arguments[0];
        order = new Order();
        order!.id = order_id;
        getChatMessagesByOrderIdWebService();
        getOrdersData(order_id);
      }
      if (Get.arguments != null && Get.arguments[1] != null &&
          Get.arguments[1] is bool) {
        canBack = Get.arguments[1];

        update();
      }
    }


    /**  if(Get.arguments   != null && Get.arguments[0] !=null){
        order = Get.arguments[0]  ;
        }
        getChatMessagesByOrderIdWebService();*/


    changeMessageController = StreamController<ListinMessageNotification>();
    changeMessageController.stream.listen((e) {
      page = 1;
      getChatMessagesByOrderIdWebService();
      update();
    });
  }


  Future getOrdersData(id) async {
    isLoading = true.obs;
    print("Hi ::::::::");
    update();
    print('id $id');
    return await Get.find<OrderApi>().ShowOrderDataById(id: id)
      ..fold(onErrorOrder, onSuccessOrder);
  }

  onSuccessOrder(ShowOrderByIdResponse data) async {
    isLoading = false.obs;
    update();
    if (data != null) {
      order = data.data!.order;

      // paginationList =data.data?.ordersCollection?.pagination;
      // log('ordersList ${ordersList!.isEmpty?"ordersList is null hehehe":ordersList}');
      // log('paginationList ${paginationList}');
      // log("controller.ordersList.length ${ordersList?.length??" empty 00"}");
      print('data.data?.toJson() ${data.data?.toJson()}');
    } else {}
    update();
    update();
  }

  onErrorOrder(failure) async {
    isLoading = false.obs;
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
    int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  Future getChatMessagesByOrderIdWebService() async {
    if (page == 1) {
      isLoading = true.obs;
    } else {
      isLoadMore = true.obs;
    }
    print("Hi ::::::::");
    update();
    return await Get.find<ChatApi>().getChatMessagesByOrderId(
        id: order!.id!, page: page, per_page: per_page)
      ..fold(onError, onSuccess);
  }

  onError(failure) async {
    if (page == 1) {
      isLoading = false.obs;
    } else {
      isLoadMore = false.obs;
    }
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
    int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  // List<Orders>? ordersList = [];
  // var paginationList;
  List<Chat> chats = [];

  onSuccess(ChatsResponse data) async {
    if (page == 1) {
      isLoading = false.obs;
    } else {
      isLoadMore = false.obs;
    }
    update();


    if (data != null) {
      paginate = data.data!.chatsCollection!.pagination;
      if (page == 1) {
        chats = data.data!.chatsCollection!.chats!;
      } else {
        chats.addAll(data.data!.chatsCollection!.chats!);
      }
    } else {}
    update();
  }

  var isLoadingSend = false.obs;
  Rx<TextEditingController> editMessagecontroller =
      new TextEditingController().obs;

  Future sendMessageByOrderIdWebService(message, type) async {
    isLoadingSend = true.obs;
    editMessagecontroller.value.text = "";
    onMessageChanged();
    update();
    /** return await Get.find<ChatApi>().sendMessageByOrderId(id: order!.id!,message:message)
        ..fold(onErrorChat, onSuccessChat);*/

    if (type.toString() == "1") {
      return await Get.find<ChatApi>()
          .sendMessageByOrderIdFile(
          id: order!.id!, message: message, type: type)
        ..fold(onErrorChat, onSuccessChat);
    } else {
      return await Get.find<ChatApi>()
          .sendMessageByOrderId(id: order!.id!, message: message, type: type)
        ..fold(onErrorChat, onSuccessChat);
    }
  }

  onErrorChat(failure) async {
    isLoadingSend = false.obs;
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
    int status = (failure.toString().contains("Unauthenticated")) ? 401 : 0;
    update();
  }

  onSuccessChat(ChatResponse data) async {
    isLoadingSend = false.obs;

    update();

    if (data != null) {
      if (data.data!.chat != null) {
        chats.insert(0, data.data!.chat!);
        //  FlutterRingtonePlayer.playNotification();
      }
    } else {}
    update();
  }


  RxBool isMessageEmpty = true.obs;

  onMessageChanged() {
    isMessageEmpty.value =
    editMessagecontroller.value.text.isEmpty ? true : false;
    if (editMessagecontroller.value.text.length == 0 ||
        editMessagecontroller.value.text
            .toString()
            .length == 1
        || editMessagecontroller.value.text
            .toString()
            .length == 2)
      update();
  }

  int indexSelect = -1;


  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  int page = 1;

  int per_page = 20;

  //loade more and refresh
  Rx<ScrollController> scrollController = new ScrollController().obs;
  Pagination? paginate = null;
  RxBool isLoadMore = false.obs;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch


    await Future.delayed(Duration(milliseconds: 1000));
    if (!isLoadMore.value &&
        chats.length > 0 &&
        paginate != null &&
        paginate!.total! > chats.length) {
      if (!isLoadMore.value && !isLoadMore.value) {
        page = paginate!.currentPage! + 1;
        update();
        getChatMessagesByOrderIdWebService();
        update();
      }
    }

    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (!isLoadMore.value &&
        chats.length > 0 &&
        paginate != null &&
        paginate!.total! > chats.length) {
      if (!isLoadMore.value && !isLoadMore.value) {
        page = paginate!.currentPage! + 1;
        update();
        getChatMessagesByOrderIdWebService();
        update();
      }
    }

    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }


  bool emojiShowing = false;

  void setEmoji() {
    emojiShowing = !emojiShowing;
    update();
  }

  Widget ViewEmogi(context) {
    return emojiShowing == true
        ? Container(
      color: Colors.red,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
          onEmojiSelected: (Category? category, Emoji? emoji) {
            // Do something when emoji is tapped (optional)
            onMessageChanged();
          },
          onBackspacePressed: () {
            onMessageChanged();
            // Do something when the user taps the backspace button (optional)
          },
          textEditingController: editMessagecontroller.value,
          config: Config(
            columns: 7,
            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            initCategory: Category.RECENT,
            bgColor: Color(0xFFF2F2F2),
            indicatorColor: Colors.orangeAccent,
            iconColor: Colors.grey,
            iconColorSelected: Colors.orangeAccent,
            backspaceColor: Colors.orangeAccent,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
           // showRecentsTab: true,
            recentsLimit: 28,
            noRecents: Text(
              'No Recents'.tr,
              style: TextStyle(fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ),
            // Needs to be const Widget
            loadingIndicator: const SizedBox.shrink(),
            // Needs to be const Widget
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL,
          ),
        ),
      ),
    )
        : Container();

  }

  getImageFromGalary(context) async {
    getStoragePermission(onTrue:() async {
      getImage();

    }); /** PermissionStatus state = await Permission.storage.request();
     print(state.toString() + "sssss");
    if (state == PermissionStatus.permanentlyDenied   ) {
      showDialog(
        context: context,
        builder: (context) => new ShowDialogPermissionDenied(
            "Allow Permission", "The app needs permission to access storage!"),
      );
    } /**else if (state == PermissionStatus.denied) {
      showDialog(
        context: context,
        builder: (context) => new ShowDialogPermissionDenied(
            "Allow Permission", "The app needs permission to access storage!"),
      );
    } */ else if (state != PermissionStatus.granted) {
     // await Permission.storage.request();
      await Permission.storage.request();
    } else {
      getImage();
    }*/
  }

  cropNewImage() async {
    await Utils.pickImageFromGallery().then((pickedFile) async {
      // Step #2: Check if we actually picked an image. Otherwise -> stop;
      if (pickedFile == null) return;

      // Step #3: Crop earlier selected image
      await Utils.cropSelectedImageAttachments(pickedFile.path)
          .then((croppedFile) async {
        // Step #4: Check if we actually cropped an image. Otherwise -> stop;

        // Step #5: Display image on screen

        // image  = croppedFile.path  ;



        if (croppedFile != null) {
          _image = File(croppedFile.path);
          if (_image != null) {
            sendMessageByOrderIdWebService(_image!.path.toString(), 1);
          } else {
            isLoadingSend = false.obs;
          }
          // update();
        } else {
          isLoadingSend = false.obs;
        }

      });
    });
  }



  File? _image;
  final picker = ImagePicker();

  File get image => _image!;

  Future<void> getImage() async {
    isLoadingSend = true.obs;
    editMessagecontroller.value.text = "";
    onMessageChanged();
    update();

    cropNewImage();

    update();
  }

  void onClickMessageShow(Chat chatRoomMessage  ) {

    print("chatRoomMessage"+chatRoomMessage.toJson().toString());
    if(chatRoomMessage.message_type.toString() == "1" && chatRoomMessage.message!.isNotEmpty ) {
      ImageDialogTow(Get.context as BuildContext,
          [chatRoomMessage.message!.toString()],0);

    }

  }

}


class ImageDialog extends StatelessWidget {
  List<String> path;
  int index = 0;

  ImageDialog(this.path, this.index);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: index);

    return Stack(
      children: [
        PageView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (int i = 0; i < path.length; i++)
                PinchZoom(
                  resetDuration: const Duration(milliseconds: 100),
                  maxScale: 2.5,
                  onZoomStart: () {
                    print('Start zooming');
                  },
                  onZoomEnd: () {
                    print('Stop zooming');
                  },
                  child: CachedNetworkImage(
                    imageUrl: path[i].toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            // border: Border.all(
                            //   width: 20,
                            //   color: Colors.white
                            // ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: new DecorationImage(
                                fit: BoxFit.fitWidth,
                                image:
                                AssetImage("assets/image_not_found.png")))),
                  ),
                ),
            ]),
        Positioned.fill(
            top: 48,
            left: 16,
            right: 16,
            child: Align(
              alignment: Common.getLang() == "ar"
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    padding: Common.getLang() == "ar"
                        ? EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8)
                        : EdgeInsets.only(
                        left: 16, right: 8, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        color: Colors.black87, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
              ),
            ))
      ],
    );
  }
}

void ImageDialogTow(context, List<String> path, int index) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        backgroundColor: Colors.black87, body: ImageDialog(path, index)),
  );
}
