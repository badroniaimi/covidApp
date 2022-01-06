import 'package:anitcorona/Animation/FeedAnimations.dart';
import 'package:anitcorona/Auth/MyGoogleAuth.dart';
import 'package:anitcorona/Controllers/UserControllers.dart';
import 'package:anitcorona/Controllers/staticControler.dart';
import 'package:anitcorona/Global/GlobalKeys.dart';
import 'package:anitcorona/Widgets/LoadingWidgets.dart';
import 'package:anitcorona/classes/MyUser.dart';
import 'package:anitcorona/pages/buttom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyLoadingPage extends StatefulWidget {
  @override
  _MyLoadingPageState createState() => _MyLoadingPageState();
}

class _MyLoadingPageState extends State<MyLoadingPage> {
  final scaKey = GlobalKey<ScaffoldState>();
  void _startLoading() async {
    await MyUserController.initAllUserInfoAfterAutoLogin();
    await StaticController.loadFromAPI();
    // MyUser.me.startAdvertisingTheUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomNavBar()));
  }

  ///This will handel init the user TempID
  ///if[ MyUser.getIfUserChecked]
  ///by calling [TempID.loadFromSharedPrf]
  ///and then it will call [_startLoading]
  ///else call [CheckCode]
  void createUser() async {
    _startLoading();
    // MyUser.me.currentID = TempID(
    //     '1554-16445-41787-AA41',
    //     DateTime.now().millisecondsSinceEpoch,
    //     DateTime.now().add(Duration(days: 30)).millisecondsSinceEpoch);
    // if (await MyUser.getIfUserChecked()) {
    //   await TempID.loadFromSharedPrf();
    //   MyUser.me.currentID = TempID.allID[0];
    //
    //   // print(MyUser.me.currentID.tempId);
    //   _startLoading();
    // } else {
    //   CheckCode()
    //       .showThisDialog(context, (onNOPASSWORD) => () {})
    //       .then((value) => !PhoneRequst.showAgain ? createUser() : phoneAuth());
    // }
  }

  ///This will handel phone auth
  void phoneAuth() async {
    createUser();
    // MyUser.me.phoneNumber == null || MyUser.me.phoneNumber.isEmpty
    //     ? await PhoneRequst()
    //         .showThisDialog(context, (onNOPASSWORD) => null)
    //         .then((value) async {
    //         if (PhoneRequst.showAgain)
    //           phoneAuth();
    //         else
    //           createUser();
    //       })
    //     : createUser();
  }

  void initLoading() async {
    await Firebase.initializeApp();
    if (await MyFirebaseAuth.doAutoSign()) {
      _startLoading();
    }

    // if (!await MyUser.getIfUserChecked() || MyUser.me.phoneNumber == null)
    //   phoneAuth();
    // else {
    //   ///ToDo this need to be tested
    //   //reload the data
    //   await TempID.loadFromSharedPrf();
    //   MyUser.me.currentID = TempID.allID[0];
    //
    // }
  }

  @override
  void initState() {
    MyGlobalKeys.myGlobalScaKey = scaKey;
    super.initState();
    Future.delayed(Duration(seconds: 2), initLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FeedAnimation(Image.asset('assets/images.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Welcome_While_Loading(),
          )
        ],
      ),
    );
  }
}
