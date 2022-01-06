import 'package:anitcorona/Controllers/NotificationsController.dart';
import 'package:anitcorona/Functions/MyNearByFunctions.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class MyBackgroundProcess {
  static final service = FlutterBackgroundService();

  /// async data from the service
  /// save them into the file
  /// notify if the app is running
  static void _start() async {
    // start working
    await MyNearByFunctions.initNearBy();
    await MyNotificationsController.initPRNotification();
  }

  static Future<void> init(
      {required Function(Map<String, dynamic>) onReceiveData}) async {
    await FlutterBackgroundService.initialize(_start);
    // service.setAutoStartOnBootMode(true);
    // service.setForegroundMode(true);
    service.onDataReceived.forEach((element) {
      onReceiveData(element!);
    });
  }

  static void sendData(Map<String, dynamic> data) {
    FlutterBackgroundService().sendData(data);
  }
}
