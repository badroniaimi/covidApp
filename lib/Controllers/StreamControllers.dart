import 'dart:async';

class MyStreamControllers {
  // ignore: close_sinks
  static StreamController myScannedUnKnownUsersCont = StreamController();
  // ignore: close_sinks
  static StreamController myScannedNearByUsersCont = StreamController();
  // ignore: cancel_subscriptions
  static late StreamSubscription myScannedNearByUsersListner;
  // ignore: cancel_subscriptions
  static late StreamSubscription myScannedUnknowsUsersListner;

  static initStreamControllers() {
    myScannedNearByUsersListner =
        myScannedNearByUsersCont.stream.listen((event) {});
    myScannedUnknowsUsersListner =
        myScannedUnKnownUsersCont.stream.listen((event) {});
  }
}
