import 'package:anitcorona/Controllers/StreamControllers.dart';
import 'package:anitcorona/classes/MyNeabyUsers.dart';
import 'package:flutter/material.dart';

class MyTotalContacts extends StatefulWidget {
  @override
  _MyTotalContactsState createState() => _MyTotalContactsState();
}

class _MyTotalContactsState extends State<MyTotalContacts> {
  @override
  void initState() {
    MyStreamControllers.myScannedNearByUsersListner.resume();
    MyStreamControllers.myScannedUnknowsUsersListner.resume();
    MyStreamControllers.myScannedNearByUsersListner.onData((data) {
      setState(() {
        print(data);
      });
    });
    MyStreamControllers.myScannedUnknowsUsersListner.onData((data) {
      setState(() {
        print(data);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    MyStreamControllers.myScannedNearByUsersListner.pause();
    MyStreamControllers.myScannedUnknowsUsersListner.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        key: ValueKey<bool>(false),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        duration: Duration(milliseconds: 300),
        child: Text(
          "${MyNearbyUser.myUsers.length}",
          key: ValueKey<int>(MyNearbyUser.myUsers.length),
          style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20),
        ));
  }
}
