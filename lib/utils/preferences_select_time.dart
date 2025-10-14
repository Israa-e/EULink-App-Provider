import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'common.dart';

class PreferencesSelectTime extends StatefulWidget {
  String _title;
  TimeOfDay _timeOfDay;
  Function _updateTimeFunction;

  PreferencesSelectTime(this._title, this._timeOfDay, this._updateTimeFunction);

  @override
  PreferencesSelectTimeState createState() =>
      PreferencesSelectTimeState(_title, _timeOfDay, _updateTimeFunction);
}

class PreferencesSelectTimeState extends State<PreferencesSelectTime> {
  String _title;
  TimeOfDay _timeOfDay;
  Function _updateTimeFunction;

  PreferencesSelectTimeState(
      this._title, this._timeOfDay, this._updateTimeFunction);

  @override
  Widget build(BuildContext context) {
    print("tite # " + _title);
    var newTod;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: Common.getDarkMode() == true ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark ,// or use SystemUiOverlayStyle.light
          elevation: 0,
          title: Text(""),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                if (newTod != null) _updateTimeFunction(newTod);
                Get.back();
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(end: 8),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<TimeOfDay>(
            future: getStartTime(_timeOfDay, _title),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print("ddccc # " + _timeOfDay.hour.toString());
                print("ddccc # " + snapshot.data.hour.toString());

                return Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(
                          1969, 1, 1, snapshot.data.hour, snapshot.data.minute),
                      onDateTimeChanged: (DateTime newDateTime) {
                        newTod = TimeOfDay.fromDateTime(newDateTime);
                      },
                      use24hFormat: false,
                      minuteInterval: 1,
                    ));
              } else {
                return new CircularProgressIndicator();
              }
            }));
  }

  Future<TimeOfDay> getStartTime(TimeOfDay time, String title) async {
    if (_title.split(":").length == 2) {
      print("22222");
      int from = int.tryParse(_title.split(":").first) ?? 0;
      int to = int.tryParse(_title.split(":").last) ?? 0;

      print("from " + from.toString() + " to " + to.toString());
      time = TimeOfDay.fromDateTime(
          DateTime.parse("2023-01-01 " + _title.trim() + ":00"));
      print("ddd # " + time.hour.toString());
      return await TimeOfDay(hour: time.hour, minute: time.minute);
    } else
      return await TimeOfDay(hour: time.hour, minute: time.minute);
  }
}
