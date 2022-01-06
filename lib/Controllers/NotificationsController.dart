import 'package:anitcorona/Notifications/FCM.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class MyNotificationsController {
  static const notificationID = 101;
  static const channelID = 'channel';
  static init() async {
    await MyFCMController.init();
  }

  static initPRNotification() async {
    await AwesomeNotifications().cancel(99778);
    await AwesomeNotifications().cancel(notificationID);
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/logon',
        [
          NotificationChannel(
              channelKey: channelID,
              channelName: 'Anti Covid App',
              channelDescription: 'Scanning',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ]);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: notificationID,
            locked: true,
            channelKey: channelID,
            title: 'Anti Covid App',
            body: 'Scanning'));
  }
}
