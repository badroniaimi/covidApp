import 'package:anitcorona/Controllers/NotificationsController.dart';
import 'package:anitcorona/Database/RealTimeDatabase.dart';
import 'package:anitcorona/Functions/Bluetooth.dart';
import 'package:anitcorona/Functions/MyNearByFunctions.dart';
import 'package:anitcorona/Notifications/initNotf.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StreamControllers.dart';

class MyUserController {
  static String _cin = '';
  static const _CinKey = "CIN";

  static Future initAllUserInfoAfterAutoLogin() async {
    await MyNotifications.initNotifications();
    await MyBluetooth.initTheAppWithJson();
    await initializeDateFormatting();

    MyStreamControllers.initStreamControllers();
    // MyBluetooth.myBluetoothStartScanning();
    await MyNotificationsController.init();
    await MyNearByFunctions.initNearBy();
    await MyNotificationsController.initPRNotification();
    // MyBackgroundProcess.init(onReceiveData: (Map<String, dynamic> data) {
    //   MyStreamControllers.myScannedNearByUsersCont.sink.add(data['id']);
    // });
    // async info
    await loadCIN();
    await MyRealTimeDatabaseActions.uploadUserInfo(MyUser.me.toMap());
    // async Token
    await MyRealTimeDatabaseActions.uploadUserInfoToken(MyUser.me.token);
  }

  static Future<void> loadCIN() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(_CinKey)) {
      _cin = (sp.getString(_CinKey))!;
    }
  }

  static Future<void> saveCIN(String cin) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_CinKey, cin);
  }

  static String get cin => _cin;
}

showUserCINUI(BuildContext context) async {
  final _codeController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  //show dialog to take input from the user
  showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Text("Enter CIN"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 8,
                  controller: _codeController,
                ),
              ],
            ),
            actions: <Widget>[
              RoundedLoadingButton(
                controller: _btnController,
                child: Text("Save"),
                color: Colors.redAccent,
                onPressed: () async {
                  _btnController.start();
                  await MyUserController.saveCIN(_codeController.text);
                  await MyUserController.loadCIN();
                  Navigator.pop(context);
                },
              )
            ],
          ));
}
