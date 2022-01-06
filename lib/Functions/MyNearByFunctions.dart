import 'package:anitcorona/classes/MyNeabyUsers.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:geolocator/geolocator.dart';

///This class is for creating the nearby detection
///[Nearby]
class MyNearByFunctions {
  static final Strategy strategy = Strategy.P2P_CLUSTER;
  static final nearbyService = NearbyService();
  static final devices = <Device>[];

  ///This will start all the work with the current [MyUser.me] [TempID]
  ///so when ever the currentID changes the app must call [restartWorking]
  ///to start working with the new ID
  static Future startWorking() async {
    await startAdvertising();
    // await whenWeFoundADevice();
  }

  static Future stopWorking() async {
    await nearbyService.stopAdvertisingPeer();
    await nearbyService.stopBrowsingForPeers();
  }

  static Future restartWorking() async {
    await stopWorking();
    await startWorking();
  }

  static Future initNearBy() async {
    await nearbyService.init(
        serviceType: 'FST_COVID_APP',
        strategy: strategy,
        callback: () {},
        deviceName: MyUser.me.id!);
    _initAll();
  }

  static Future _initAll({int forHowLongSecond = 10}) async {
    restartWorking();
    Future.delayed(Duration(seconds: forHowLongSecond), _initAll);
  }

  //this will check the Permission of the app before start working
  // static Future<bool> setDataAndPermission() async {
  //   bool R = false;
  //   await Future.delayed(Duration(milliseconds: 300));
  //   nearBy.Nearby().askLocationPermission();
  //   await Future.delayed(Duration(milliseconds: 300));
  //   R = await nearBy.Nearby().checkLocationEnabled();
  //   if (!R) nearBy.Nearby().enableLocationServices();
  //   if (R) return await MyBluetooth.myBluetoothInit.isAvailable ? true : false;
  //   setDataAndPermission();
  //   return true;
  // }

  ///this to start the advertising
  static Future<bool> startAdvertising() async {
    late String sendingWhat;

    // start scanning
    nearbyService.startAdvertisingPeer();
    nearbyService.startBrowsingForPeers();
    nearbyService.stateChangedSubscription(callback: (devicesList) {
      // once we got the scan
      devices.clear();
      devices.addAll(devicesList);
      // send to them all
      devices.forEach((element) async {
        // detect user
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((value) {
          String mySendingData =
              value.latitude.toString() + ',' + value.longitude.toString();
          MyNearbyUser.detectUser(element.deviceName, mySendingData);
        });

        nearbyService.invitePeer(
            deviceID: element.deviceId, deviceName: element.deviceName);

        sendDataGL(element.deviceId).then((value) {
          sendingWhat = value;
        });
      });
    });
    nearbyService.dataReceivedSubscription(callback: (message) {
      print(message);
      var id = message['deviceId'];
      var msg = message['message'] as String;
      var latitude = msg.split(',')[0];
      var longitude = msg.split(',')[1];
      var userId = msg.split(',')[2];
      var name = msg.split(',')[3];
      var phoneNumber = msg.split(',')[4];
      var address = msg.split(',')[5];
      var email = msg.split(',')[6];
      var userType = msg.split(',')[7];
      MyNearbyUser.addUser(userId, "$latitude,$longitude", sendingWhat, name,
          phoneNumber, address, email, UsersType.values[int.parse(userType)]);
    });
    return true;
  }

  ///this will send the location to this user ID
  ///it will get the data that been sent to the userID
  static Future<String> sendDataGL(String id) async {
    Position myPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String mySendingData = myPosition.latitude.toString() +
        ',' +
        myPosition.longitude.toString() +
        ',' +
        MyUser.me.id![0] +
        ',' +
        MyUser.me.name! +
        ',' +
        MyUser.me.phoneNumber! +
        ',' +
        " " +
        ',' +
        MyUser.me.email! +
        ',' +
        (MyUser.me.usersType?.toString() ?? UsersType.None.toString());
    nearbyService.sendMessage(id, mySendingData);
    return mySendingData;
  }
}
