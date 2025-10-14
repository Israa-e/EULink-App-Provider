import 'package:flutter/material.dart';
import 'package:get/get.dart' ;
 import 'package:permission_handler/permission_handler.dart';

class ShowDialogPermissionDenied extends StatelessWidget {
  String title;

  String body;

  ShowDialogPermissionDenied(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title.tr ,style: TextStyle(color: Colors.black),),
      content: Container(width: double.infinity, child: Text(body.tr )),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'cancel'  ),
          child:   Text('cancel'.tr ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'cancel');
            openAppSettings();
          },
          child: Text('settings'.tr ),
        ),
      ],
    );
  }
}
