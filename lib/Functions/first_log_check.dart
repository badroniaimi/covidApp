// import 'package:anitcorona/pages/LoadingPage.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../style/global.dart';
//
// class FirstLog {
//   firstLogCheck() async {
//     bool loginCheck = await getLoginFlag();
//     print(loginCheck);
//     return loginCheck;
//   }
//
//   static setLoginFlag() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setBool('alreadyLogin', true);
//   }
//
//   getLoginFlag() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     bool alreadyLogin = preferences.getBool('alreadyLogin') ?? false;
//     return alreadyLogin;
//   }
// }
//
// class FirstLogCheck extends StatefulWidget {
//   @override
//   _FirstLogCheck createState() => _FirstLogCheck();
// }
//
// class _FirstLogCheck extends State<FirstLogCheck> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: (new FirstLog()).firstLogCheck(),
//         // ignore: missing_return
//         builder: (BuildContext coontext, AsyncSnapshot snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               print('waiting');
//               return new Center(child: new CircularProgressIndicator());
//               break;
//
//             case ConnectionState.done:
//               print('done');
//               if (snapshot.hasError) {
//                 return (Center(
//                   child: RichText(
//                     text: TextSpan(
//                       text: "Please reopen the app",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 50,
//                       ),
//                     ),
//                   ),
//                 ));
//               } else {
//                 print('in the future Builder');
//                 if (snapshot.data) {
//                   return MaterialApp(
//                     title: 'Covid19 Fstt',
//                     theme: ThemeData(
//                       primaryColor: appBarColor,
//                     ),
//                     home: MyLoadingPage(),
//                   );
//                 } else {
//                   return MaterialApp(
//                     title: 'Covid19 Fstt',
//                     theme: ThemeData(
//                       primaryColor: appBarColor,
//                     ),
//                     home: MyLoadingPage(),
//                   );
//                 }
//               }
//               break;
//             default:
//               return (Center(
//                 child: RichText(
//                   text: TextSpan(
//                     text: "Please reopen the app,none",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 50,
//                     ),
//                   ),
//                 ),
//               ));
//               break;
//           }
//         });
//   }
// }
