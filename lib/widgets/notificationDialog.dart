 import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';

import '../models/notification/notification_model.dart';

class NotificationDialog extends StatelessWidget {
  Notification  item = new Notification();

  NotificationDialog(this.item);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        width: Get.width,
        decoration: new BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications ,size: 48,color : Colors.grey),
            Container(width: double.infinity,height: 2,color: Colors.grey.shade200,
              margin: EdgeInsets.symmetric(vertical: 8),),
            Text("" + item.title.toString()),
            Text("" + item.message.toString()),

            Container(width: double.infinity,height: 2,color: Colors.grey.shade200,
              margin: EdgeInsets.symmetric(vertical: 8),),
            Center(child: InkWell(
              onTap: (){
                Get.back();
              },
              child: Container(
                  padding: EdgeInsets.only(left: 24,right: 24,top: 4,bottom: 4),
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text("close".tr )),
            )),

          ],
        ),
      ),
    );
  }
}
