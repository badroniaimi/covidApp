import 'dart:async';

import 'package:device_info/device_info.dart';

import 'DataFileJSON.dart';

class MyBluetooth {
  static int theDurationForTheScanInSecond = 120;
  static int timeBetweenEachScan = 123;
  static StreamSubscription? myStreamingOfScan;
  static int whenToWrite = 900;
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  ///This will start scanning the bluetooth, and the data will be
  ///stored into[StreamSubscription] as [myStreamingOfScan]
  ///and [myDevicesScanned] which is a [Map]
  ///then after [whenToWrite] value it will start
  ///[MyDataFileJsonFunction.writeThatDocumentJSON]
  ///as a map with keys [Name,Power,Rssi,ID,Type]
  // static StreamSubscription? myBluetoothStartScanning() {
  //   try {
  //     myBluetoothInit.startScan(
  //         timeout: Duration(seconds: theDurationForTheScanInSecond));
  //     myStreamingOfScan = myBluetoothInit.scanResults.listen((event) async {
  //       event.forEach((element) {
  //         MyScannedUsers.addUser(
  //             MyScannedUsers(element.device.name, element.device.id.id),
  //             thisScan: MyScans(
  //                 DateTime.now(),
  //                 element.advertisementData.txPowerLevel,
  //                 element.rssi.toString(),
  //                 element.device.type.index,
  //                 5));
  //       });
  //       if (event.isNotEmpty)
  //         await MyDataFileJsonFunction.addAllUsersToTheFile();
  //     });
  //     Future restartTheScan() async {
  //       await Future.delayed(Duration(seconds: timeBetweenEachScan), () async {
  //         await myBluetoothInit.stopScan();
  //         myStreamingOfScan!.pause();
  //         await Future.delayed(Duration(seconds: 2));
  //         try {
  //           myBluetoothInit.startScan(
  //               timeout: Duration(seconds: theDurationForTheScanInSecond));
  //         } catch (e) {}
  //         myStreamingOfScan!.resume();
  //       });
  //       restartTheScan();
  //     }
  //
  //     //This to keep the process alive;
  //     //ToDo This create's errors
  //     restartTheScan();
  //
  //     ///TODO add timer for the contact here in this class
  //     //  Future.delayed(Duration(seconds: ))
  //     return myStreamingOfScan;
  //   } catch (e) {}
  //   myBluetoothInit.stopScan().then((value) {
  //     myStreamingOfScan = MyBluetooth.myBluetoothStartScanning();
  //   });
  // }

  ///this will init all the Scaners and the services by calling [MyDataFileJsonFunction.initReadersAndWriters]
  ///and add some info [deviceInfo.androidInfo]
  static Future initTheAppWithJson() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    await MyDataFileJsonFunction.initReadersAndWriters({
      "Name": androidInfo.display,
      "UserID": androidInfo.id,
    });
  }
}
